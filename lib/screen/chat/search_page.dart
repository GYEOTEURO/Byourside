import 'package:byourside/main.dart';
import 'package:byourside/screen/chat/chat_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_phone_auth_handler/firebase_phone_auth_handler.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

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
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: primaryColor,
        title: Text(
          "검색",
          style: TextStyle(fontSize: 27, color: Colors.white),
        ),
      ),
      body: Column(
        children: [
          Container(
            color: Theme.of(context).primaryColor,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: searchController,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintStyle: TextStyle(color: Colors.white, fontSize: 16),
                      hintText: "검색",
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    initiateSearchMethod();
                  },
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(40)),
                    child: const Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
          ),
          isLoading
              ? Center(
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
      if (this.mounted) {
        setState(() {
          isLoading = true;
        });
      }
      await ChatList().searchByName(searchController.text).then((snapshot) {
        if (this.mounted) {
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
      Future.delayed(const Duration(seconds: 2), () async {
        await ChatList(uid: uid)
            .isUserJoined(groupName, groupId, userName)
            .then((value) {
          if (mounted) {
            setState(() {
              isJoined = value;
            });
          }
        });
      });
    } catch (e) {
      print(e);
    }
  }

  Widget groupTile(String userName, String groupId, String groupName,
      String admin, String recentMsg) {
    joinedOrNot(userName, groupId, groupName, admin);
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      leading: CircleAvatar(
        radius: 30,
        backgroundColor: Theme.of(context).primaryColor,
        child: Text(
          groupName.substring(0, 1).toUpperCase(),
          style: const TextStyle(color: Colors.white),
        ),
      ),
      title: Text(
        groupName,
        style: const TextStyle(fontWeight: FontWeight.w600),
      ),
      subtitle: Text("${groupId}"),
      trailing: InkWell(
        onTap: () async {
          if (mounted) {
            await ChatList(uid: uid)
                .toggleGroupJoin(groupId, userName, groupName);
            setState(() {
              isJoined = !isJoined;
            });
          } else {
            // print("mount1");
          }
        },
        child: isJoined
            ? Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.black,
                  border: Border.all(color: Colors.white, width: 1),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: const Text(
                  "참여",
                  style: TextStyle(color: Colors.white),
                ),
              )
            : Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Theme.of(context).primaryColor,
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: const Text(
                  "참여",
                  style: TextStyle(color: Colors.white),
                ),
              ),
      ),
    );
  }
}
