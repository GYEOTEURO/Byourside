import 'package:byourside/main.dart';
import 'package:byourside/model/chat_list.dart';
import 'package:byourside/widget/message_tile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text(widget.groupName),
        titleTextStyle: TextStyle(fontSize: height * 0.04),
        backgroundColor: Theme.of(context).primaryColor,
        actions: [
          IconButton(
              onPressed: () async {
                HapticFeedback.lightImpact(); // 약한 진동
                ChatList(uid: FirebaseAuth.instance.currentUser!.uid)
                    .toggleGroupJoin(
                        widget.groupId,
                        ChatList().getGroupAdmin(widget.groupId).toString(),
                        widget.groupName)
                    .whenComplete(() {
                  Navigator.pop(context);
                });
              },
              icon: const Icon(
                Icons.exit_to_app,
                semanticLabel: "나가기",
              )) //semanticLabel 속성 추가하기))
        ],
      ),
      body: Stack(
        children: [
          Positioned(
              child: Container(
                  height: height * 0.83 -
                      MediaQuery.of(context).viewPadding.top -
                      MediaQuery.of(context).viewPadding.bottom,
                  child: chatMessages())),
          Container(
            alignment: Alignment.bottomCenter,
            width: MediaQuery.of(context).size.width,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              width: width,
              color: primaryColor, //Colors.grey[700],
              child: Row(
                children: [
                  Expanded(
                      child: TextFormField(
                    controller: messageController,
                    style: const TextStyle(color: Colors.white),
                    autofocus: true,
                    decoration: const InputDecoration(
                      hintStyle: TextStyle(color: Colors.white, fontSize: 17),
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
