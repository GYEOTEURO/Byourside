import 'package:byourside/constants/fonts.dart' as fonts;
import 'package:byourside/constants/colors.dart' as colors;
import 'package:byourside/constants/icons.dart' as custom_icons;
import 'package:byourside/model/community_post.dart';
import 'package:byourside/widget/image_slider.dart';
import 'package:byourside/widget/time_convertor.dart';
import 'package:flutter/material.dart';

class CommunityPostContent extends StatefulWidget {
  const CommunityPostContent({super.key, required this.post});

  final CommunityPostModel post;

  @override
  State<CommunityPostContent> createState() => _CommunityPostContentState();
}

class _CommunityPostContentState extends State<CommunityPostContent> {
  Widget _buildPostContent(CommunityPostModel? post) {
    return Column(children: [
      const SizedBox(height: 5),
      Align(
        alignment: Alignment.centerLeft,
        child: SelectionArea(
            child: Text(
          post!.category,
          style: const TextStyle(
            fontFamily: fonts.font,
            color: colors.primaryColor,
            fontSize: 15,
            fontWeight: FontWeight.w800,
          ),
        )),
      ),
      const SizedBox(height: 12),
      Row(children: [
        custom_icons.profile,
        const SizedBox(width: 8),
        Text(post.nickname,
            style: const TextStyle(
              fontFamily: fonts.font,
              color: colors.textColor,
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ))
      ]),
      const SizedBox(height: 12),
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
      const SizedBox(height: 12),
      Container(
          padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
          alignment: Alignment.centerLeft,
          child: Wrap(children: [
            Text(
              post.content,
              semanticsLabel: post.content,
              style: const TextStyle(
                fontSize: fonts.semiBodyPt,
                fontFamily: fonts.font,
                fontWeight: FontWeight.normal,
              ),
            )
          ])),
      const SizedBox(height: 12),
      if (post.images.isNotEmpty)
        ImageSlider(images: post.images, imgInfos: post.imgInfos),
      const SizedBox(height: 24),
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Row(children: [
          const Text(
            '좋아요',
            style: TextStyle(
              color: colors.subColor,
              fontSize: 13,
              fontFamily: fonts.font,
              fontWeight: FontWeight.w400,
              height: 1.69,
            ),
          ),
          const SizedBox(width: 10),
          custom_icons.communityPostListLikes,
          const SizedBox(width: 5),
          Text('${post.likes}'),
          const SizedBox(width: 20),
          const Text(
            '스크랩',
            style: TextStyle(
              color: colors.subColor,
              fontSize: 13,
              fontFamily: fonts.font,
              fontWeight: FontWeight.w400,
              height: 1.69,
            ),
          ),
          const SizedBox(width: 10),
          custom_icons.communityPostListScraps,
          const SizedBox(width: 5),
          Text('${post.scraps}'),
        ]),
        TimeConvertor(createdAt: post.createdAt, fontSize: 13.0)
      ]),
      const SizedBox(height: 12),
      const Divider(thickness: 1, height: 0.5, color: colors.subColor),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return _buildPostContent(widget.post);
  }
}
