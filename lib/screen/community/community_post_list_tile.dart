import 'package:byourside/model/community_post.dart';
import 'package:byourside/screen/community/post.dart';
import 'package:byourside/widget/time_convertor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:byourside/constants/colors.dart' as colors;
import 'package:byourside/constants/fonts.dart' as fonts;
import 'package:byourside/constants/icons.dart' as customIcons;

Widget _buildTopSide(BuildContext context, String category, String title) {
  return Container(
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
        Container(
          child: Text(
            title,
            style: TextStyle(
              color: colors.textColor,
              fontSize: 14,
              fontFamily: fonts.font,
              fontWeight: FontWeight.w700,
              height: 1.07,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildMiddleSide(BuildContext context, String content, List<String> image) {
  return Container(
    width: MediaQuery.of(context).size.width,
    child: Row(
          children: [
              Container(
              width: MediaQuery.of(context).size.width * 0.7,
              child: Wrap(
                children: [
                  Text(
                    content,
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
            const SizedBox(width: 20),
            if(image.isNotEmpty)
            Container(
              height: MediaQuery.of(context).size.height / 10,
              width: MediaQuery.of(context).size.height / 10,
              decoration: ShapeDecoration(
                image: DecorationImage(
                  image: NetworkImage(image[0]),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ],
  ));
}

Widget _buildBottomSide(Widget createdAt, String likes, String scraps) {
  return Container(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          child: createdAt
        ),
        Container(
          child: Row(
            children: [
              _buildLikesAndScraps(count: scraps, icon: customIcons.communityPostListScraps),
              const SizedBox(width: 6),
              _buildLikesAndScraps(count: likes, icon: customIcons.communityPostListLikes),
      ],
    ),
  )
      ],
    ),
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
    TimeConvertor createdAt = TimeConvertor(createdAt: post!.createdAt);

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
        padding: const EdgeInsets.all(10),
        child: Column(
        children: [
          _buildTopSide(context, post.category, post.title),
          _buildMiddleSide(context, post.content, post.images),
          _buildBottomSide(createdAt, post.likes.toString(), post.scraps.toString()),
          const Divider(
            height: 1,
            color: colors.subColor,
            thickness: 1
          ),
        ],
      ),
    ));

    // return SizedBox(
    //     height: height / 7,
    //     child: Card(
    //         //semanticContainer: true,
    //         elevation: 2,
    //         child: InkWell(
    //             //Read Document
    //             onTap: () {
    //               HapticFeedback.lightImpact(); // 약한 진동
    //               Navigator.push(
    //                   context,
    //                   MaterialPageRoute(
    //                       builder: (context) => CommunityPost(post: post)
    //                       ));
    //             },
    //             child: Container(
    //               padding: const EdgeInsets.all(2),
    //               margin: const EdgeInsets.fromLTRB(12, 10, 8, 10),
    //               child: Row(
    //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                   children: [
    //                     Expanded(
    //                         child: Column(
    //                       crossAxisAlignment: CrossAxisAlignment.start,
    //                       children: [
    //                         Container(
    //                             margin: const EdgeInsets.fromLTRB(0, 5, 0, 12),
    //                             child: Text(post.title,
    //                                 semanticsLabel: post.title,
    //                                 overflow: TextOverflow.fade,
    //                                 maxLines: 1,
    //                                 softWrap: false,
    //                                 style: const TextStyle(
    //                                     color: colors.textColor,
    //                                     fontSize: 18,
    //                                     fontWeight: FontWeight.bold,
    //                                     fontFamily: fonts.font))),
    //                         createdAt,
    //                       ],
    //                     )),
    //                     // if (post.images.isDefinedAndNotNull)
    //                     //   Semantics(
    //                     //       label: post.imgInfos![0],
    //                     //       child: Image.network(
    //                     //         post.images![0],
    //                     //         width: width * 0.2,
    //                     //         height: height * 0.2,
    //                     //       )),
    //                   ]),
    //             ))));
  }