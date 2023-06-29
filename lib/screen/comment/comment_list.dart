import 'package:byourside/constants.dart' as constants;
import 'package:byourside/widget/block_user.dart';
import 'package:byourside/widget/report.dart';
import 'package:byourside/widget/delete_post_or_comment.dart';
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
      required this.documentID});

  final String collectionName;
  final String documentID;

  @override
  State<CommentList> createState() => _CommentListState();
}

class _CommentListState extends State<CommentList> {
  final User? user = FirebaseAuth.instance.currentUser;
  final LoadData loadData = LoadData();

  final List<String> commentReportReason = constants.commentReportReasonList;

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
                                  fontFamily: constants.font)))),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              '${comment.nickname} | $date $hour:$minute',
                              semanticsLabel:
                                  '닉네임 ${comment.nickname}, $date $hour시$minute분',
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontFamily: constants.font,
                                fontWeight: FontWeight.w600,
                              ),
                            )),
                        if (user?.uid == comment.uid)
                          DeletePostOrComment(
                              collectionName: widget.collectionName,
                              documentID: widget.documentID,
                              commentID: comment.id)
                        else
                          Row(children: [
                            Report(
                                reportReasonList: commentReportReason,
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
            loadData.readComment(
                collectionName: collectionName, documentID: documentID),
            FirebaseFirestore.instance
                .collection('user')
                .doc(user!.uid)
                .snapshots()),
        builder: (context, snapshots) {
          if (snapshots.snapshot2.hasData) {
            blockList = snapshots.snapshot2.data!['blockList'] == null
                ? []
                : snapshots.snapshot2.data!['blockList'].cast<String>();
          } else {
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
                fontFamily: constants.font,
                fontWeight: FontWeight.w600,
              ),
            ));
          }
        });
  }
}
