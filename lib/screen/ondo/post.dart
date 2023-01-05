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
        appBar: AppBar(
          centerTitle: true,
          title: Text("마음온도"),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        body: SingleChildScrollView(
          child: Column(children: [
                  Container(
                    margin: EdgeInsets.all(7), 
                    padding: EdgeInsets.fromLTRB(8, 5, 8, 0),
                    child: OndoPostContent(
                              collectionName: collectionName,
                              documentID: documentID,
                              primaryColor: primaryColor)),
                  Container(
                    margin: EdgeInsets.all(7), 
                    padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
                    child: CreateComment(
                              collectionName: collectionName,
                              documentID: documentID,
                              primaryColor: primaryColor)),
                  Container(
                    margin: EdgeInsets.all(7), 
                    padding: EdgeInsets.fromLTRB(5, 0, 5, 5),
                    child: CommentList(
                              collectionName: collectionName,
                              documentID: documentID,
                              primaryColor: primaryColor),
        )]),
        ));
  }
}
