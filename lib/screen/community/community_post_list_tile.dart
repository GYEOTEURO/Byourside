import 'package:byourside/model/community_post.dart';
import 'package:byourside/screen/community/post.dart';
import 'package:byourside/widget/time_convertor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:byourside/constants/constants.dart' as constants;
import 'package:byourside/constants/colors.dart' as colors;
import 'package:byourside/constants/fonts.dart' as fonts;
import 'package:byourside/constants/icons.dart' as customIcons;

Widget _buildTopSide(String category, String title) {
  return Container(
    child: Row(
      //mainAxisSize: MainAxisSize.min,
      //mainAxisAlignment: MainAxisAlignment.start,
      //crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(width: 10),
        Text(
          category,
          style: TextStyle(
            color: colors.primaryColor,
            fontSize: fonts.captionTitlePt,
            fontFamily: fonts.font,
            fontWeight: FontWeight.w800
          ),
        ),
        const SizedBox(width: 10),
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

Widget _buildMiddleSide(String content) {
  return Row(
          children: [
            const SizedBox(width: 10),
            SizedBox(
              width: 190,
              child: Text(
                content,
                style: TextStyle(
                  color: colors.textColor,
                  fontSize: 12,
                  fontFamily: fonts.font,
                  fontWeight: FontWeight.w400,
                  height: 1.50,
                ),
              ),
            ),
            const SizedBox(width: 23),
            _buildImage(),
          ],
  );
}

Widget _buildImage() {
  return Container(
    width: 74,
    height: 73.24,
    decoration: ShapeDecoration(
      image: DecorationImage(
        image: NetworkImage("https://via.placeholder.com/74x73"),
        fit: BoxFit.fill,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
  );
}

Widget _buildBottomSide(Widget createdAt, String likes, String scraps) {
  return Container(
    width: 287,
    child: Row(
      children: [
        SizedBox(
          width: 60,
          child: createdAt
        ),
        const SizedBox(width: 144),
        Container(
          width: 80,
          height: 20.07,
          child: Stack(
            children: [
              _buildLikesAndScraps(left: 40, count: scraps, icon: customIcons.communityPostListScraps),
              _buildLikesAndScraps(left: 0, count: likes, icon: customIcons.communityPostListLikes),
      ],
    ),
  )
      ],
    ),
  );
}

Widget _buildLikesAndScraps({required double left, required String count, required icon}) {
  return Positioned(
    left: left,
    child: Container(
      width: 40,
      height: 20.07,
      child: Stack(
        children: [
          Positioned(
            left: 3.99,
            top: 2.53,
            child: Container(
              width: 32.01,
              height: 15,
              child: Row(
                children: [
                  icon,
                  Text(
                  count,
                  style: TextStyle(
                  color: colors.subColor,
                  fontSize: 10,
                  fontFamily: fonts.font,
                  fontWeight: FontWeight.w400,
                  height: 1.30,
                ),
              ),
                ])
            ),
          ),
        ],
      ),
    ),
  );
}

Widget communityPostListTile(BuildContext context, CommunityPostModel? post) {
    TimeConvertor createdAt = TimeConvertor(createdAt: post!.createdAt);

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
      child: GestureDetector(
      onTap: () {
        HapticFeedback.lightImpact(); // 약한 진동
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CommunityPost(post: post)
                ));
      },
      child: Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          _buildTopSide(post.category, post.title),
          _buildMiddleSide(post.content),
          _buildBottomSide(createdAt, post.likes.toString(), post.scraps.toString()),
          Divider(
            height: 1,
            color: colors.subColor,
            thickness: 1
          ),
          const SizedBox(width: 10),
        ],
      ),
    ))
    );

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
    //                                     color: Colors.black,
    //                                     fontSize: 18,
    //                                     fontWeight: FontWeight.bold,
    //                                     fontFamily: constants.font))),
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