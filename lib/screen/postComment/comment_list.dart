import 'package:byourside/model/chat_list.dart';
import 'package:byourside/screen/common/block_user.dart';
import 'package:byourside/screen/chat/chat_page.dart';
import 'package:byourside/screen/common/report.dart';
import 'package:byourside/screen/common/delete.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import '../../model/comment.dart';
import '../../model/load_data.dart';
import 'package:multiple_stream_builder/multiple_stream_builder.dart';

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
  final List<String> _decList = [
    '불법 정보를 작성했습니다.',
    '음란물을 작성했습니다.',
    '스팸홍보/도배글을 작성했습니다.',
    '욕설/비하/혐오/차별적 표현을 사용했습니다.',
    '청소년에게 유해한 내용을 작성했습니다.',
    '사칭/사기입니다.',
    '상업적 광고 및 판매 댓글입니다.'
  ];

  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('user');
  final CollectionReference groupCollection =
      FirebaseFirestore.instance.collection('groups');

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
      return 'error..';
    }
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
                margin: const EdgeInsets.fromLTRB(4, 10, 10, 0),
                child: Column(children: [
                  Align(
                      alignment: Alignment.centerLeft,
                      child: SelectionArea(
                          child: Text('  ${comment.content!}',
                              semanticsLabel: comment.content,
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'NanumGothic')))),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                            child: TextButton(
                          onPressed: () async {
                            HapticFeedback.lightImpact(); // 약한 진동
                            var groupName =
                                '${user?.displayName}_${comment.nickname}';
                            var groupNameReverse =
                                '${comment.nickname}_${user?.displayName}';
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
                                'members': FieldValue.arrayUnion(
                                    ['${comment.uid}_${comment.nickname}'])
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
                                'members': FieldValue.arrayUnion(
                                    ['${user?.uid}_${user?.displayName}'])
                              });
                              await userCollection.doc(user?.uid).update({
                                'groups': FieldValue.arrayUnion(
                                    ['${groupId}_$groupName'])
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
                                'members': FieldValue.arrayUnion(
                                    ['${user?.uid}_${user?.displayName}'])
                              });
                              await userCollection.doc(user?.uid).update({
                                'groups': FieldValue.arrayUnion(
                                    ['${groupId}_$groupName'])
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
                                '${comment.nickname} | $date $hour:$minute',
                                semanticsLabel:
                                    '닉네임 ${comment.nickname}, $date $hour시$minute분',
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontFamily: 'NanumGothic',
                                  fontWeight: FontWeight.w600,
                                ),
                              )),
                        )),
                        if (user?.uid == comment.uid)
                          Delete(collectionName: widget.collectionName, documentID: widget.documentID, commentID: comment.id)
                        else
                          Row(children: [
                            Report(
                                decList: _decList,
                                collectionType: 'comment',
                                id: comment.id!),
                            Container(
                                margin: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                                child: BlockUser(
                                    nickname: comment.nickname!,
                                    collectionType: 'comment')),
                          ])
                      ]),
                ]))));
  }

  @override
  Widget build(BuildContext context) {
    String collectionName = widget.collectionName;
    String documentID = widget.documentID;

    List<String> blockList;

    return StreamBuilder2<List<CommentModel>, DocumentSnapshot>(
        streams: StreamTuple2(
            LoadData.readComment(collectionName: collectionName, documentID: documentID),
            FirebaseFirestore.instance.collection('user').doc(user!.uid).snapshots()),
        builder: (context, snapshots) {
          if (snapshots.snapshot2.hasData) {
            blockList = snapshots.snapshot2.data!['blockList'] == null
                ? []
                : snapshots.snapshot2.data!['blockList'].cast<String>();
          } 
          else {
            blockList = [];
          }
          if (snapshots.snapshot1.hasData) {
            return ListView.builder(
                itemCount: snapshots.snapshot1.data!.length,
                physics:
                    const NeverScrollableScrollPhysics(), //하위 ListView 스크롤 허용
                shrinkWrap: true, //ListView in ListView를 가능하게
                itemBuilder: (_, index) {
                  CommentModel comment = snapshots.snapshot1.data![index];
                  if (blockList.contains(comment.nickname)) {
                    return Container();
                  } else {
                    return _buildListItem(collectionName, documentID, comment);
                  }
                });
          } else {
            return const SelectionArea(
                child: Text(
              '댓글이 없습니다. 첫 댓글의 주인공이 되어보세요!',
              semanticsLabel: '댓글이 없습니다. 첫 댓글의 주인공이 되어보세요!',
              style: TextStyle(
                fontFamily: 'NanumGothic',
                fontWeight: FontWeight.w600,
              ),
            ));
          }
        });
  }
}
