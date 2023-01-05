import 'package:byourside/model/chat_list.dart';
import 'package:byourside/screen/chat/chat_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import '../../model/db_get.dart';
import '../../model/db_set.dart';
import '../../model/nanum_post.dart';

class NanumPostContent extends StatefulWidget {
  const NanumPostContent(
      {super.key,
      required this.collectionName,
      required this.documentID,
      required this.primaryColor});

  final String collectionName;
  final String documentID;
  final Color primaryColor;

  @override
  State<NanumPostContent> createState() => _NanumPostContentState();
}

class _NanumPostContentState extends State<NanumPostContent> {
  final User? user = FirebaseAuth.instance.currentUser;

  final CollectionReference groupCollection =
      FirebaseFirestore.instance.collection("groups");

  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection("user");

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

  Widget _buildListItem(String? collectionName, NanumPostModel? post) {
    String date = post!.datetime!.toDate().toString().split(' ')[0];
    String changeState = post.isCompleted! ? "거래중으로 변경  " : "거래완료로 변경  ";
    String dealState = post.isCompleted! ? "거래완료" : "거래중";

    return Column(children: [
      Align(
          alignment: Alignment.centerLeft,
          child: Container(
              child: SelectionArea(
                child: Text(
                  ' ${post.title!}',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
          )))),
      Row(children: [
        Expanded(
            child: TextButton(
              child: SelectionArea(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                  "${post.nickname!} / $date / ${post.type}",
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 15
              )))),
          onPressed: () async {
            HapticFeedback.lightImpact();// 약한 진동
            var groupName = "${user?.displayName}_${post.nickname}";
            var groupNameReverse = "${post.nickname}_${user?.displayName}";
            if (await checkGroupExist(groupName) != true &&
                await checkGroupExist(groupNameReverse) != true) {
              await ChatList(uid: FirebaseAuth.instance.currentUser!.uid)
                  .createGroup(
                      FirebaseAuth.instance.currentUser!.displayName.toString(),
                      FirebaseAuth.instance.currentUser!.uid.toString(),
                      post.nickname!,
                      post.uid!,
                      groupName);

              String groupId = await getGroupId(groupName);
              await groupCollection.doc(groupId).update({
                "members":
                    FieldValue.arrayUnion(["${post.uid}_${post.nickname}"])
              });
              // await userCollection.doc(post.uid).update({
              //   "groups":
              //       FieldValue.arrayUnion(["${doc.uid}_${doc.nickname}"])
              // })
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
          },
        )),
        if (user?.uid == post.uid)
          (RichText(
              text: TextSpan(
                text: changeState,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 15),
                recognizer: TapGestureRecognizer()
                  ..onTapDown = (details) {
                    HapticFeedback.lightImpact();// 약한 진동
                    DBSet.updateIsCompleted(
                        collectionName!, post.id!, !post.isCompleted!);
                  })
          ))
        else
          (Text(dealState)),
        if (user?.uid == post.uid)
          (RichText(
              text: TextSpan(
                  text: "삭제",
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 15),
                  recognizer: TapGestureRecognizer()
                    ..onTapDown = (details) {
                      HapticFeedback.lightImpact();// 약한 진동
                      Navigator.pop(context);
                      DBSet.deletePost(collectionName!, post.id!);
                    })
          )),
      ]),
      Divider(thickness: 1, height: 1, color: Colors.black),
      Container(
          padding: EdgeInsets.fromLTRB(0, 10, 0, 5),
          alignment: Alignment.centerLeft,
          child: SelectionArea(
            child: Text(
              "가격 ${post.price!}원",
              style: const TextStyle(fontSize: 18),
          ))),
      if (post.images!.isNotEmpty)
        (Container(
            padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
            child: Column(
              children: [
                for (String url in post.images!)
                  Semantics(
                    label: '사용자가 올린 사진',
                    child: Container(
                      child: Image.network(url),
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                  ))
              ],
            ))),
      Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
          child: SelectionArea(
            child: Text(
              post.content!,
              style: const TextStyle(fontSize: 17),
          ))),
      //Divider(thickness: 1, height: 1, color: Colors.black),
      Row(children: [
          OutlinedButton.icon(
            onPressed: () {
                HapticFeedback.lightImpact();// 약한 진동
                post.likesPeople!.contains(user?.uid)
                    ? DBSet.cancelLike(collectionName!, post.id!, user!.uid)
                    : DBSet.addLike(collectionName!, post.id!, user!.uid);
              },
              style: ElevatedButton.styleFrom(
                fixedSize: Size(188.5, 37),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(4))
                ),
                side: BorderSide(color: Color.fromARGB(255, 255, 45, 45), width: 1.5),
                foregroundColor: Color.fromARGB(255, 255, 45, 45),
              ),
              icon: post.likesPeople!.contains(user?.uid)
                  ? const Icon(Icons.favorite, semanticLabel: "좋아요 취소")
                  : const Icon(Icons.favorite_outline, semanticLabel: "좋아요 추가"), 
              label: Text('좋아요  ${post.likes}'),
              ),
              Text(' '),
              OutlinedButton.icon(
            onPressed: () {
              HapticFeedback.lightImpact();// 약한 진동
              post.scrapPeople!.contains(user?.uid)
                  ? DBSet.cancelScrap(collectionName!, post.id!, user!.uid)
                  : DBSet.addScrap(collectionName!, post.id!, user!.uid);
            },
              style: ElevatedButton.styleFrom(
                fixedSize: Size(188.5, 37),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(4))
                ),
                side: BorderSide(color: Color.fromARGB(255, 64, 130, 75), width: 1.5),
                foregroundColor: Color.fromARGB(255, 64, 130, 75),
              ),
              icon: post.scrapPeople!.contains(user?.uid)
                ? const Icon(Icons.star, semanticLabel: "스크랩 취소")
                : const Icon(Icons.star_outline, semanticLabel: "스크랩 추가"),
              label: Text('스크랩'),
              ),
        ]),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    String collectionName = widget.collectionName;
    String documentID = widget.documentID;

    return StreamBuilder<NanumPostModel>(
        stream: DBGet.readNanumDocument(
            collection: collectionName, documentID: documentID),
        builder: (context, AsyncSnapshot<NanumPostModel> snapshot) {
          if (snapshot.hasData) {
            NanumPostModel? post = snapshot.data;
            return _buildListItem(collectionName, post);
          } else
            return const Text('게시물을 찾을 수 없습니다.');
        });
  }
}
