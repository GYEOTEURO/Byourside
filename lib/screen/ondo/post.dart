import 'package:byourside/screen/ondo/appbar.dart';
import 'package:byourside/screen/postComment/commentList.dart';
import 'package:byourside/screen/ondo/ondoPostContent.dart';
import 'package:byourside/screen/postComment/createComment.dart';
import 'package:flutter/material.dart';
import '../../main.dart';

class OndoPost extends StatefulWidget {
  const OndoPost(
      {super.key,
      required this.collectionName,
      required this.documentID,
      required this.primaryColor});

  final String collectionName;
  final String documentID;
  final Color primaryColor;

  @override
  State<OndoPost> createState() => _OndoPostState();
}

class _OndoPostState extends State<OndoPost> {
  @override
  Widget build(BuildContext context) {
    String collectionName = widget.collectionName;
    String documentID = widget.documentID;

    return Scaffold(
        appBar: OndoAppBar(primaryColor: primaryColor),
        body: SingleChildScrollView(
          child: Column(children: [
            OndoPostContent(
                collectionName: collectionName,
                documentID: documentID,
                primaryColor: primaryColor),
            CreateComment(
                collectionName: collectionName,
                documentID: documentID,
                primaryColor: primaryColor),
            CommentList(
                collectionName: collectionName,
                documentID: documentID,
                primaryColor: primaryColor),
          ]),
        ));
  }
}
