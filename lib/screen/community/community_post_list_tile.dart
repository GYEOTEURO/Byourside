import 'package:byourside/constants/fonts.dart' as fonts;
import 'package:byourside/constants/colors.dart' as colors;
import 'package:byourside/constants/icons.dart' as custom_icons;
import 'package:byourside/model/community_post.dart';
import 'package:byourside/screen/community/post.dart';
import 'package:byourside/widget/common/time_convertor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Text _buildCategory(String category){
  return Text(
    category,
    semanticsLabel: category,
    style: const TextStyle(
      color: colors.primaryColor,
      fontSize: 13,
      fontFamily: fonts.font,
      fontWeight: FontWeight.w800
    ),
  );
}

Text _buildTitle(String title){
  return Text(
    title,
    semanticsLabel: title,
    overflow: TextOverflow.ellipsis,
    maxLines: 1,
    softWrap: false,
    style: const TextStyle(
      color: colors.textColor,
      fontSize: 14,
      fontFamily: fonts.font,
      fontWeight: FontWeight.w700,
    ),
  );
}

Text _buildContent(String content){
  return Text(
    content,
    semanticsLabel: content,
    overflow: TextOverflow.ellipsis,
    maxLines: 3,
    softWrap: false,
    textAlign: TextAlign.justify,
    style: const TextStyle(
      color: colors.textColor,
      fontSize: 12,
      fontFamily: fonts.font,
      fontWeight: FontWeight.w400,
    ),
  );
}

Widget _buildImage(width, height, List<String> images, List<String> imgInfos){
  return Container(
    width: width /5,
    height: width / 5,
    child: Semantics(
        label: imgInfos[0],
        child: Image.network(images[0])
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
            semanticsLabel: '$count개',
            style: const TextStyle(
            color: colors.subColor,
            fontSize: 10,
            fontFamily: fonts.font,
            fontWeight: FontWeight.w400,
          ),
        ),
          ]);
}

Widget communityPostListTile(BuildContext context, CommunityPostModel? post) {
    TimeConvertor createdAt = TimeConvertor(createdAt: post!.createdAt, fontSize: 10.0);
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: () {
        HapticFeedback.lightImpact();
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CommunityPost(post: post)
                ));
      },
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(25, 5, 25, 5),
            child:
              Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildCategory(post.category),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildTitle(post.title),
                      const SizedBox(height: 4),
                      post.images.isNotEmpty == true ?
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                            width: width * 0.5,
                            child: _buildContent(post.content),
                          ),
                          _buildImage(width, height, post.images, post.imgInfos)
                      ])
                      : Container(
                            alignment: Alignment.centerLeft,
                            width: width,
                            height: height / 11,
                            child: _buildContent(post.content),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          createdAt,
                          const Spacer(),
                          Row(
                            children: [
                              _buildLikesAndScraps(count: post.likes.toString(), icon: custom_icons.communityPostListLikes),
                              const SizedBox(width: 6),
                              _buildLikesAndScraps(count: post.scraps.toString(), icon: custom_icons.communityPostListScraps),
                          ])   
                      ]),
                      const SizedBox(width: 8),
                      ]),
                      ),
                    ])),
                    Container(
                      padding: const EdgeInsets.fromLTRB(25, 10, 25, 10),
                      child: const Divider(
                        height: 1,
                        color: colors.bgrColor,
                        thickness: 1
                    ))
                ])
    ); 
  }