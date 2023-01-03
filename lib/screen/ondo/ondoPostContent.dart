import 'package:byourside/model/chat_list.dart';
import 'package:byourside/model/ondo_post.dart';
import 'package:byourside/screen/chat/chat_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../model/db_get.dart';
import '../../model/db_set.dart';

class OndoPostContent extends StatefulWidget {
  const OndoPostContent(
      {super.key,
      required this.collectionName,
      required this.documentID,
      required this.primaryColor});

  final String collectionName;
  final String documentID;
  final Color primaryColor;

  @override
  State<OndoPostContent> createState() => _OndoPostContentState();
}

class _OndoPostContentState extends State<OndoPostContent> {
  final User? user = FirebaseAuth.instance.currentUser;

  final CollectionReference groupCollection =
      FirebaseFirestore.instance.collection("groups");

  Future<bool> checkGroupExist(String name) async {
    var collection = FirebaseFirestore.instance.collection('groupList');
    var doc = await collection.doc(name).get();
    return doc.exists;
  }

  Future<String> getGroupId(String groupName) async {
    var collection = FirebaseFirestore.instance.collection('groupList');
    var doc = await collection.doc(groupName).get();
    return doc.data()?.values.last;
  }

  Widget _buildListItem(String? collectionName, OndoPostModel? post) {
    String date = post!.datetime!.toDate().toString().split(' ')[0];

    return Column(children: [
      Align(
          alignment: Alignment.centerLeft,
          child: Container(
              child: Text(
            post.title!,
            style: const TextStyle(fontSize: 25),
          ))),
      Row(children: [
        Expanded(
            child: TextButton(
                child: Text(
                  "${post.nickname!} / $date",
                  style: const TextStyle(color: Colors.black54),
                ),
                onPressed: () async {
                  var groupName = "${user?.displayName}_${post.nickname}";
                  var groupNameReverse =
                      "${post.nickname}_${user?.displayName}";
                  if (await checkGroupExist(groupName) != true &&
                      await checkGroupExist(groupNameReverse) != true) {
                    await ChatList(uid: FirebaseAuth.instance.currentUser!.uid)
                        .createGroup(
                            FirebaseAuth.instance.currentUser!.displayName
                                .toString(),
                            FirebaseAuth.instance.currentUser!.uid.toString(),
                            groupName);

                    String groupId = await getGroupId(groupName);
                    await groupCollection.doc(groupId).update({
                      "members": FieldValue.arrayUnion(
                          ["${post.uid}_${post.nickname}"])
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
                  } else if (await checkGroupExist(groupName) != true) {
                    String groupId = await getGroupId(groupNameReverse);
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
                })),
        if (user?.uid == post.uid)
          (RichText(
              text: TextSpan(
            children: [
              TextSpan(
                  text: "삭제",
                  style: const TextStyle(color: Colors.black),
                  recognizer: TapGestureRecognizer()
                    ..onTapDown = (details) {
                      Navigator.pop(context);
                      DBSet.deletePost(collectionName!, post.id!);
                    })
            ],
          ))),
      ]),
      Divider(thickness: 1, height: 1, color: Colors.blueGrey[200]),
      if (post.images!.isNotEmpty)
        (Container(
            padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
            child: Column(
              children: [
                for (String url in post.images!)
                  (Container(
                    child: Image.network(url),
                    padding: EdgeInsets.fromLTRB(0, 5, 0, 10),
                  ))
              ],
            ))),
      Container(
          alignment: Alignment.centerLeft,
          child: Text(
            post.content!,
            style: const TextStyle(fontSize: 15),
          )),
      Row(children: [
        IconButton(
            alignment: Alignment.centerLeft,
            onPressed: () {
              post.likesPeople!.contains(user?.uid)
                  ? DBSet.cancelLike(collectionName!, post.id!, user!.uid)
                  : DBSet.addLike(collectionName!, post.id!, user!.uid);
            },
            icon: post.likesPeople!.contains(user?.uid)
                ? const Icon(Icons.favorite)
                : const Icon(Icons.favorite_outline),
            color: Color.fromARGB(255, 207, 77, 68)),
        Text('${post.likes!} '),
        IconButton(
          alignment: Alignment.centerLeft,
          onPressed: () {
            post.scrapPeople!.contains(user?.uid)
                ? DBSet.cancelScrap(collectionName!, post.id!, user!.uid)
                : DBSet.addScrap(collectionName!, post.id!, user!.uid);
          },
          icon: post.scrapPeople!.contains(user?.uid)
              ? const Icon(Icons.star)
              : const Icon(Icons.star_outline),
          color: const Color.fromARGB(255, 244, 231, 98),
        ),
      ]),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    String collectionName = widget.collectionName;
    String documentID = widget.documentID;

    return StreamBuilder<OndoPostModel>(
        stream: DBGet.readOndoDocument(
            collection: collectionName, documentID: documentID),
        builder: (context, AsyncSnapshot<OndoPostModel> snapshot) {
          if (snapshot.hasData) {
            OndoPostModel? post = snapshot.data;
            return _buildListItem(collectionName, post);
          } else
            return const Text('게시물을 찾을 수 없습니다.');
        });
  }
}
