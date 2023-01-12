import 'dart:developer';
import 'dart:typed_data';
import 'dart:ui';

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
  final User? user = FirebaseAuth.instance.currentUser;

  Stream? groups;
  bool _isLoading = false;
  String groupName = "";
  List<String> blockList = [];

  getBlockList(String uid) async {
    await FirebaseFirestore.instance
        .collection('user')
        .doc(uid)
        .get()
        .then((value) {
      List.from(value.data()!['blockList']).forEach((element) {
        if (!blockList.contains(element)) {
          blockList.add(element);
        }
      });
    });
    if (mounted) setState(() {});
  }

  @override
  void initState() {
    super.initState();
    gettingUserData();
    if (mounted) getBlockList(user!.uid);
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
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () {
                HapticFeedback.lightImpact();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SearchPage()));
              },
              icon: const Icon(
                Icons.search,
                semanticLabel: "검색",
              ))
        ],
        elevation: 0,
        centerTitle: true,
        title: const Text(
          '채팅 목록',
          semanticsLabel: '채팅 목록',
          style:
              TextStyle(fontFamily: 'Nanumothic', fontWeight: FontWeight.w600),
        ),
        backgroundColor: primaryColor,
      ),
      body: groupList(width),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          HapticFeedback.lightImpact();
          popUpDialog(context);
        },
        elevation: 0,
        backgroundColor: primaryColor,
        child: const Icon(
          Icons.add,
          color: Colors.white,
          semanticLabel: "추가",
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
              semanticLabel:
                  "그룹 만들기입니다. 취소를 원하시면 왼쪽 취소 버튼을, 만들기를 원하시면 그룹 이름 입력 후 오른쪽 만들기 버튼을 눌러주세요.",
              title: const Text("그룹 만들기",
                  semanticsLabel: "그룹 만들기",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontSize: 17,
                      fontFamily: 'NanumGothic',
                      fontWeight: FontWeight.w600)),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _isLoading == true
                      ? Center(
                          child: CircularProgressIndicator(color: primaryColor),
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
                              color: Colors.black,
                              fontSize: 17,
                              fontFamily: 'NanumGothic',
                              fontWeight: FontWeight.w600),
                          decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: primaryColor),
                                  borderRadius: BorderRadius.circular(20)),
                              errorBorder: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: Colors.red),
                                  borderRadius: BorderRadius.circular(20)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: primaryColor),
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
                  child: const Text(
                    "취소",
                    semanticsLabel: "취소",
                    style: TextStyle(
                        fontSize: 17,
                        fontFamily: 'NanumGothic',
                        fontWeight: FontWeight.w500),
                  ),
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
                                return AlertDialog(
                                    semanticLabel:
                                        "이미 존재하는 채팅방 이름입니다. 돌아가려면 하단의 확인 버튼을 눌러주세요.",
                                    content: Text(
                                      '이미 존재하는 채팅방 이름입니다.',
                                      semanticsLabel: '이미 존재하는 채팅방 이름입니다.',
                                    ),
                                    actions: [
                                      ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: primaryColor,
                                          ),
                                          onPressed: () {
                                            HapticFeedback
                                                .lightImpact(); // 약한 진동
                                            Navigator.pop(context);
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
                      }
                    }
                  },
                  style:
                      ElevatedButton.styleFrom(backgroundColor: primaryColor),
                  child: const Text(
                    "만들기",
                    semanticsLabel: "만들기",
                    style: TextStyle(
                        fontSize: 17,
                        fontFamily: 'NanumGothic',
                        fontWeight: FontWeight.w500),
                  ),
                )
              ],
            );
          }));
        });
  }

  bool makeCheck(List input) {
    bool check = true;
    for (var j in input) {
      print('ssssssssssssssssss');
      print(input);

      if (blockList.contains(j)) {
        check = false;
        print(check);
        continue;
      }
    }
    return check;
  }

  groupList(double width) {
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
                    bool check = true;
                    int reverseIndex =
                        snapshot.data['groups'].length - index - 1;
                    // print('-------------');
                    // print(snapshot.data['groups'][reverseIndex].split('_'));
                    check = makeCheck(
                        snapshot.data['groups'][reverseIndex].split('_'));
                    if (check) {
                      return GroupTile(
                          userName: snapshot.data['nickname'],
                          groupId: getId(snapshot.data['groups'][reverseIndex]),
                          groupName:
                              getName(snapshot.data['groups'][reverseIndex]),
                          recentMsg:
                              "" //getRecentMsg(snapshot.data['groups'][index])
                          );
                    } else
                      return Container();
                  },
                );
              } else {
                return noGroupWidget(width);
              }
            } else {
              return noGroupWidget(width);
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

  noGroupWidget(double width) {
    return Container(
      width: width,
      padding: const EdgeInsets.all(50.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              HapticFeedback.lightImpact();
              popUpDialog(context);
            },
            child: Icon(
              Icons.add_circle,
              color: Colors.black,
              semanticLabel: "추가",
              size: 75,
            ),
          ),
          SizedBox(height: 10),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Text(
              "추가 버튼을 눌러 채팅을 시작하세요.",
              semanticsLabel: "추가 버튼을 눌러 채팅을 시작하세요.",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 17,
                  fontFamily: 'NanumGothic',
                  fontWeight: FontWeight.w600),
            ),
          )
        ],
      ),
    );
  }
}
