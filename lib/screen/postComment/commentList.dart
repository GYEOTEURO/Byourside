import 'package:byourside/model/chat_list.dart';
import 'package:byourside/screen/block.dart';
import 'package:byourside/screen/chat/chat_page.dart';
import 'package:byourside/screen/declaration.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
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
  List<String> _decList = [
    "불법 정보를 작성했습니다.",
    "음란물을 작성했습니다.",
    "스팸홍보/도배글을 작성했습니다.",
    "욕설/비하/혐오/차별적 표현을 사용했습니다.",
    "청소년에게 유해한 내용을 작성했습니다.",
    "사칭/사기입니다.",
    "상업적 광고 및 판매 댓글입니다."
  ];

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
      return "error..";
    }
  }

  List<String> blockList = [];

  // 차단 목록
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
    if (mounted) getBlockList(user!.uid);
  }

  Widget _buildListItem(
      String? collectionName, String? documentID, CommentModel? comment) {
    List<String> datetime = comment!.datetime!.toDate().toString().split(' ');
    String date = datetime[0].replaceAll('-', '/');
    String hour = datetime[1].split(':')[0];
    String minute = datetime[1].split(':')[1];

    return Card(
        elevation: 2,
        child: InkWell(
            child: Container(
                padding: const EdgeInsets.all(2),
                margin: EdgeInsets.fromLTRB(4, 10, 10, 0),
                child: Column(children: [
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                          child: SelectionArea(
                              child: Text("  ${comment.content!}",
                                  semanticsLabel: "${comment.content!}",
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: 'NanumGothic'))))),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                            child: TextButton(
                          onPressed: () async {
                            HapticFeedback.lightImpact(); // 약한 진동
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
                                      comment.nickname!,
                                      comment.uid!,
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
                              await groupCollection.doc(groupId).update({
                                "members": FieldValue.arrayUnion(
                                    ["${user?.uid}_${user?.displayName}"])
                              });
                              await userCollection.doc(user?.uid).update({
                                "groups": FieldValue.arrayUnion(
                                    ["${groupId}_${groupName}"])
                              });
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
                              await groupCollection.doc(groupId).update({
                                "members": FieldValue.arrayUnion(
                                    ["${user?.uid}_${user?.displayName}"])
                              });
                              await userCollection.doc(user?.uid).update({
                                "groups": FieldValue.arrayUnion(
                                    ["${groupId}_${groupName}"])
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
                            }
                          },
                          child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "${comment.nickname} | $date $hour:$minute",
                                semanticsLabel:
                                    "닉네임 ${comment.nickname}, $date $hour시$minute분",
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontFamily: 'NanumGothic',
                                  fontWeight: FontWeight.w600,
                                ),
                              )),
                        )),
                        if (user?.uid == comment.uid)
                          (OutlinedButton(
                            style: ElevatedButton.styleFrom(
                              side: BorderSide(
                                  color: widget.primaryColor, width: 1.5),
                              foregroundColor: widget.primaryColor,
                            ),
                            child: Text('삭제',
                                semanticsLabel: '댓글 삭제',
                                style: const TextStyle(
                                  color: Color.fromARGB(255, 255, 45, 45),
                                  fontSize: 14,
                                  fontFamily: 'NanumGothic',
                                  fontWeight: FontWeight.w600,
                                )),
                            onPressed: () {
                              HapticFeedback.lightImpact(); // 약한 진동
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return SingleChildScrollView(
                                      scrollDirection: Axis.vertical,
                                      child: AlertDialog(
                                        semanticLabel:
                                            '댓글을 삭제하시겠습니까? 삭제를 원하시면 하단 왼쪽의 삭제 버튼을 눌러주세요. 취소를 원하시면 하단 오른쪽의 취소 버튼을 눌러주세요.',
                                        title: Text('댓글을 삭제하시겠습니까?',
                                            semanticsLabel:
                                                '댓글을 삭제하시겠습니까? 삭제를 원하시면 하단 왼쪽의 삭제 버튼을 눌러주세요. 취소를 원하시면 하단 오른쪽의 취소 버튼을 눌러주세요.',
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                              fontSize: 14,
                                              fontFamily: 'NanumGothic',
                                              fontWeight: FontWeight.w600,
                                            )),
                                        actions: [
                                          Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                ElevatedButton(
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      backgroundColor:
                                                          widget.primaryColor,
                                                    ),
                                                    onPressed: () {
                                                      HapticFeedback
                                                          .lightImpact(); // 약한 진동
                                                      DBSet.deleteComment(
                                                          collectionName!,
                                                          documentID!,
                                                          comment.id!);
                                                      Navigator.pop(context);
                                                    },
                                                    child: Text('삭제',
                                                        semanticsLabel: '삭제',
                                                        style: const TextStyle(
                                                          fontSize: 14,
                                                          fontFamily:
                                                              'NanumGothic',
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ))),
                                                ElevatedButton(
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      backgroundColor:
                                                          widget.primaryColor,
                                                    ),
                                                    onPressed: () {
                                                      HapticFeedback
                                                          .lightImpact(); // 약한 진동
                                                      Navigator.pop(context);
                                                    },
                                                    child: Text('취소',
                                                        semanticsLabel: '취소',
                                                        style: const TextStyle(
                                                          fontSize: 14,
                                                          fontFamily:
                                                              'NanumGothic',
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        )))
                                              ])
                                        ]));
                                  });
                            },
                          ))
                        else
                          (Row(
                            children: [
                              Declaration(decList: _decList, collectionType: 'comment', id: comment.id!),
                              BlockUser(nickname: comment.nickname!, collectionType: 'comment')
                          ]))
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
                physics:
                    const NeverScrollableScrollPhysics(), //하위 ListView 스크롤 허용
                shrinkWrap: true, //ListView in ListView를 가능하게
                itemBuilder: (_, index) {
                  CommentModel comment = snapshot.data![index];
                  if (blockList.contains(comment.nickname)) {
                    return Container();
                  } else {
                    return _buildListItem(collectionName, documentID, comment);
                  }
                });
          } else
            return const SelectionArea(
                child: Text(
              "댓글이 없습니다. 첫 댓글의 주인공이 되어보세요!",
              semanticsLabel: "댓글이 없습니다. 첫 댓글의 주인공이 되어보세요!",
              style: TextStyle(
                fontFamily: 'NanumGothic',
                fontWeight: FontWeight.w600,
              ),
            ));
        });
  }
}
