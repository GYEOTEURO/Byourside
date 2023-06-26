import 'package:byourside/constants.dart' as constants;
import 'package:byourside/screen/comment/comment_list.dart';
import 'package:byourside/screen/community/community_post_content.dart';
import 'package:byourside/screen/comment/create_comment.dart';
import 'package:byourside/screen/comment/scroll_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommunityPost extends StatefulWidget {
  const CommunityPost(
      {super.key,
      required this.collectionName,
      required this.documentID,
      required this.primaryColor});

  final String collectionName;
  final String documentID;
  final Color primaryColor;

  @override
  State<CommunityPost> createState() => _CommunityPostState();
}

class _CommunityPostState extends State<CommunityPost> {
  final scrollController = Get.put(ScrollDownForComment());

  @override
  Widget build(BuildContext context) {
    String collectionName = widget.collectionName;
    String documentID = widget.documentID;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('커뮤니티',
            semanticsLabel: '커뮤니티',
            style: TextStyle(
                fontFamily: constants.font, fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFF045558),
        leading: IconButton(
            icon: const Icon(Icons.arrow_back,
                semanticLabel: '뒤로 가기', color: Colors.white),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      body: SingleChildScrollView(
          controller:
              scrollController.scrollController, //댓글 전송 누르면 맨 아래로 이동 가능하게
          child: Column(children: [
            Container(
                margin: const EdgeInsets.all(7),
                padding: const EdgeInsets.fromLTRB(8, 5, 8, 0),
                child: CommunityPostContent(
                    collectionName: collectionName,
                    documentID: documentID,
                    primaryColor: constants.mainColor)),
            Container(
                margin: const EdgeInsets.all(7),
                padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                child: CreateComment(
                    collectionName: collectionName,
                    documentID: documentID,
                    primaryColor: constants.mainColor)),
            Container(
                margin: const EdgeInsets.all(7),
                padding: const EdgeInsets.fromLTRB(5, 0, 5, 5),
                child: CommentList(
                    collectionName: collectionName,
                    documentID: documentID,
                    primaryColor: constants.mainColor)),
          ])),
    );
  }
}