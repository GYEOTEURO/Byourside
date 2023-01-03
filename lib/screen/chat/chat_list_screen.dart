import 'package:byourside/main.dart';
import 'package:byourside/model/chat_list.dart';
import 'package:byourside/screen/chat/search_page.dart';
import 'package:byourside/widget/group_tile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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

  // String manipulation
  String getId(String res) {
    return res.substring(0, res.indexOf("_"));
  }

  String getName(String res) {
    return res.substring(res.indexOf("_") + 1);
  }

  String getRecentMsg(String docId) {
    String recent = " ";

    FirebaseFirestore.instance
        .collection('groups')
        .doc(docId)
        .get()
        .then((value) {
      if (mounted) {
        setState(() {
          if (value is String) recent = value.data().toString();
        });
      }
    });
    return recent;
  }

  gettingUserData() async {
    // _auth.currentUser!.displayName;
    // _auth.currentUser!.email;

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
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SearchPage()));
              },
              icon: const Icon(
                Icons.search,
              ))
        ],
        elevation: 0,
        centerTitle: true,
        title: const Text(
          '메세지 목록',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 27),
        ),
        backgroundColor: primaryColor,
      ),
      body: groupList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          popUpDialog(context);
        },
        elevation: 0,
        backgroundColor: primaryColor,
        child: const Icon(
          Icons.add,
          color: Colors.white,
          size: 30,
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
                          onChanged: (val) {
                            if (mounted) {
                              setState(() {
                                groupName = val;
                              });
                            }
                          },
                          style: const TextStyle(color: Colors.black),
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
                    Navigator.of(context).pop();
                  },
                  style:
                      ElevatedButton.styleFrom(backgroundColor: primaryColor),
                  child: const Text("취소"),
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (groupName != "") {
                      // setState(() {
                      //   _isLoading = true;
                      // });
                      if (await checkGroupExist(groupName) != true) {
                        ChatList(uid: FirebaseAuth.instance.currentUser!.uid)
                            .createGroup(
                                FirebaseAuth.instance.currentUser!.displayName
                                    .toString(),
                                FirebaseAuth.instance.currentUser!.uid
                                    .toString(),
                                groupName)
                            .whenComplete(() => _isLoading = false);
                        Navigator.of(context).pop();
                      } else {
                        if (mounted) {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return const AlertDialog(
                                  content: Text('이미 존재하는 채팅방 이름입니다.'),
                                );
                              });
                        }
                      }
                    }
                  },
                  style:
                      ElevatedButton.styleFrom(backgroundColor: primaryColor),
                  child: const Text("만들기"),
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
                itemCount: snapshot.data['groups'].length,
                itemBuilder: (context, index) {
                  // String recent;
                  // FirebaseFirestore.instance
                  //         .collection('groups')
                  //         .doc(snapshot.data['groups'][index])
                  //         .get().then((value) => value.data().toString());
                  // int reverseIndex = snapshot.data['groups'].length - index - 1;
                  return GroupTile(
                      userName: snapshot.data['nickname'],
                      groupId: getId(snapshot.data['groups'][index]),
                      groupName: getName(snapshot.data['groups'][index]),
                      recentMsg: getRecentMsg(snapshot.data['groups'][index]));
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
      },
    );
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
              popUpDialog(context);
            },
            child: Icon(
              Icons.add_circle,
              color: Colors.grey[700],
              size: 75,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            "추가 버튼을 눌러 채팅을 시작하세요.",
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
