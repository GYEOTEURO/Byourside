import 'package:byourside/model/autoInformation_post.dart';
import 'package:byourside/screen/autoInformation/post_appbar.dart';
import 'package:byourside/screen/autoInformation/post_content.dart';
import 'package:byourside/screen/comment/comment_list.dart';
import 'package:byourside/screen/community/post_content.dart';
import 'package:byourside/screen/comment/create_comment.dart';
import 'package:byourside/screen/comment/scroll_controller.dart';
import 'package:byourside/widget/auto_information/autoInfo_image.dart';
import 'package:byourside/widget/complete_add_post_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AutoInfoPost extends StatefulWidget {
  const AutoInfoPost({super.key, required this.post});

  final AutoInformationPostModel post;
  final String collectionName = 'autoInformation_comment';

  @override
  State<AutoInfoPost> createState() => _AutoInfoPostState();
}

class _AutoInfoPostState extends State<AutoInfoPost> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AutoInformationPostAppBar(post: widget.post),
        body: Container(
          color: Colors.white,
          height: MediaQuery.of(context).size.height,
          child: Stack(children: [
            SingleChildScrollView(
                //댓글 전송 누르면 맨 아래로 이동 가능하게
                child: Column(children: [
              Container(child: AutoInfoImage(imageUrls: widget.post.images)),
              Container(child: AutoInfoPostContent(post: widget.post)),
              Container(
                  margin: const EdgeInsets.all(7),
                  padding: const EdgeInsets.fromLTRB(5, 0, 5, 100),
                  child: CommentList(
                      collectionName: widget.collectionName,
                      documentID: widget.post.id!)),
            ])),
            Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                    padding: const EdgeInsets.all(5),
                    width: MediaQuery.of(context).size.width,
                    decoration:
                        const BoxDecoration(color: Colors.white, boxShadow: [
                      BoxShadow(
                        color: Color.fromARGB(62, 0, 0, 0),
                        blurRadius: 4,
                        offset: Offset(0, 0),
                        spreadRadius: 0,
                      )
                    ]),
                    child: Container(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: completeAddPostButton(() {}))))
          ]),
        ));
  }
}
