import 'package:byourside/main.dart';
import 'package:byourside/model/chat_list.dart';
import 'package:byourside/screen/chat/chat_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../model/comment.dart';
import '../../model/db_get.dart';
import '../../model/db_set.dart';

class CommentList extends StatefulWidget {
  const CommentList(
      {super.key,
      required this.collectionName,
      required this.documentID,
      required this.primaryColor});

  final String collectionName;
  final String documentID;
  final Color primaryColor;

  @override
  State<CommentList> createState() => _CommentListState();
}

class _CommentListState extends State<CommentList> {
  final User? user = FirebaseAuth.instance.currentUser;

  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection("user");
  final CollectionReference groupCollection =
      FirebaseFirestore.instance.collection("groups");

  Future<bool> checkGroupExist(String name) async {
    var collection = FirebaseFirestore.instance.collection('groupList');
    var doc = await collection.doc(name).get();
    return doc.exists;
  }

  Future<String> getGroupId(String groupName) async {
    try {
      var collection = FirebaseFirestore.instance.collection('groupList');
      var doc = await collection.doc(groupName).get();
      return doc.data()?.values.last;
    } catch (e) {
      print(e);
      return "hing..";
    }
  }

  Widget _buildListItem(
      String? collectionName, String? documentID, CommentModel? comment) {
    String date = comment!.datetime!.toDate().toString().split(' ')[0];

    return Card(
        elevation: 2,
        child: InkWell(
            child: Container(
                padding: const EdgeInsets.all(8),
                child: Column(children: [
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                          child: Text(comment.content!,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              )))),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                            child: TextButton(
                          onPressed: () async {
                            var groupName =
                                "${user?.displayName}_${comment.nickname}";
                            var groupNameReverse =
                                "${comment.nickname}_${user?.displayName}";
                            if (await checkGroupExist(groupName) != true &&
                                await checkGroupExist(groupNameReverse) !=
                                    true) {
                              await ChatList(
                                      uid: FirebaseAuth
                                          .instance.currentUser!.uid)
                                  .createGroup(
                                      FirebaseAuth
                                          .instance.currentUser!.displayName
                                          .toString(),
                                      FirebaseAuth.instance.currentUser!.uid
                                          .toString(),
                                      groupName);

                              String groupId = await getGroupId(groupName);
                              await groupCollection.doc(groupId).update({
                                "members": FieldValue.arrayUnion(
                                    ["${comment.uid}_${comment.nickname}"])
                              });

                              Future.delayed(const Duration(seconds: 2), () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ChatPage(
                                            groupId: groupId,
                                            groupName: groupName,
                                            userName: user!.displayName!)));
                              });
                            } else if (await checkGroupExist(groupName) !=
                                true) {
                              String groupId =
                                  await getGroupId(groupNameReverse);
                              Future.delayed(const Duration(seconds: 2), () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ChatPage(
                                            groupId: groupId,
                                            groupName: groupNameReverse,
                                            userName: user!.displayName!)));
                              });
                            } else {
                              String groupId = await getGroupId(groupName);
                              Future.delayed(const Duration(seconds: 2), () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ChatPage(
                                            groupId: groupId,
                                            groupName: groupName,
                                            userName: user!.displayName!)));
                              });
                            }
                          },
                          child: Text(
                            "${comment.nickname} / $date",
                            style: const TextStyle(color: primaryColor),
                          ),
                        )),
                        if (user?.uid == comment.uid)
                          RichText(
                              text: TextSpan(
                            children: [
                              TextSpan(
                                  text: "삭제",
                                  style: const TextStyle(color: Colors.black),
                                  recognizer: TapGestureRecognizer()
                                    ..onTapDown = (details) {
                                      DBSet.deleteComment(collectionName!,
                                          documentID!, comment.id!);
                                    })
                            ],
                          ))
                      ]),
                ]))));
  }

  @override
  Widget build(BuildContext context) {
    String collectionName = widget.collectionName;
    String documentID = widget.documentID;

    return StreamBuilder<List<CommentModel>>(
        stream: DBGet.readComment(
            collection: collectionName, documentID: documentID),
        builder: (context, AsyncSnapshot<List<CommentModel>> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data!.length,
                shrinkWrap: true,
                itemBuilder: (_, index) {
                  CommentModel comment = snapshot.data![index];
                  return _buildListItem(collectionName, documentID, comment);
                });
          } else
            return const Text("댓글이 없습니다. 첫 댓글의 주인공이 되어보세요!");
        });
  }
}
