import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../model/db_set.dart';

class MyBlock extends StatefulWidget {
  MyBlock({Key? key}) : super(key: key);
  final Color primaryColor = Color(0xFF045558);
  final String title = "사용자 차단";

  @override
  State<MyBlock> createState() => _MyBlockState();
}

class _MyBlockState extends State<MyBlock> {
  final TextEditingController _nickname = TextEditingController();
  final _formkey = GlobalKey<FormState>();

  final User? user = FirebaseAuth.instance.currentUser;

  Widget _buildListItem(List<String> blockList){
    return SingleChildScrollView(
          padding: EdgeInsets.all(30),
          child: Form(
              key: _formkey,
              child: Column(children: [
                Container(
                    margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: Text(
                        '사용자를 차단하면, 해당 사용자가 작성한 \n글/댓글/채팅이 모두 보이지 않습니다.',
                        semanticsLabel:
                            '사용자를 차단하면, 해당 사용자가 쓴 글/댓글/채팅이 모두 보이지 않습니다.',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 15,
                          fontFamily: 'NanumGothic',
                          fontWeight: FontWeight.w600,
                        ))),
                Semantics(
                    label: "차단할 닉네임 입력",
                    child: TextFormField(
                        controller: _nickname,
                        maxLines: 1,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "차단할 닉네임은 비어있을 수 없습니다";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: "차단할 닉네임 입력",
                          labelText: "차단할 닉네임을 입력해주세요.",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                            borderSide: BorderSide(width: 1),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            borderSide:
                                BorderSide(width: 1, color: Color(0xFF045558)),
                          ),
                          labelStyle: TextStyle(color: Color(0xFF045558)),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF045558)),
                          ),
                        ))),
                Container(
                    margin: EdgeInsets.fromLTRB(0, 20, 0, 20),
                    child: Text('차단한 사용자 목록',
                        semanticsLabel: '차단한 사용자 목록',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 18,
                          fontFamily: 'NanumGothic',
                          fontWeight: FontWeight.w600,
                        ))),
                if (blockList.isEmpty)
                  (Center(
                      child: Text('없음',
                          semanticsLabel: '차단한 사용자 목록 없음',
                          style: const TextStyle(
                            fontSize: 18,
                            fontFamily: 'NanumGothic',
                            fontWeight: FontWeight.w600,
                          ))))
                else
                  (Column(
                      children: blockList
                          .map((e) => new Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('$e ',
                                  semanticsLabel: e,
                                  style: const TextStyle(
                                    fontSize: 17,
                                    fontFamily: 'NanumGothic',
                                    fontWeight: FontWeight.w600,
                                  )),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: widget.primaryColor,
                                  foregroundColor: Colors.white,
                                ),
                                onPressed: () {
                                  HapticFeedback.lightImpact(); // 약한 진동
                                  DBSet.cancelBlock(user!.uid, e);
                                }, 
                                child: Text('차단 해제',
                                  semanticsLabel: '차단 해제',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontFamily: 'NanumGothic',
                                    fontWeight: FontWeight.w600,
                                  ))
                              )
                            ]))
                          .toList()))
              ])));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.title,
            semanticsLabel: widget.title,
            style: TextStyle(
                fontFamily: 'NanumGothic', fontWeight: FontWeight.bold)),
        backgroundColor: Color(0xFF045558),
        leading: IconButton(
            icon: Icon(Icons.arrow_back,
                semanticLabel: "뒤로 가기", color: Colors.white),
            onPressed: () {
              HapticFeedback.lightImpact(); // 약한 진동
              Navigator.pop(context);
            }),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('user').doc(user!.uid).snapshots(),
        builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          List<String> blockList = [];
          if(snapshot.hasData) {
            blockList = snapshot.data!['blockList'].cast<String>();
          }
          return _buildListItem(blockList);
        }
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: widget.primaryColor,
          foregroundColor: Colors.white,
          onPressed: () {
            HapticFeedback.lightImpact(); // 약한 진동
            if (_formkey.currentState!.validate()) {
              DBSet.addBlock(user!.uid, _nickname.text);
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                        semanticLabel:
                            "정상적으로 차단되었습니다. 해당 사용자의 글/댓글/채팅은 보이지 않습니다. 이전 화면으로 이동하려면 확인 버튼을 누르세요.",
                        content: Text(
                            '정상적으로 차단되었습니다.\n해당 사용자의 글/댓글/채팅은 보이지 않습니다.',
                            semanticsLabel:
                                '정상적으로 차단되었습니다. 해당 사용자의 글/댓글/채팅은 보이지 않습니다.',
                            style: const TextStyle(
                              fontSize: 14,
                              fontFamily: 'NanumGothic',
                              fontWeight: FontWeight.w600,
                            )),
                        actions: [
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: widget.primaryColor,
                                foregroundColor: Colors.white,
                              ),
                              onPressed: () {
                                HapticFeedback.lightImpact(); // 약한 진동
                                Navigator.pop(context);
                                FocusScope.of(context).unfocus();
                              },
                              child: Text('확인',
                                  semanticsLabel: '확인',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontFamily: 'NanumGothic',
                                    fontWeight: FontWeight.w600,
                                  )))
                        ]);
                  });
            }
          },
          child: Text('차단',
              semanticsLabel: '차단',
              style: const TextStyle(
                fontSize: 14,
                fontFamily: 'NanumGothic',
                fontWeight: FontWeight.w600,
              ))),
    );
  }
}
