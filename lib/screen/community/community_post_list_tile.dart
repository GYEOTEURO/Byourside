import 'package:byourside/model/community_post.dart';
import 'package:byourside/screen/community/post.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:byourside/constants.dart' as constants;

Widget communityPostListTile(BuildContext context, CommunityPostModel? post) {
    String date =
        post!.createdAt.toDate().toString().split(' ')[0].replaceAll('-', '/');

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return SizedBox(
        height: height / 7,
        child: Card(
            //semanticContainer: true,
            elevation: 2,
            child: InkWell(
                //Read Document
                onTap: () {
                  HapticFeedback.lightImpact(); // 약한 진동
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CommunityPost(post: post)
                          ));
                },
                child: Container(
                  padding: const EdgeInsets.all(2),
                  margin: const EdgeInsets.fromLTRB(12, 10, 8, 10),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                margin: const EdgeInsets.fromLTRB(0, 5, 0, 12),
                                child: Text(post.title,
                                    semanticsLabel: post.title,
                                    overflow: TextOverflow.fade,
                                    maxLines: 1,
                                    softWrap: false,
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: constants.font))),
                            Text(
                              '${post.nickname} | $date',
                              semanticsLabel: '${post.nickname}  ${date.split('/')[0]}년 ${date.split('/')[1]}월 ${date.split('/')[2]}일',
                              overflow: TextOverflow.fade,
                              maxLines: 1,
                              softWrap: false,
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontFamily: constants.font,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        )),
                        // if (post.images.isDefinedAndNotNull)
                        //   Semantics(
                        //       label: post.imgInfos![0],
                        //       child: Image.network(
                        //         post.images![0],
                        //         width: width * 0.2,
                        //         height: height * 0.2,
                        //       )),
                      ]),
                ))));
  }