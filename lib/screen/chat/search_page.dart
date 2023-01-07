import 'package:byourside/main.dart';
import 'package:byourside/screen/chat/chat_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_phone_auth_handler/firebase_phone_auth_handler.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../model/chat_list.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController searchController = TextEditingController();
  bool isLoading = false;
  QuerySnapshot? searchSnapshot;
  bool hasUserSearched = false;
  String userName = FirebaseAuth.instance.currentUser!.displayName.toString();
  bool isJoined = false;
  String uid = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: primaryColor,
        title: const Text(
          "검색",
          semanticsLabel: "검색",
          style:
              TextStyle(fontFamily: 'NanumGothic', fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            color: Theme.of(context).primaryColor,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    autofocus: true,
                    controller: searchController,
                    style: const TextStyle(
                        color: Colors.white,
                        fontFamily: 'NanumGothic',
                        fontWeight: FontWeight.w500),
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(10)),
                      errorBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.red),
                          borderRadius: BorderRadius.circular(10)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(10)),
                      hintStyle: const TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontFamily: 'NanumGothic',
                          fontWeight: FontWeight.w500),
                      hintText: "검색",
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    HapticFeedback.lightImpact(); // 약한 진동
                    initiateSearchMethod();
                  },
                  child: Container(
                    width: width * 0.14,
                    height: height * 0.04,
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20)),
                    child: const Icon(
                      Icons.search,
                      semanticLabel: "검색", //semanticLabel 속성 추가하기
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
          ),
          isLoading
              ? const Center(
                  child: CircularProgressIndicator(
                    color: primaryColor,
                  ),
                )
              : groupList(),
        ],
      ),
    );
  }

  initiateSearchMethod() async {
    if (searchController.text.isNotEmpty) {
      if (mounted) {
        setState(() {
          isLoading = true;
        });
      }
      await ChatList().searchByName(searchController.text).then((snapshot) {
        if (mounted) {
          setState(() {
            searchSnapshot = snapshot;
            isLoading = false;
            hasUserSearched = true;
          });
        }
      });
    }
  }

  groupList() {
    return hasUserSearched
        ? ListView.builder(
            shrinkWrap: true,
            itemCount: searchSnapshot!.docs.length,
            itemBuilder: (context, index) {
              return groupTile(
                userName,
                searchSnapshot!.docs[index]['groupId'],
                searchSnapshot!.docs[index]['groupName'],
                searchSnapshot!.docs[index]['admin'],
                searchSnapshot!.docs[index]['recentMessage'],
              );
            },
          )
        : Container();
  }

  joinedOrNot(String userName, String groupId, String groupName, String admin) {
    try {
      Future.delayed(const Duration(seconds: 3), () async {
        await ChatList(uid: uid)
            .isUserJoined(groupName, groupId, userName)
            .then((value) {
          if (mounted) {
            setState(() {
              Duration(seconds: 3);
              isJoined = value;
            });
          }
        });
      });
    } catch (e) {
      // print(e);
    }
  }

  Widget groupTile(String userName, String groupId, String groupName,
      String admin, String recentMsg) {
    joinedOrNot(userName, groupId, groupName, admin);
    return ListTile(
      contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      leading: CircleAvatar(
        radius: 30,
        backgroundColor: Theme.of(context).primaryColor,
        child: Text(
          (groupName.split('_')[0] == userName)
              ? groupName.split('_')[1].substring(0, 1).toUpperCase()
              : groupName.substring(0, 1).toUpperCase(),
          style: const TextStyle(
              color: Colors.white,
              fontFamily: 'NanumGothic',
              fontWeight: FontWeight.w500),
          textAlign: TextAlign.center,
        ),
      ),
      title: Text(
        groupName,
        semanticsLabel: groupName,
        style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 17,
            fontFamily: 'NanumGothic'),
      ),
      subtitle: Text(
        "${groupId}",
        semanticsLabel: groupId.toString(),
        style: const TextStyle(
            fontSize: 15,
            fontFamily: 'NanumGothic',
            fontWeight: FontWeight.w500),
      ),
      trailing: InkWell(
          onTap: () {
            HapticFeedback.lightImpact(); // 약한 진동
            if (mounted) {
              ChatList(uid: uid).toggleGroupJoin(groupId, userName, groupName);
              setState(() {
                isJoined = !isJoined;

                if (mounted) {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          content: isJoined
                              ? Text(
                                  "참여 완료.",
                                  semanticsLabel: "참여 완료",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontFamily: 'NanumGothic',
                                      fontWeight: FontWeight.w500),
                                )
                              : Text(
                                  "참여가 취소되었습니다.",
                                  semanticsLabel: "참여가 취소되었습니다.",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontFamily: 'NanumGothic',
                                      fontWeight: FontWeight.w500),
                                ),
                        );
                      });
                }
              });
            } else {
              // print("mount1");
            }
          },
          child: //isJoined ?
              Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.black,
                    border: Border.all(color: Colors.white, width: 1),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: const Text(
                    "참여",
                    semanticsLabel: "참여",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontFamily: 'NanumGothic',
                        fontWeight: FontWeight.w500),
                  ))
          // : Container(
          //     decoration: BoxDecoration(
          //       borderRadius: BorderRadius.circular(10),
          //       color: Theme.of(context).primaryColor,
          //     ),
          //     padding:
          //         const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          //     child: const Text(
          //       "참여",
          //       semanticsLabel: "참여",
          //       style: TextStyle(
          //           color: Colors.white,
          //           fontSize: 17,
          //           fontFamily: 'NanumGothic',
          //           fontWeight: FontWeight.w500),
          ),
    );
  }
}
