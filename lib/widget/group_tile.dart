import 'package:byourside/main.dart';
import 'package:byourside/model/chat_list.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../screen/chat/chat_page.dart';

class GroupTile extends StatefulWidget {
  final String userName;
  final String groupId;
  final String groupName;
  final String recentMsg;

  const GroupTile(
      {Key? key,
      required this.userName,
      required this.groupId,
      required this.groupName,
      required this.recentMsg})
      : super(key: key);

  @override
  State<GroupTile> createState() => _GroupTileState();
}

class _GroupTileState extends State<GroupTile> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        HapticFeedback.lightImpact(); // 약한 진동
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ChatPage(
                      groupId: widget.groupId,
                      groupName: widget.groupName,
                      userName: widget.userName,
                    )));
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 5),
        child: ListTile(
            contentPadding: const EdgeInsets.symmetric(vertical: 2, horizontal: 15),
            leading: CircleAvatar(
              radius: 30,
              backgroundColor: primaryColor,
              child: Text(
                (widget.groupName.split('_')[0] == widget.userName)
                    ? widget.groupName
                        .split('_')[1]
                        .substring(0, 1)
                        .toUpperCase()
                    : widget.groupName.substring(0, 1).toUpperCase(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                    color: Colors.white,
                    fontFamily: 'NanumGothic',
                    fontWeight: FontWeight.w500),
              ),
            ),
            title: Text(
              widget.groupName,
              semanticsLabel: widget.groupName,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                  fontFamily: 'NanumGothic'),
            ),
            trailing: IconButton(
                onPressed: () async {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                          semanticLabel:
                              "그룹을 나가시겠습니까? 취소를 원하시면 왼쪽의 취소 버튼을, 나가기를 원하시면 오른쪽의 나가기 버튼을 눌러주세요.",
                          title: const Text(
                            "그룹을 나가시겠습니까?",
                            semanticsLabel: "그룹을 나가시겠습니까?",
                            textAlign: TextAlign.left,
                          ),
                          content: Padding(
                              padding: const EdgeInsets.all(30),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      HapticFeedback.lightImpact(); // 약한 진동
                                      Navigator.of(context).pop();
                                    },
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: primaryColor),
                                    child: const Text(
                                      "취소",
                                      semanticsLabel: "취소",
                                      style: TextStyle(
                                          fontSize: 17,
                                          fontFamily: 'NanumGothic',
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                  SizedBox(
                                    width: width * 0.01,
                                    height: height * 0.05,
                                  ),
                                  ElevatedButton(
                                    onPressed: () async {
                                      HapticFeedback.lightImpact(); // 약한 진동
                                      ChatList(
                                              uid: FirebaseAuth
                                                  .instance.currentUser!.uid)
                                          .toggleGroupJoin(
                                              widget.groupId,
                                              ChatList()
                                                  .getGroupAdmin(widget.groupId)
                                                  .toString(),
                                              widget.groupName)
                                          .whenComplete(() {
                                        Navigator.pop(context);
                                      });
                                    },
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: primaryColor),
                                    child: const Text(
                                      "나가기",
                                      semanticsLabel: "나가기",
                                      style: TextStyle(
                                          fontSize: 17,
                                          fontFamily: 'NanumGothic',
                                          fontWeight: FontWeight.w500),
                                    ),
                                  )
                                ],
                              )));
                    },
                  );
                },
                icon: Icon(
                  Icons.exit_to_app,
                  semanticLabel: "나가기",
                  size: height * 0.028,
                  color: primaryColor,
                ))),
      ),
    );
  }
}
