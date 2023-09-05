import 'package:byourside/model/autoInformation_post.dart';
import 'package:byourside/model/community_post.dart';
import 'package:byourside/screen/community/post.dart';
import 'package:byourside/widget/community/add_post/autoInfo_image.dart';
import 'package:byourside/widget/time_convertor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:byourside/constants/colors.dart' as colors;
import 'package:byourside/constants/fonts.dart' as fonts;
import 'package:byourside/constants/icons.dart' as custom_icons;
import 'package:firebase_storage/firebase_storage.dart';

List<String> _downloadUrls = [];

Future<void> _downloadImage(List<String>? imageUrls) async {
  List<String> downloadUrls = [];
  if (imageUrls == Null) {
    return;
  }
  for (String imageUrl in imageUrls!) {
    Reference storageRef = FirebaseStorage.instance.refFromURL(imageUrl!);
    debugPrint('*****************$storageRef');

    try {
      String downloadUrl = await storageRef.getDownloadURL();
      downloadUrls.add(downloadUrl);
    } catch (e) {
      debugPrint('****************Error downloading image: $e');
    }
  }
  _downloadUrls = downloadUrls;
}

Widget _buildTopSide(
    BuildContext context, String category, List<String> images, String title) {
  _downloadImage(images);

  double _width = MediaQuery.of(context).size.width;
  debugPrint("***************$images");
  return Container(
    width: _width,
    child: Stack(
      children: [
        if (_downloadUrls.isNotEmpty)
          Semantics(
              label: '$title 게시글 의 이미지',
              child: Container(
                  alignment: Alignment.topCenter,
                  height: _width * 0.26,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(13),
                    topRight: Radius.circular(13),
                  )),
                  child: Image.network(
                    _downloadUrls[0],
                    width: _width,
                    fit: BoxFit.cover,
                  )))
        else
          SizedBox(height: _width * 0.17),
        Container(
            padding: const EdgeInsets.all(10),
            alignment: Alignment.topLeft,
            child: _buildCategory(category: category, width: _width))
      ],
    ),
  );
}

Widget _buildCategory({required String category, required double width}) {
  return Container(
      padding: const EdgeInsets.all(2.0),
      margin: const EdgeInsets.only(left: 3.0, right: 3.0),
      decoration: ShapeDecoration(
        color: colors.primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(9.33),
        ),
      ),
      child: Text(
        category,
        style: const TextStyle(
            fontFamily: fonts.font,
            fontSize: fonts.createdAtPt,
            color: colors.textColor,
            fontWeight: FontWeight.normal),
      ));
}

Widget _buildMiddleSide(BuildContext context, String title) {
  return Container(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
      alignment: Alignment.centerLeft,
      child: SizedBox(
          child: Text(
        title,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
          color: colors.textColor,
          fontSize: fonts.semiBodyPt,
          fontFamily: fonts.font,
          fontWeight: FontWeight.bold,
        ),
      )));
}

Widget _buildBottomSide(Widget createdAt, String scraps) {
  return Container(
      alignment: Alignment.bottomCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(child: createdAt),
          _buildScraps(
              count: scraps, icon: custom_icons.communityPostListScraps),
        ],
      ));
}

Widget _buildScraps({required String count, required icon}) {
  return Text(
    count,
    style: const TextStyle(
      color: colors.subColor,
      fontSize: fonts.createdAtPt,
      fontFamily: fonts.font,
      fontWeight: FontWeight.w400,
    ),
  );
}

Widget autoInfoPostListTile(
    BuildContext context, AutoInformationPostModel? post) {
  TimeConvertor createdAt =
      TimeConvertor(createdAt: post!.createdAt, fontSize: fonts.createdAtPt);

  return GestureDetector(
      onTap: () {
        HapticFeedback.lightImpact();
        // Navigator.push(context,
        //     MaterialPageRoute(builder: (context) => AutoInfoPost(post: post)));
      },
      child: Container(
        margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
        width: MediaQuery.of(context).size.width * 0.85,
        height: MediaQuery.of(context).size.width * 0.45,
        decoration: ShapeDecoration(
            color: colors.autoInfoPostColors[post.category],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(13),
            )),
        child: Column(
          children: [
            _buildTopSide(context, post.category, post.images, post.title),
            _buildMiddleSide(context, post.title),
            _buildBottomSide(createdAt, post.scraps.toString())
          ],
        ),
      ));
}
