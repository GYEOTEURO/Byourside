import 'package:byourside/constants/constants.dart' as constants;
import 'package:byourside/constants/fonts.dart' as fonts;
import 'package:byourside/constants/colors.dart' as colors;
import 'package:byourside/constants/icons.dart' as customIcons;
import 'package:byourside/screen/comment/create_comment.dart';
import 'package:byourside/user_block_list_controller.dart';
import 'package:byourside/widget/block_user.dart';
import 'package:byourside/widget/report.dart';
import 'package:byourside/widget/delete_post_or_comment.dart';
import 'package:byourside/widget/time_convertor.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../model/comment.dart';
import '../../model/load_data.dart';

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

  Widget _numberOfComments(int countComments){
    return Container(
      alignment: Alignment.bottomLeft, 
      child: Text(
          '댓글 ${countComments}',
          style: TextStyle(
            color: colors.textColor,
            fontSize: 13,
            fontFamily: fonts.font,
            fontWeight: FontWeight.w400
          ),
        )
    );
  }


  Widget _buildListItem(String? collectionName, String? documentID, CommentModel? comment) {
    TimeConvertor createdAt = TimeConvertor(createdAt: comment!.createdAt);
    return Container(
  padding: const EdgeInsets.all(16),
  child: Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      customIcons.profile,
      SizedBox(width: 8),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  comment.nickname,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontFamily: fonts.font,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    icon: customIcons.add_ons, 
                    onPressed: (){  }
                  )
                ),
                Spacer(),
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: Color(0x00FF9C9C),
                    shape: BoxShape.circle,
                  ),
                ),
              ],
            ),
            SizedBox(height: 4),
            Text(
              comment.content,
              style: TextStyle(
                color: Color(0xFF1D1E1E),
                fontSize: 12,
                fontFamily: fonts.font,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(height: 4),
            Row(
              children: [
                createdAt,
                Spacer(),
                ElevatedButton(
                  onPressed: () {
                    CreateComment.content.text = comment.nickname;
                  },
                  style: OutlinedButton.styleFrom(
                    //minimumSize: Size(74, 25),
                    padding: EdgeInsets.zero,
                    backgroundColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(93),
                    side: BorderSide(
                              width: 0.50,
                              color: colors.bgrColor,
                            ),
                    )),
                    child: Text(
                          '언급하기',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: colors.bgrColor,
                            fontSize: 13,
                            fontFamily: fonts.font,
                            fontWeight: FontWeight.w400
                          ),
                        ),
                      ),
                    ],
                ),
                SizedBox(width: 8),
       ]),
      ),
    ],
  ),
);

    // return Column(
    //   children: [
    //     Text(
    //       '댓글 ${numberOfComments}'
    //     ),
    //     Row(children: [
    //     customIcons.profile,
    //     Text(
    //       comment!.nickname,
    //       style: TextStyle(
    //         fontFamily: fonts.font,
    //         color: colors.textColor,
    //         fontSize: 14,
    //         fontWeight: FontWeight.w700,
    //       )),
    //     IconButton(
    //       icon: customIcons.add_ons,
    //       onPressed: () {},
    //     )
    //   ]),
    //   Text(comment.content),
    //   Row(
    //     children: [
    //       createdAt,
    //       Column(
    //     mainAxisSize: MainAxisSize.min,
    //     mainAxisAlignment: MainAxisAlignment.start,
    //     crossAxisAlignment: CrossAxisAlignment.start,
    //     children: [
    //         Container(
    //             width: 74,
    //             height: 25,
    //             decoration: ShapeDecoration(
    //                 shape: RoundedRectangleBorder(
    //                     side: BorderSide(
    //                         width: 0.50,
    //                         strokeAlign: BorderSide.strokeAlignCenter,
    //                         color: colors.subColor,
    //                     ),
    //                     borderRadius: BorderRadius.circular(93),
    //                 ),
    //             ),
    //         ),
    //         SizedBox(
    //             width: 51.80,
    //             height: 25,
    //             child: Text(
    //                 '언급하기',
    //                 textAlign: TextAlign.center,
    //                 style: TextStyle(
    //                     color: colors.subColor,
    //                     fontSize: 13,
    //                     fontFamily: fonts.font,
    //                     fontWeight: FontWeight.w400,
    //                     height: 1.85,
    //                 ),
    //             ),
    //         ),
    //     ],
    // ),
    //   ])
    //     ],); 
    
    // Card(
    //     elevation: 2,
    //     child: InkWell(
    //         child: Container(
    //             padding: const EdgeInsets.all(2),
    //             margin: const EdgeInsets.fromLTRB(4, 10, 10, 0),
    //             child: Column(children: [
    //               Align(
    //                   alignment: Alignment.centerLeft,
    //                   child: SelectionArea(
    //                       child: Text('  ${comment.content}',
    //                           semanticsLabel: comment.content,
    //                           style: const TextStyle(
    //                               color: Colors.black,
    //                               fontSize: 16,
    //                               fontWeight: FontWeight.w600,
    //                               fontFamily: constants.font)))),
    //               Row(
    //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                   children: [
    //                     Align(
    //                         alignment: Alignment.centerLeft,
    //                         child: Text(
    //                           '${comment.nickname} | $date $hour:$minute',
    //                           semanticsLabel:
    //                               '닉네임 ${comment.nickname}, $date $hour시$minute분',
    //                           style: const TextStyle(
    //                             color: Colors.black,
    //                             fontSize: 14,
    //                             fontFamily: constants.font,
    //                             fontWeight: FontWeight.w600,
    //                           ),
    //                         )),
    //                     if (user?.uid == comment.uid)
    //                       DeletePostOrComment(
    //                           collectionName: widget.collectionName,
    //                           documentID: widget.documentID,
    //                           commentID: comment.id)
    //                     else
    //                       Row(children: [
    //                         Report(
    //                             reportReasonList: commentReportReason,
    //                             collectionType: 'comment',
    //                             id: comment.id!),
    //                         Container(
    //                             margin: const EdgeInsets.fromLTRB(10, 0, 0, 0),
    //                             child: BlockUser(
    //                                 blockUid: comment.uid,
    //                                 collectionType: 'comment')),
    //                       ])
    //                   ]),
    //             ]))));
  }

  @override
  Widget build(BuildContext context) {
    String collectionName = widget.collectionName;
    String documentID = widget.documentID;
    final userBlockListController = Get.put(UserBlockListController());

    List<String>? blockList = userBlockListController.blockList ?? [];

    return StreamBuilder<List<CommentModel>>(
        stream: loadData.readComments(collectionName: collectionName, documentID: documentID),
        builder: (context, snapshots) {
          if (snapshots.hasData) {
            return Column(
              children: [
              _numberOfComments(snapshots.data!.length),
                ListView.builder(
                  itemCount: snapshots.data!.length,
                  physics:
                      const NeverScrollableScrollPhysics(), //하위 ListView 스크롤 허용
                  shrinkWrap: true, //ListView in ListView를 가능하게
                  itemBuilder: (_, index) {
                    CommentModel comment = snapshots.data![index];
                    if (blockList.contains(comment.uid)) {
                      return Container();
                    } else {
                      return _buildListItem(collectionName, documentID, comment);
                    }
                })
              ]);
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
