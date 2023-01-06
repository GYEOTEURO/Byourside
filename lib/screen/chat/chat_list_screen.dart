import 'dart:developer';
import 'dart:typed_data';

import 'package:byourside/main.dart';
import 'package:byourside/model/chat_list.dart';
import 'package:byourside/screen/chat/search_page.dart';
import 'package:byourside/widget/group_tile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ChatListScreen extends StatefulWidget {
  const ChatListScreen({Key? key}) : super(key: key);

  @override
  State<ChatListScreen> createState() => _ChatListScreenState();
}

Future<String> callAsyncFetch() =>
    Future.delayed(Duration(seconds: 2), () => "hi");

class _ChatListScreenState extends State<ChatListScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Stream? groups;
  bool _isLoading = false;
  String groupName = "";

  @override
  void initState() {
    super.initState();
    gettingUserData();
  }

  Future<bool> checkGroupExist(String name) async {
    var collection = FirebaseFirestore.instance.collection('groupList');
    var doc = await collection.doc(name).get();
    // print(doc);
    return doc.exists;
  }

  Future<String> getRecentMsg(String docId) async {
    String recent = " ";

    await FirebaseFirestore.instance
        .collection('groups')
        .doc(docId)
        .get()
        .then((value) => recent = value.data()!['recentMessage']);
    return recent;
  }

  // String manipulation
  String getId(String res) {
    return res.substring(0, res.indexOf("_"));
  }

  String getName(String res) {
    return res.substring(res.indexOf("_") + 1);
  }

  Stream<QuerySnapshot<Object?>> getGroups() {
    return FirebaseFirestore.instance
        .collection("user")
        .where(_auth.currentUser!.uid)
        .snapshots();
  }

  gettingUserData() async {
    // getting the list of snapshots in our stream
    await ChatList(uid: _auth.currentUser!.uid)
        .getUserGroups()
        .then((snapshot) {
      if (mounted) {
        setState(() {
          groups = snapshot;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                HapticFeedback.lightImpact(); // 약한 진동
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SearchPage()));
              },
              icon: const Icon(
                Icons.search,
                semanticLabel: "검색", //semanticLabel 속성 추가하기
              ))
        ],
        elevation: 0,
        centerTitle: true,
        title: const Text(
          '채팅 목록',
          semanticsLabel: '채팅 목록',
        ),
        titleTextStyle: TextStyle(fontSize: height * 0.03),
        backgroundColor: primaryColor,
      ),
      body: groupList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          HapticFeedback.lightImpact(); // 약한 진동
          popUpDialog(context);
        },
        elevation: 0,
        backgroundColor: primaryColor,
        child: const Icon(
          Icons.add,
          color: Colors.white,
          semanticLabel: "추가", //semanticLabel 속성 추가하기
        ),
      ),
    );
  }

  popUpDialog(BuildContext context) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: ((context, setState) {
            return AlertDialog(
              title: const Text(
                "그룹 만들기",
                semanticsLabel: "그룹 만들기",
                textAlign: TextAlign.left,
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _isLoading == true
                      ? Center(
                          child: CircularProgressIndicator(
                              color: Theme.of(context).primaryColor),
                        )
                      : TextField(
                          autofocus: true,
                          onChanged: (val) {
                            if (mounted) {
                              setState(() {
                                groupName = val;
                              });
                            }
                          },
                          style: const TextStyle(
                              color: Colors.black, fontSize: 17),
                          decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Theme.of(context).primaryColor),
                                  borderRadius: BorderRadius.circular(20)),
                              errorBorder: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: Colors.red),
                                  borderRadius: BorderRadius.circular(20)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Theme.of(context).primaryColor),
                                  borderRadius: BorderRadius.circular(20))),
                        ),
                ],
              ),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    HapticFeedback.lightImpact(); // 약한 진동
                    Navigator.of(context).pop();
                  },
                  style:
                      ElevatedButton.styleFrom(backgroundColor: primaryColor),
                  child: const Text("취소",
                      semanticsLabel: "취소", style: TextStyle(fontSize: 17)),
                ),
                ElevatedButton(
                  onPressed: () async {
                    HapticFeedback.lightImpact(); // 약한 진동
                    if (groupName != "") {
                      if (await checkGroupExist(groupName) != true) {
                        ChatList(uid: FirebaseAuth.instance.currentUser!.uid)
                            .createGroup(
                                FirebaseAuth.instance.currentUser!.displayName
                                    .toString(),
                                FirebaseAuth.instance.currentUser!.uid
                                    .toString(),
                                "none",
                                "none",
                                groupName)
                            .whenComplete(() => _isLoading = false);
                        Navigator.of(context).pop();
                      } else {
                        if (mounted) {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return const AlertDialog(
                                  content: Text(
                                    '이미 존재하는 채팅방 이름입니다.',
                                    semanticsLabel: '이미 존재하는 채팅방 이름입니다.',
                                  ),
                                );
                              });
                        }
                      }
                    }
                  },
                  style:
                      ElevatedButton.styleFrom(backgroundColor: primaryColor),
                  child: const Text("만들기",
                      semanticsLabel: "만들기", style: TextStyle(fontSize: 17)),
                )
              ],
            );
          }));
        });
  }

  groupList() {
    return StreamBuilder(
        stream: groups,
        builder: (context, AsyncSnapshot snapshot) {
          // make some checks
          if (snapshot.hasData) {
            if (snapshot.data['groups'] != null) {
              if (snapshot.data['groups'].length != 0) {
                return ListView.builder(
                  padding: EdgeInsets.all(5),
                  itemCount: snapshot.data['groups'].length,
                  itemBuilder: (context, index) {
                    int reverseIndex =
                        snapshot.data['groups'].length - index - 1;

                    return GroupTile(
                        userName: snapshot.data['nickname'],
                        groupId: getId(snapshot.data['groups'][reverseIndex]),
                        groupName:
                            getName(snapshot.data['groups'][reverseIndex]),
                        recentMsg: ""
                        //recentMsg: getRecentMsg(snapshot.data['groups'][index])

                        );
                  },
                );
              } else {
                return noGroupWidget();
              }
            } else {
              return noGroupWidget();
            }
          } else {
            return const Center(
              child: CircularProgressIndicator(
                color: primaryColor,
              ),
            );
          }
        });
  }

  noGroupWidget() {
    return Container(
      padding: const EdgeInsets.all(100.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              HapticFeedback.lightImpact(); // 약한 진동
              popUpDialog(context);
            },
            child: Icon(
              Icons.add_circle,
              color: Colors.black,
              semanticLabel: "추가", //semanticLabel 속성 추가하기
              size: 75,
            ),
          ),
          SizedBox(height: 20),
          const Text("추가 버튼을 눌러 채팅을 시작하세요.",
              semanticsLabel: "추가 버튼을 눌러 채팅을 시작하세요.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 17)),
        ],
      ),
    );
  }
}
