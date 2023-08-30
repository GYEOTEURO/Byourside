import 'package:byourside/model/community_post.dart';
import 'package:byourside/screen/community/post.dart';
import 'package:byourside/widget/time_convertor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:byourside/constants/colors.dart' as colors;
import 'package:byourside/constants/fonts.dart' as fonts;
import 'package:byourside/constants/icons.dart' as custom_icons;

Widget _buildTopSide(BuildContext context, String category, String title) {
  return SizedBox(
    width: MediaQuery.of(context).size.width,
    child: Row(
      children: [
        Text(
          category,
          style: const TextStyle(
            color: colors.primaryColor,
            fontSize: fonts.captionTitlePt,
            fontFamily: fonts.font,
            fontWeight: FontWeight.w800
          ),
        ),
        const SizedBox(width: 20),
        Text(
          title,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            color: colors.textColor,
            fontSize: 14,
            fontFamily: fonts.font,
            fontWeight: FontWeight.w700,
            height: 1.07,
          ),
        ),
      ],
    ),
  );
}

Widget _buildMiddleSide(BuildContext context, String content, List<String> images, List<String> imgInfos) {
  return SizedBox(
    width: MediaQuery.of(context).size.width,
    child: Row(
          children: [
              SizedBox(
              width: MediaQuery.of(context).size.width * 0.7,
              child: Wrap(
                children: [
                  Text(
                    content,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: colors.textColor,
                      fontSize: 12,
                      fontFamily: fonts.font,
                      fontWeight: FontWeight.w400,
                      height: 1.50,
                    ),
                  ),
              ])
            ),
            const SizedBox(width: 10),
            if(images.isNotEmpty)
            SizedBox(
              height: MediaQuery.of(context).size.height / 10.5,
              width: MediaQuery.of(context).size.height / 10.5,
              child: Semantics(
                label: imgInfos[0],
                child: Image.network(images[0])
              )
            )
            else 
              SizedBox(
                height: MediaQuery.of(context).size.height / 10.5,
                width: MediaQuery.of(context).size.height / 10.5,
            )
          ],
  ));
}

Widget _buildBottomSide(Widget createdAt, String likes, String scraps) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      SizedBox(
        child: createdAt
      ),
      Row(
        children: [
          _buildLikesAndScraps(count: likes, icon: custom_icons.communityPostListLikes),
          const SizedBox(width: 6),
          _buildLikesAndScraps(count: scraps, icon: custom_icons.communityPostListScraps),
    ],
  )
    ],
  );
}

Widget _buildLikesAndScraps({required String count, required icon}) {
  return Row(
          children: [
            icon,
            const SizedBox(width: 3),
            Text(
            count,
            style: const TextStyle(
            color: colors.subColor,
            fontSize: 10,
            fontFamily: fonts.font,
            fontWeight: FontWeight.w400,
            height: 1.30,
          ),
        ),
          ]);
}

Widget communityPostListTile(BuildContext context, CommunityPostModel? post) {
    TimeConvertor createdAt = TimeConvertor(createdAt: post!.createdAt, fontSize: 10.0);

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () {
        HapticFeedback.lightImpact(); // 약한 진동
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CommunityPost(post: post)
                ));
      },
      child: Container(
        height: height / 6,
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
        child: Column(
        children: [
          _buildTopSide(context, post.category, post.title),
          _buildMiddleSide(context, post.content, post.images, post.imgInfos),
          _buildBottomSide(createdAt, post.likes.toString(), post.scraps.toString()),
          const Divider(
            height: 1,
            color: colors.subColor,
            thickness: 1
          ),
        ],
      ),
    ));
}