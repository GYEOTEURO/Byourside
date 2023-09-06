import 'package:byourside/model/autoInformation_post.dart';
import 'package:byourside/screen/comment/comment_list.dart';
import 'package:byourside/screen/comment/create_comment.dart';
import 'package:byourside/screen/comment/scroll_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AutoCommentListPage extends StatefulWidget {
  const AutoCommentListPage({super.key, required this.documentID});

  final String collectionName = 'autoInformation_comment';
  final String documentID;

  @override
  State<AutoCommentListPage> createState() => _AutoCommentListPageState();
}

class _AutoCommentListPageState extends State<AutoCommentListPage> {
  final scrollController = Get.put(ScrollDownForComment());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            height: MediaQuery.of(context).size.height,
            child: Stack(children: [
              SingleChildScrollView(
                  controller: scrollController
                      .scrollController, //댓글 전송 누르면 맨 아래로 이동 가능하게
                  child: Container(
                      margin: const EdgeInsets.all(7),
                      padding: const EdgeInsets.fromLTRB(5, 0, 5, 100),
                      child: CommentList(
                          collectionName: widget.collectionName,
                          documentID: widget.documentID))),
              Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Container(
                      width: MediaQuery.of(context).size.width,
                      decoration:
                          const BoxDecoration(color: Colors.white, boxShadow: [
                        BoxShadow(
                          color: Color(0x3F000000),
                          blurRadius: 4,
                          offset: Offset(0, 0),
                          spreadRadius: 0,
                        )
                      ]),
                      padding: const EdgeInsets.fromLTRB(25, 12, 15, 12),
                      child: CreateComment(
                          collectionName: widget.collectionName,
                          documentID: widget.documentID)))
            ])));
  }
}
