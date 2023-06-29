import 'package:byourside/constants.dart' as constants;
import 'package:byourside/model/save_data.dart';
import 'package:byourside/screen/comment/scroll_controller.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

  @override
  State<CreateComment> createState() => _CreateCommentState();
}

class _CreateCommentState extends State<CreateComment> {
  final User? user = FirebaseAuth.instance.currentUser;
  final TextEditingController comment = TextEditingController();
  final scrollController = Get.put(ScrollDownForComment());
  final SaveData saveData = SaveData();

  @override
  Widget build(BuildContext context) {
    String collectionName = widget.collectionName;
    String documentID = widget.documentID;

    return Semantics(
            container: true,
            textField: true,
            label: '댓글을 작성해주세요.',
            child: TextFormField(
                onTap: () => HapticFeedback.lightImpact(),
                controller: comment,
                minLines: 1,
                maxLines: 5,
                decoration: InputDecoration(
                    labelText: '댓글을 작성해주세요.',
                    floatingLabelStyle: const TextStyle(
                        color: constants.mainColor,
                        fontSize: 22,
                        fontFamily: constants.font,
                        fontWeight: FontWeight.w500),
                    contentPadding:
                        const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    hintStyle: const TextStyle(
                        color: Colors.grey,
                        fontSize: 17,
                        fontFamily: constants.font,
                        fontWeight: FontWeight.w500),
                    labelStyle: const TextStyle(
                        color: constants.mainColor,
                        fontSize: 17,
                        fontFamily: constants.font,
                        fontWeight: FontWeight.w500),
                    enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: constants.mainColor),
                        borderRadius: BorderRadius.circular(20)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: constants.mainColor),
                        borderRadius: BorderRadius.circular(20)),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32.0)),
                    suffixIcon: IconButton(
                        onPressed: () {
                          HapticFeedback.lightImpact(); // 약한 진동
                          FocusScope.of(context).unfocus();
                          CommentModel commentData = CommentModel(
                              uid: user!.uid,
                              nickname: user!.displayName,
                              content: comment.text,
                              datetime: Timestamp.now());
                          saveData.addComment(
                              collectionName, documentID, commentData);
                          scrollController.scrollController.animateTo(
                              scrollController
                                  .scrollController.position.maxScrollExtent,
                              duration: const Duration(milliseconds: 10),
                              curve: Curves.ease);
                        },
                        icon: const Icon(
                          Icons.send,
                          semanticLabel: '작성한 댓글 저장',
                          color: constants.mainColor,
                        )))));
  }
}
