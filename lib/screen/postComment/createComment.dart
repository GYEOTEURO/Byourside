import 'package:byourside/model/db_set.dart';
import 'package:byourside/screen/postComment/scrollController.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../main.dart';
import '../../model/comment.dart';

class CreateComment extends StatefulWidget {
  const CreateComment(
      {super.key,
      required this.collectionName,
      required this.documentID,
      required this.primaryColor});

  final String collectionName;
  final String documentID;
  final Color primaryColor;

  @override
  State<CreateComment> createState() => _CreateCommentState();
}

class _CreateCommentState extends State<CreateComment> {
  final User? user = FirebaseAuth.instance.currentUser;
  final TextEditingController comment = TextEditingController();
  final scrollController = Get.put(ScrollDownForComment());

  @override
  Widget build(BuildContext context) {
    String collectionName = widget.collectionName;
    String documentID = widget.documentID;

    return GestureDetector(
        onTap: () => HapticFeedback.lightImpact(), //약한 진동
        child: Semantics(
              container: true,
              textField: true,
              label: '댓글을 작성해주세요.',
              child: TextFormField(
                controller: comment,
                minLines: 1,
                maxLines: 5,
                decoration: InputDecoration(
                  labelText: "댓글을 작성해주세요.",
                  floatingLabelStyle: TextStyle(
                    color: primaryColor,
                    fontSize: 22,
                    fontFamily: 'NanumGothic',
                    fontWeight: FontWeight.w500),
                  contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                  hintStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 17,
                      fontFamily: 'NanumGothic',
                      fontWeight: FontWeight.w500),
                  labelStyle: TextStyle(
                      color: primaryColor,
                      fontSize: 17,
                      fontFamily: 'NanumGothic',
                      fontWeight: FontWeight.w500),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: primaryColor),
                      borderRadius: BorderRadius.circular(20)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: primaryColor),
                      borderRadius: BorderRadius.circular(20)),
                  border:
                      OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                suffixIcon: IconButton(
                  onPressed: () {
                    HapticFeedback.lightImpact(); // 약한 진동
                    FocusScope.of(context).unfocus();
                    CommentModel commentData = CommentModel(
                        uid: user!.uid,
                        nickname: user!.displayName,
                        content: comment.text,
                        datetime: Timestamp.now());
                    DBSet.addComment(collectionName, documentID, commentData);
                    scrollController.scrollController.animateTo(
                      scrollController.scrollController.position.maxScrollExtent, 
                      duration: Duration(milliseconds: 10), 
                      curve: Curves.ease);
                  },
                  icon: Icon(Icons.send, 
                    semanticLabel: "작성한 댓글 저장",
                    color: primaryColor,
                  ))
                ))
            )
          );
  }
}
