import 'package:byourside/constants/fonts.dart' as fonts;
import 'package:byourside/constants/colors.dart' as colors;
import 'package:byourside/constants/icons.dart' as custom_icons;
import 'package:byourside/screen/authenticate/controller/user_controller.dart';
import 'package:byourside/model/save_data.dart';
import 'package:byourside/screen/comment/comment_count.dart';
import 'package:byourside/screen/comment/create_comment.dart';
import 'package:byourside/widget/custom_bottom_sheet.dart';
import 'package:byourside/widget/snapshots_has_no_data.dart';
import 'package:byourside/widget/time_convertor.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../model/comment.dart';
import '../../model/load_data.dart';
import 'package:easy_rich_text/easy_rich_text.dart';

class CommentList extends StatefulWidget {
  CommentList(
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
  final SaveData saveData = SaveData();

  Widget _buildContent(String content){
    String mentionedNickname = content.startsWith('@') ? content.split(' ')[0] : '';

    return Align(
      alignment: Alignment.centerLeft, 
      child: EasyRichText(
        content,
        semanticsLabel: content,
        defaultStyle: const TextStyle(
          color: colors.textColor,
          fontSize: 12,
          fontFamily: fonts.font,
          fontWeight: FontWeight.w400,
        ),
        patternList: [
          EasyRichTextPattern(
            targetString: mentionedNickname,
            style: const TextStyle(color: colors.mentionColor),
          )
        ],
      )
    );
  }

  OutlinedButton _mentionButton(String nickname){
    return OutlinedButton(
      onPressed: () {
        HapticFeedback.lightImpact();
        CreateComment.content.text = '@$nickname ';
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
              semanticsLabel: '언급하기',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: colors.subColor,
                fontSize: 13,
                fontFamily: fonts.font,
                fontWeight: FontWeight.w400
              ),
        ),
      );
  }

  Widget _buildCommentList(String? collectionName, String? documentID, CommentModel? comment) {
    TimeConvertor createdAt = TimeConvertor(createdAt: comment!.createdAt, fontSize: 13.0);

    return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          custom_icons.profile,
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      comment.nickname,
                      semanticsLabel: comment.nickname,
                      style: const TextStyle(
                        color: colors.textColor,
                        fontSize: 14,
                        fontFamily: fonts.font,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    IconButton(
                        icon: custom_icons.commentOption,
                        onPressed: (){ 
                          HapticFeedback.lightImpact();
                          customBottomSheet(context, comment.uid == user!.uid, 
                            () { deleteComment(context, widget.collectionName, widget.documentID, comment.id!); }, 
                            () { reportComment(context, widget.collectionName, comment.id!); }, 
                            () { blockComment(context, user!.uid, comment.nickname); });
                        }
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Container(
                  padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                  child: _buildContent(comment.content)
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    createdAt,
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                      child: _mentionButton(comment.nickname)
                    )
                  ],
                ),
                    const SizedBox(width: 8),
          ]),
          ),
        ],
      );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<CommentModel>>(
        stream: loadData.readComments(collectionName: widget.collectionName, documentID: widget.documentID),
        builder: (context, snapshots) {
          if (snapshots.hasData) {
            return Column(
              children: [
                commentCount(context, widget.collectionName, snapshots.data!.length),
                ListView.builder(
                  itemCount: snapshots.data!.length,
                  physics: const NeverScrollableScrollPhysics(), //하위 ListView 스크롤 허용
                  shrinkWrap: true, //ListView in ListView를 가능하게
                  itemBuilder: (_, index) {
                    CommentModel comment = snapshots.data![index];
                    if (Get.find<UserController>().userModel.blockedUsers!.contains(comment.nickname)) {
                      return Container();
                    } else {
                      return _buildCommentList(widget.collectionName, widget.documentID, comment);
                    }
                })
              ]);
          } else {
            return snapshotsHasNoData();
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