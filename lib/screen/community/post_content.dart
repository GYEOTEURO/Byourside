import 'package:byourside/constants/fonts.dart' as fonts;
import 'package:byourside/constants/colors.dart' as colors;
import 'package:byourside/constants/icons.dart' as custom_icons;
import 'package:byourside/model/community_post.dart';
import 'package:byourside/widget/community/image_slider.dart';
import 'package:byourside/widget/common/time_convertor.dart';
import 'package:flutter/material.dart';

class CommunityPostContent extends StatefulWidget {
  const CommunityPostContent({super.key, required this.post});

  final CommunityPostModel post;

  @override
  State<CommunityPostContent> createState() => _CommunityPostContentState();
}

class _CommunityPostContentState extends State<CommunityPostContent> {
  Widget _buildCategory(String category) {
    return Align(
        alignment: Alignment.centerLeft,
        child: SelectionArea(
            child: Text(
          category,
          semanticsLabel: category,
          style: const TextStyle(
            fontFamily: fonts.font,
            color: colors.primaryColor,
            fontSize: 15,
            fontWeight: FontWeight.w800,
          ),
        )));
  }

  Widget _buildUserProfile(String nickname) {
    return Row(children: [
      custom_icons.profile,
      const SizedBox(width: 8),
      Text(nickname,
          semanticsLabel: nickname,
          style: const TextStyle(
            fontFamily: fonts.font,
            color: colors.textColor,
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ))
    ]);
  }

  Widget _buildTitle(String title) {
    return Align(
        alignment: Alignment.centerLeft,
        child: SelectionArea(
            child: Text(
          title,
          semanticsLabel: title,
          style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              fontFamily: fonts.font,
              color: colors.textColor),
        )));
  }

  Widget _buildContent(String content) {
    return Wrap(children: [
      Text(
        content,
        semanticsLabel: content,
        style: const TextStyle(
          fontSize: 13,
          fontFamily: fonts.font,
          fontWeight: FontWeight.w400,
        ),
      )
    ]);
  }

  Widget _buildLikesAndScraps(
      String likesOrScraps, icon, String likesOrScrapsCount) {
    return Row(children: [
      Text(
        likesOrScraps,
        semanticsLabel: likesOrScraps,
        style: const TextStyle(
          color: colors.subColor,
          fontSize: 13,
          fontFamily: fonts.font,
          fontWeight: FontWeight.w400,
        ),
      ),
      const SizedBox(width: 10),
      icon,
      const SizedBox(width: 5),
      Text(
        likesOrScrapsCount,
        semanticsLabel: likesOrScrapsCount,
        style: const TextStyle(
          color: colors.subColor,
          fontSize: 13,
          fontFamily: fonts.font,
          fontWeight: FontWeight.w400,
        ),
      )
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const SizedBox(height: 5),
      _buildCategory(widget.post.category),
      const SizedBox(height: 20),
      _buildUserProfile(widget.post.nickname),
      const SizedBox(height: 12),
      _buildTitle(widget.post.title),
      const SizedBox(height: 12),
      _buildContent(widget.post.content),
      const SizedBox(height: 12),
      if (widget.post.images.isNotEmpty)
        ImageSlider(images: widget.post.images, imgInfos: widget.post.imgInfos),
      const SizedBox(height: 24),
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Row(children: [
          _buildLikesAndScraps('좋아요', custom_icons.communityPostListLikes,
              widget.post.likes.toString()),
          const SizedBox(width: 20),
          _buildLikesAndScraps('스크랩', custom_icons.communityPostListScraps,
              widget.post.scraps.toString())
        ]),
        TimeConvertor(createdAt: widget.post.createdAt, fontSize: 13.0)
      ]),
      const SizedBox(height: 2),
      const Divider(color: colors.subColor),
    ]);
  }
}
