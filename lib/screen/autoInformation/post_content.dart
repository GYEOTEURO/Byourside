import 'package:byourside/constants/fonts.dart' as fonts;
import 'package:byourside/constants/colors.dart' as colors;
import 'package:byourside/constants/icons.dart' as custom_icons;
import 'package:byourside/model/autoInformation_post.dart';
import 'package:byourside/model/community_post.dart';
import 'package:byourside/widget/image_slider.dart';
import 'package:byourside/widget/time_convertor.dart';
import 'package:flutter/material.dart';

class AutoInfoPostContent extends StatefulWidget {
  const AutoInfoPostContent({super.key, required this.post});

  final AutoInformationPostModel post;

  @override
  State<AutoInfoPostContent> createState() => _AutoInfoPostContentState();
}

class _AutoInfoPostContentState extends State<AutoInfoPostContent> {
  Widget _buildPostContent(AutoInformationPostModel? post) {
    return Container(
        padding: const EdgeInsets.all(20),
        child: Column(children: [
          Container(
            padding: EdgeInsets.only(top: 10, bottom: 10),
            alignment: Alignment.centerLeft,
            child: Text(
              post!.category,
              style: const TextStyle(
                fontFamily: fonts.font,
                color: colors.primaryColor,
                fontSize: fonts.semiBodyPt,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          Container(
              padding: EdgeInsets.only(top: 10, bottom: 20),
              alignment: Alignment.centerLeft,
              child: SelectionArea(
                  child: Text(
                ' ${post.title}',
                semanticsLabel: ' ${post.title}',
                style: const TextStyle(
                    fontSize: fonts.semiTitlePt,
                    fontWeight: FontWeight.bold,
                    fontFamily: fonts.font,
                    color: colors.textColor),
              ))),
          Container(
              padding: EdgeInsets.only(bottom: 20),
              child: Row(
                children: [
                  Icon(
                    Icons.account_balance,
                    color: colors.primaryColor,
                    size: 30,
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 10),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '사이트',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: fonts.createdAtPt,
                                fontWeight: FontWeight.bold,
                                fontFamily: fonts.font,
                                color: colors.textColor),
                          ),
                          Container(
                              padding: EdgeInsets.only(top: 2),
                              child: Text(
                                post.site,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: fonts.captionTitlePt,
                                    fontWeight: FontWeight.normal,
                                    fontFamily: fonts.font,
                                    color: colors.textColor),
                              ))
                        ]),
                  )
                ],
              )),
          const Divider(thickness: 0.5, color: colors.subColor),
          Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                  color: colors.autoInfoContentBgrColor,
                  borderRadius: BorderRadius.circular(9)),
              child: Text(
                post.content,
                textAlign: TextAlign.start,
                semanticsLabel: post.content,
                style: const TextStyle(
                  fontSize: fonts.captionPt,
                  fontFamily: fonts.font,
                  fontWeight: FontWeight.normal,
                ),
              )),
          const SizedBox(height: 12),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Row(children: [
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
              Text(
                '${post.scraps}',
                style: TextStyle(
                  color: colors.subColor,
                  fontSize: 13,
                  fontFamily: fonts.font,
                  fontWeight: FontWeight.w400,
                  height: 1.69,
                ),
              ),
            ]),
            Container(
                padding: EdgeInsets.all(10),
                child: TimeConvertor(createdAt: post.createdAt, fontSize: 13.0))
          ]),
          const SizedBox(height: 12),
        ]));
  }

  @override
  Widget build(BuildContext context) {
    return _buildPostContent(widget.post);
  }
}
