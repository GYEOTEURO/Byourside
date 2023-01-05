import 'package:byourside/model/db_set.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
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

  @override
  Widget build(BuildContext context) {
    String collectionName = widget.collectionName;
    String documentID = widget.documentID;
    final TextEditingController comment = TextEditingController();

    return GestureDetector(
        //onTap: () => HapticFeedback.lightImpact(), //약한 진동
        child: Row(children: [
          Expanded(
            child: TextField(
                controller: comment,
                minLines: 1,
                maxLines: 8,
                decoration: InputDecoration(
                  labelText: "댓글을 작성해주세요.",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                    borderSide: BorderSide(width: 1),
                  ),
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
                  },
                  icon: Icon(Icons.send, 
                    semanticLabel: "작성한 댓글 저장",
                    color: primaryColor,
                  ))
                )),
          ),
        ]));
  }
}
