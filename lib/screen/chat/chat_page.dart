import 'package:byourside/main.dart';
import 'package:byourside/model/chat_list.dart';
import 'package:byourside/model/db_set.dart';
import 'package:byourside/widget/message_tile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ChatPage extends StatefulWidget {
  final String groupId;
  final String groupName;
  final String userName;

  const ChatPage(
      {Key? key,
      required this.groupId,
      required this.groupName,
      required this.userName})
      : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  Stream<QuerySnapshot>? chats;
  TextEditingController messageController = TextEditingController();
  String admin = "";
  int count = 0;

  final List<String> _decList = [
    "불법 정보를 포함하고 있습니다.",
    "음란물입니다.",
    "스팸홍보/도배 내용을 포함하고 있습니다.",
    "욕설/비하/혐오/차별적 표현을 포함하고 있습니다.",
    "청소년에게 유해한 내용입니다.",
    "사칭/사기입니다.",
    "상업적 광고 및 판매 내용을 포함하고 있습니다."
  ];

  @override
  void initState() {
    getChatandAdmin();
    super.initState();
  }

  getChatandAdmin() {
    ChatList().getChats(widget.groupId).then((val) {
      setState(() {
        chats = val;
      });
    });
    ChatList().getGroupAdmin(widget.groupId).then((val) {
      setState(() {
        admin = val;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    String declaration = _decList[0];

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: height * 0.08,
        centerTitle: true,
        elevation: 0,
        title: Text(
          widget.groupName,
          semanticsLabel: widget.groupName,
          style:
              const TextStyle(fontFamily: 'NanumGothic', fontWeight: FontWeight.w600),
        ),
        backgroundColor: primaryColor,
        leading: IconButton(
            icon: const Icon(Icons.arrow_back,
                semanticLabel: "뒤로 가기", color: Colors.white),
            onPressed: () {
              Navigator.pop(context);
            }),
        actions: [
          OutlinedButton(
            style: ElevatedButton.styleFrom(
              side: const BorderSide(color: primaryColor, width: 1.5),
              foregroundColor: primaryColor,
            ),
            child: const Text('신고',
                semanticsLabel: '신고',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontFamily: 'NanumGothic',
                  fontWeight: FontWeight.w600,
                )),
            onPressed: () async {
              FocusManager.instance.primaryFocus?.unfocus();
              // await Future.delayed(Duration(seconds: 2));

              HapticFeedback.lightImpact(); // 약한 진동
              showDialog(
                  context: context,
                  builder: (context) {
                    return SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: AlertDialog(
                            semanticLabel:
                                '신고 사유를 알려주세요. 신고 사유에 맞지 않는 신고일 경우, 해당 신고는 처리되지 않습니다. 신고 사유를 선택 후 하단 왼쪽의 신고 버튼을 눌러주세요. 취소를 원하시면 하단 오른쪽의 취소 버튼을 눌러주세요.',
                            title: const Text(
                                '신고 사유를 알려주세요.\n신고 사유에 맞지 않는 신고일 경우,\n해당 신고는 처리되지 않습니다.',
                                semanticsLabel:
                                    '신고 사유를 알려주세요. 신고 사유에 맞지 않는 신고일 경우, 해당 신고는 처리되지 않습니다.',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: 'NanumGothic',
                                  fontWeight: FontWeight.w600,
                                )),
                            content:
                                StatefulBuilder(builder: (context, setState) {
                              return Column(
                                children: _decList
                                    .map((e) => RadioListTile(
                                        title: Text(e,
                                            semanticsLabel: e,
                                            style: const TextStyle(
                                              fontSize: 14,
                                              fontFamily: 'NanumGothic',
                                              fontWeight: FontWeight.w600,
                                            )),
                                        value: e,
                                        groupValue: declaration,
                                        onChanged: (String? value) {
                                          setState(() {
                                            declaration = value!;
                                          });
                                        }))
                                    .toList(),
                              );
                            }),
                            actions: [
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: primaryColor,
                                        ),
                                        onPressed: () {
                                          HapticFeedback.lightImpact(); // 약한 진동
                                          DBSet.declaration('chat',
                                              declaration, widget.groupId);
                                          Navigator.pop(context);
                                        },
                                        child: const Text('신고',
                                            semanticsLabel: '신고',
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontFamily: 'NanumGothic',
                                              fontWeight: FontWeight.w600,
                                            ))),
                                    ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: primaryColor,
                                        ),
                                        onPressed: () {
                                          HapticFeedback.lightImpact(); // 약한 진동
                                          Navigator.pop(context);
                                        },
                                        child: const Text('취소',
                                            semanticsLabel: '취소',
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontFamily: 'NanumGothic',
                                              fontWeight: FontWeight.w600,
                                            )))
                                  ])
                            ]));
                  });
            },
          )
        ],
      ),
      body: Stack(
        children: [
          Positioned(
              child: SizedBox(
                  height: height * 0.8 -
                      MediaQuery.of(context).viewPadding.top -
                      MediaQuery.of(context).viewPadding.bottom,
                  child: chatMessages())),
          Container(
            alignment: Alignment.bottomCenter,
            width: MediaQuery.of(context).size.width,
            child: Container(
              height: height * 0.12,

              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              width: width,
              color: primaryColor, //Colors.grey[700],
              child: Row(
                children: [
                  Expanded(
                      child: TextFormField(
                    controller: messageController,
                    style: const TextStyle(
                        color: Colors.white,
                        fontFamily: 'NanumGothic',
                        fontWeight: FontWeight.w600),
                    autofocus: true,
                    decoration: const InputDecoration(
                      hintStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontFamily: 'NanumGothic',
                          fontWeight: FontWeight.w600),
                      hintText: "메시지 보내기",
                      border: InputBorder.none,
                    ),
                  )),
                  SizedBox(
                    width: width * 0.1,
                    height: height * 0.05,
                  ),
                  GestureDetector(
                    onTap: () {
                      HapticFeedback.lightImpact(); // 약한 진동
                      sendMessage();
                    },
                    child: Container(
                      height: height * 0.05,
                      width: width * 0.14,
                      decoration: BoxDecoration(
                        color: Colors.white, //Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.send,
                          color: primaryColor,
                          semanticLabel: "전송", //semanticLabel 속성 추가하기
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  chatMessages() {
    return StreamBuilder(
      stream: chats,
      builder: (context, AsyncSnapshot snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index) {
                  return MessageTile(
                      message: snapshot.data.docs[index]['message'],
                      sender: snapshot.data.docs[index]['sender'],
                      sentByMe: widget.userName ==
                          snapshot.data.docs[index]['sender']);
                },
              )
            : Container();
      },
    );
  }

  sendMessage() {
    if (messageController.text.isNotEmpty) {
      Map<String, dynamic> chatMessageMap = {
        "message": messageController.text,
        "sender": widget.userName,
        "time": DateTime.now().millisecondsSinceEpoch,
      };

      ChatList().sendMessage(widget.groupId, chatMessageMap);
      setState(() {
        messageController.clear();
      });
    }
  }
}
