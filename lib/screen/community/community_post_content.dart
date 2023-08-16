import 'package:byourside/constants/constants.dart' as constants;
import 'package:byourside/constants/fonts.dart' as fonts;
import 'package:byourside/constants/colors.dart' as colors;
import 'package:byourside/constants/icons.dart' as customIcons;
import 'package:byourside/model/community_post.dart';
import 'package:byourside/widget/block_user.dart';
import 'package:byourside/widget/report.dart';
import 'package:byourside/widget/delete_post_or_comment.dart';
import 'package:byourside/widget/image_slider.dart';
import 'package:byourside/widget/likes_button.dart';
import 'package:byourside/widget/scrap_button.dart';
import 'package:byourside/widget/time_convertor.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../model/load_data.dart';
import '../../model/save_data.dart';

class CommunityPostContent extends StatefulWidget {
  const CommunityPostContent(
      {super.key,
      required this.post});

  final CommunityPostModel post;

  @override
  State<CommunityPostContent> createState() => _CommunityPostContentState();
}

class _CommunityPostContentState extends State<CommunityPostContent> {
  Widget _buildPostContent(String? collectionName, CommunityPostModel? post) {
    return Column(
      children: [
       Align(
          alignment: Alignment.centerLeft,
          child: SelectionArea(
            child: Text(
              post!.category,
              style: TextStyle(
                fontFamily: fonts.font,
                color: colors.primaryColor,
                fontSize: 15,
                fontWeight: FontWeight.w800,
              ),
            )
          ),
      ),
      Row(children: [
        customIcons.profile,
        Text(
          post.nickname,
          style: TextStyle(
            fontFamily: fonts.font,
            color: colors.textColor,
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ))
      ]),
      Align(
          alignment: Alignment.centerLeft,
          child: SelectionArea(
              child: Text(
            ' ${post.title}',
            semanticsLabel: ' ${post.title}',
            style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                fontFamily: fonts.font,
                color: colors.textColor),
          ))),
      Container(
          padding: const EdgeInsets.fromLTRB(0, 25, 0, 20),
          alignment: Alignment.centerLeft,
          child: SelectionArea(
              child: Text(
            post.content,
            semanticsLabel: post.content,
            style: const TextStyle(
              fontSize: 13,
              fontFamily: fonts.font,
              fontWeight: FontWeight.w400,
            ),
          ))),
       if (post.images.isNotEmpty) ImageSlider(images: post.images, imgInfos: post.imgInfos),
      Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
       Text(
        '좋아요'
      ),
      customIcons.communityPostListLikes,
      Text(
        '${post.likes}'
      ),
      Text(
        '스크랩'
      ),
      customIcons.communityPostListScraps,
      Text(
        '${post.scraps}'
      ),
      TimeConvertor(createdAt: post.createdAt)
      ]),
      Divider(thickness: 1, height: 0.5, color: Colors.black),
   
    ]);   
  }

  @override
  Widget build(BuildContext context) {
    String collectionName = 'communityPost';

    return _buildPostContent(collectionName, widget.post);}
  }

