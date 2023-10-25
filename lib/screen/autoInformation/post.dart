import 'package:byourside/model/autoInformation_post.dart';
import 'package:byourside/screen/autoInformation/post_appbar.dart';
import 'package:byourside/screen/autoInformation/post_content.dart';
import 'package:byourside/screen/comment/auto_comment_list.dart';
import 'package:byourside/widget/auto_information/autoInfo_image.dart';
import 'package:byourside/widget/auto_information/link_url_button.dart';
import 'package:flutter/material.dart';
import 'package:byourside/constants/colors.dart' as colors;
import 'package:url_launcher/url_launcher.dart';

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
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                  Container(
                    child: AutoInfoImage(imageUrls: widget.post.images),
                  ),
                  Container(child: AutoInfoPostContent(post: widget.post)),
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
                        padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.7,
                                  child: linkUrlButton(() {
                                    launchUrl(
                                        Uri.parse(widget.post.contentLink));
                                  })),
                              Container(
                                decoration: const ShapeDecoration(
                                  color: colors.imgSubtitleColor,
                                  shape: CircleBorder(),
                                ),
                                child: IconButton(
                                  icon: const Icon(Icons.textsms_rounded),
                                  color: colors.primaryColor,
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                AutoCommentListPage(
                                                  documentID: widget.post.id!,
                                                )));
                                  },
                                ),
                              ),
                            ]))))
          ]),
        ));
  }
}
