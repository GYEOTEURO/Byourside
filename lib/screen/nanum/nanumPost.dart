import 'package:byourside/screen/nanum/appbar.dart';
import 'package:byourside/screen/nanum/nanumPostContent.dart';
import 'package:byourside/screen/postComment/commentList.dart';
import 'package:byourside/screen/postComment/createComment.dart';
import 'package:byourside/screen/postComment/scrollController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../main.dart';

class NanumPost extends StatefulWidget {
  const NanumPost(
      {super.key,
      required this.collectionName,
      required this.documentID,
      required this.primaryColor});

  final String collectionName;
  final String documentID;
  final Color primaryColor;

  @override
  State<NanumPost> createState() => _NanumPostState();
}

class _NanumPostState extends State<NanumPost> {
  final scrollController = Get.put(ScrollDownForComment());

  @override
  Widget build(BuildContext context) {
    String collectionName = widget.collectionName;
    String documentID = widget.documentID;

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("마음나눔",
              semanticsLabel: "마음나눔",
              style: TextStyle(
                  fontFamily: 'NanumGothic', fontWeight: FontWeight.bold)),
          backgroundColor: Theme.of(context).primaryColor,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, semanticLabel: "뒤로 가기", color: Colors.white), onPressed: () { Navigator.pop(context); }),
        ),
        body: SingleChildScrollView(
          controller:
              scrollController.scrollController, //댓글 전송 누르면 맨 아래로 이동 가능하게
          child: Column(children: [
            Container(
                margin: EdgeInsets.all(7),
                padding: EdgeInsets.fromLTRB(8, 5, 8, 0),
                child: NanumPostContent(
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
            )
          ]),
        ));
  }
}
