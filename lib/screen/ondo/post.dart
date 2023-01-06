import 'package:byourside/screen/postComment/commentList.dart';
import 'package:byourside/screen/ondo/ondoPostContent.dart';
import 'package:byourside/screen/postComment/createComment.dart';
import 'package:byourside/screen/postComment/scrollController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
  final scrollController = Get.put(ScrollDownForComment());
  
  @override
  Widget build(BuildContext context) {
    String collectionName = widget.collectionName;
    String documentID = widget.documentID;

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "마음온도",
            style: TextStyle(
              fontFamily: 'NanumGothic',
              fontWeight: FontWeight.bold
            )),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        body: SingleChildScrollView(
          controller: scrollController.scrollController, //댓글 전송 누르면 맨 아래로 이동 가능하게
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
                              primaryColor: primaryColor)),
          ])
        ),
    );
  }
}
