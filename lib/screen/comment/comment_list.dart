import 'package:byourside/constants/fonts.dart' as fonts;
import 'package:byourside/constants/colors.dart' as colors;
import 'package:byourside/constants/icons.dart' as customIcons;
import 'package:byourside/model/authenticate/user_controller.dart';
import 'package:byourside/model/community_post.dart';
import 'package:byourside/model/save_data.dart';
import 'package:byourside/screen/comment/create_comment.dart';
import 'package:byourside/widget/customBottomSheet.dart';
import 'package:byourside/widget/time_convertor.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../model/comment.dart';
import '../../model/load_data.dart';

class CommentList extends StatefulWidget {
  CommentList(
      {super.key,
      required this.collectionName,
      required this.post});

  final String collectionName;
  CommunityPostModel post;

  @override
  State<CommentList> createState() => _CommentListState();
}

class _CommentListState extends State<CommentList> {
  final User? user = FirebaseAuth.instance.currentUser;
  final LoadData loadData = LoadData();
  final SaveData saveData = SaveData();

  Widget _numberOfComments(int countComments){
    return Container(
      alignment: Alignment.bottomLeft, 
      child: Text(
          '댓글 $countComments',
          style: const TextStyle(
            color: colors.textColor,
            fontSize: 13,
            fontFamily: fonts.font,
            fontWeight: FontWeight.w400
          ),
        )
    );
  }


  Widget _buildListItem(String? collectionName, String? documentID, CommentModel? comment) {
    TimeConvertor createdAt = TimeConvertor(createdAt: comment!.createdAt, fontSize: 10.0);

    return Container(
      padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          customIcons.profile,
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      comment.nickname,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontFamily: fonts.font,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    IconButton(
                        icon: customIcons.add_ons, 
                        onPressed: (){ 
                          customBottomSheet(context, comment.uid == user!.uid, 
                            () { deleteComment(context, widget.collectionName, widget.post.id!, comment.id!); }, 
                            () { reportComment(context, widget.collectionName, comment.id!); }, 
                            () { blockComment(context, user!.uid, comment.nickname); });
                        }
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                comment.content.split(' ')[0].contains('@') == true ?
                Row(
                  children: [
                    Text(
                  comment.content.split(' ')[0],
                  style: const TextStyle(
                    color: colors.mentionColor,
                    fontSize: 12,
                    fontFamily: fonts.font,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text(
                  comment.content.replaceFirst(comment.content.split(' ')[0], ''),
                  style: const TextStyle(
                    color: Color(0xFF1D1E1E),
                    fontSize: 12,
                    fontFamily: fonts.font,
                    fontWeight: FontWeight.w400,
                  ),
                )])
                : Text(
                  comment.content,
                  style: const TextStyle(
                    color: Color(0xFF1D1E1E),
                    fontSize: 12,
                    fontFamily: fonts.font,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    createdAt,
                    const Spacer(),
                    OutlinedButton(
                      onPressed: () {
                        CreateComment.content.text = '@${comment.nickname} ';
                      },
                      style: OutlinedButton.styleFrom(
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(93),
                        side: const BorderSide(
                          width: 0.50,
                          color: colors.subColor,
                        ),
                        )),
                        child: const Text(
                              '언급하기',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: colors.subColor,
                                fontSize: 13,
                                fontFamily: fonts.font,
                                fontWeight: FontWeight.w400
                              ),
                            ),
                          ),
                        ],
                    ),
                    const SizedBox(width: 8),
          ]),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    String collectionName = widget.collectionName;
    String documentID = widget.post.id!;

    return StreamBuilder<List<CommentModel>>(
        stream: loadData.readComments(collectionName: collectionName, documentID: documentID),
        builder: (context, snapshots) {
          if (snapshots.hasData) {
            return Column(
              children: [
              _numberOfComments(snapshots.data!.length),
                ListView.builder(
                  itemCount: snapshots.data!.length,
                  physics: const NeverScrollableScrollPhysics(), //하위 ListView 스크롤 허용
                  shrinkWrap: true, //ListView in ListView를 가능하게
                  itemBuilder: (_, index) {
                    CommentModel comment = snapshots.data![index];
                    if (Get.find<UserController>().userModel.blockedUsers!.contains(comment.nickname)) {
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
                fontFamily: fonts.font,
                fontWeight: FontWeight.w600,
              ),
            ));
          }
        });
  }

  deleteComment(BuildContext context, String collectionName, String documentID, String commentID){
    saveData.deleteComment(collectionName, documentID, commentID);
    Navigator.pop(context);
  }

  reportComment(BuildContext context, String collectionName, String id){
    saveData.report(collectionName.split('_')[0], 'comment', id);
    Navigator.pop(context);
  }

  blockComment(BuildContext context, String uid, String blockUid){
    Navigator.pop(context);
    Get.find<UserController>().addBlockedUser(blockUid);
  }

}