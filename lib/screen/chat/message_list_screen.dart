import 'dart:developer';

import 'package:byourside/main.dart';
import 'package:byourside/model/message_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MessageListScreen extends StatefulWidget {
  const MessageListScreen({Key? key}) : super(key: key);

  @override
  State<MessageListScreen> createState() => _MessageListScreenState();
}

class _MessageListScreenState extends State<MessageListScreen> {
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('메세지 목록')),
      body: StreamBuilder<List<MessageModel>>(
        stream: streamMessages(), //중계하고 싶은 Stream을 넣는다.
        builder: (context, asyncSnapshot) {
          if (!asyncSnapshot.hasData) {
            //데이터가 없을 경우 로딩위젯을 표시한다.
            return const Center(child: CircularProgressIndicator());
          } else if (asyncSnapshot.hasError) {
            return const Center(
              child: Text('오류가 발생했습니다.'),
            );
          } else {
            List<MessageModel> messages = asyncSnapshot.data!; //비동기 데이터가 존재할 경우 리스트뷰 표시
            return Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                    child: ListView.builder(
                      // 상위 위젯의 크기를 기준으로 잡는게 아닌 자식위젯의 크기를 기준으로 잡음
                        itemCount: messages.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(messages[index].content),
                            subtitle: Text(messages[index].sendDate.toDate().toLocal().toString().substring(5,16)),
                          );
                        })),
                getInputWidget()
              ],
            );
          }
        },
      ),
    );
  }

  Widget getInputWidget() {
    return Container(
      height: 60,
      width: double.infinity,
      decoration: BoxDecoration(boxShadow: const [
        BoxShadow(color: Colors.black12, offset: Offset(0, -2), blurRadius: 3)
      ], color: Theme.of(context).bottomAppBarColor),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15,vertical: 8),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: TextField(
                controller: controller,
                decoration: InputDecoration(
                  labelStyle: TextStyle(fontSize: 15),
                  labelText: "내용을 입력하세요..",
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: BorderSide(
                      color: primaryColor,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: BorderSide(
                      color: Colors.black26,
                      width: 1.0,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(width: 10,),
            RawMaterialButton(
              onPressed: _onPressedSendButton, //전송버튼을 누를때 동작시킬 메소드
              constraints: BoxConstraints(
                  minWidth: 0,
                  minHeight: 0
              ),
              elevation: 2,
              fillColor: Theme.of(context).colorScheme.primary,
              shape: CircleBorder(),
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Icon(Icons.send),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _onPressedSendButton(){
    try{
      //서버로 보낼 데이터를 모델클래스에 담아둔다.
      //여기서 sendDate에 Timestamp.now()가 들어가는데 이는 디바이스의 시간을 나타내므로 나중에는 서버의 시간을 넣는 방법으로 변경하도록 하자.
      MessageModel messageModel = MessageModel(content: controller.text,sendDate: Timestamp.now());

      //Firestore 인스턴스 가져오기
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      //원하는 collection 주소에 새로운 document를 Map의 형태로 추가하는 모습.
      firestore.collection('chatrooms/rmTSYR79UlMiJo2wGVV8/messages').add(messageModel.toMap());

    }catch(ex){
      log('error)',error: ex.toString(),stackTrace: StackTrace.current);
    }
  }

  Stream<List<MessageModel>> streamMessages(){
    try{
      //찾고자 하는 컬렉션의 스냅샷(Stream)을 가져온다.
      final Stream<QuerySnapshot> snapshots = FirebaseFirestore.instance.collection('chatrooms/rmTSYR79UlMiJo2wGVV8/messages').orderBy('sendDate').snapshots();

      //새낭 스냅샷(Stream)내부의 자료들을 List<MessageModel> 로 변환하기 위해 map을 사용하도록 한다.
      //참고로 List.map()도 List 안의 element들을 원하는 형태로 변환하여 새로운 List로 반환한다
      return snapshots.map((querySnapshot){
        List<MessageModel> messages = [];//querySnapshot을 message로 옮기기 위해 List<MessageModel> 선언
        querySnapshot.docs.forEach((element) { //해당 컬렉션에 존재하는 모든 docs를 순회하며 messages 에 데이터를 추가한다.
          messages.add(
              MessageModel.fromMap(
                  id:element.id,
                  map:element.data() as Map<String, dynamic>
              )
          );
        });
        return messages; //QuerySnapshot에서 List<MessageModel> 로 변경이 됐으니 반환
      }); //Stream<QuerySnapshot> 에서 Stream<List<MessageModel>>로 변경되어 반환됨

    }catch(ex){//오류 발생 처리
      log('error)',error: ex.toString(),stackTrace: StackTrace.current);
      return Stream.error(ex.toString());
    }
  }
}