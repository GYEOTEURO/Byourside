import 'package:byourside/constants/fonts.dart' as fonts;
import 'package:byourside/constants/colors.dart' as colors;
import 'package:byourside/screen/authenticate/controller/user_controller.dart';
import 'package:byourside/model/save_data.dart';
import 'package:byourside/screen/comment/scroll_controller.dart';
import 'package:byourside/widget/fully_rounded_rectangle_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../model/comment.dart';

class CreateComment extends StatefulWidget {
  const CreateComment(
      {super.key,
      required this.collectionName,
      required this.documentID});

  final String collectionName;
  final String documentID;
  static TextEditingController content = TextEditingController();

  @override
  State<CreateComment> createState() => _CreateCommentState();
}

class _CreateCommentState extends State<CreateComment> {
  final User user = FirebaseAuth.instance.currentUser!;
  final SaveData saveData = SaveData();
  final scrollController = Get.find<ScrollDownForComment>();

  @override
  Widget build(BuildContext context) {
    String collectionName = widget.collectionName;
    String documentID = widget.documentID;

    return Row(
        children: [
        Expanded(
          child: Semantics(
            container: true,
            textField: true,
            label: '댓글을 작성해주세요.',
            child: TextFormField(
             onTap: () { HapticFeedback.lightImpact(); },
              controller: CreateComment.content,
                minLines: 1,
                maxLines: 5,
                decoration: InputDecoration(
                    labelText: '댓글을 작성해주세요.',
                    fillColor: colors.bgrColor,
                    filled: true,
                    labelStyle: const TextStyle(
                        color: colors.textColor,
                        fontSize: 10,
                        fontFamily: fonts.font,
                        fontWeight: FontWeight.w500),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(28),
                        borderSide: BorderSide.none),
                    )
               )
              )),
              const SizedBox(width: 15),
              fullyRoundedRectangleButton('입력', 
              () {
                  HapticFeedback.lightImpact();
                  FocusScope.of(context).unfocus();
                  CommentModel comment = CommentModel(
                      uid: user.uid,
                      nickname: Get.find<UserController>().userModel.nickname!,
                      content: CreateComment.content.text,
                      createdAt: Timestamp.now());
                  saveData.addComment(
                      collectionName, documentID, comment);
                  scrollController.scrollController.animateTo(
                      scrollController
                          .scrollController.position.maxScrollExtent,
                      duration: const Duration(milliseconds: 10),
                      curve: Curves.ease);
                  CreateComment.content.text = '';
                })
        ]);
  }
}
