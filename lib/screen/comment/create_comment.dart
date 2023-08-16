import 'package:byourside/constants/fonts.dart' as fonts;
import 'package:byourside/constants/colors.dart' as colors;
import 'package:byourside/model/save_data.dart';
import 'package:byourside/screen/comment/scroll_controller.dart';
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
  final scrollController = Get.put(ScrollDownForComment());
  final SaveData saveData = SaveData();

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
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(20, 20),
                  backgroundColor: colors.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(28),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 8),
                ),
                child: const Text(
                    '입력',
                    style: TextStyle(
                        color: colors.textColor,
                        fontSize: 16,
                        fontFamily: fonts.font,
                        fontWeight: FontWeight.w700,
                    ),
                ),
                onPressed: () {
                  HapticFeedback.lightImpact(); // 약한 진동
                  FocusScope.of(context).unfocus();
                  CommentModel comment = CommentModel(
                      uid: user.uid,
                      nickname: user.displayName!,
                      content: CreateComment.content.text,
                      createdAt: Timestamp.now());
                  saveData.addComment(
                      collectionName, documentID, comment);
                  scrollController.scrollController.animateTo(
                      scrollController
                          .scrollController.position.maxScrollExtent,
                      duration: const Duration(milliseconds: 10),
                      curve: Curves.ease);
                },
              )
        ]);
  }
}
