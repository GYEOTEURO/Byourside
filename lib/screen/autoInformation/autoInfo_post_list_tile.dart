import 'package:byourside/model/autoInformation_post.dart';
import 'package:byourside/screen/autoInformation/post.dart';
import 'package:byourside/widget/common/time_convertor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:byourside/constants/colors.dart' as colors;
import 'package:byourside/constants/fonts.dart' as fonts;
import 'package:byourside/constants/icons.dart' as custom_icons;
import 'package:firebase_storage/firebase_storage.dart';

Future<List<String>> _downloadImage(List<String> imageUrls) async {
  List<String> downloadUrls = [];
  if (imageUrls.isEmpty) {
    return downloadUrls;
  }
  for (String imageUrl in imageUrls) {
    Reference storageRef = FirebaseStorage.instance.refFromURL(imageUrl);
    debugPrint('*****************$storageRef');

    try {
      String downloadUrl = await storageRef.getDownloadURL();
      downloadUrls.add(downloadUrl);
    } catch (e) {
      debugPrint('****************Error downloading image: $e');
    }
  }
  return downloadUrls;
}

Widget _imageWidget(
    BuildContext context, List<String> images, String title, double width) {
  if (images.isEmpty) {
    return const SizedBox(
      height: 5,
    );
  } else {
    return FutureBuilder<List<String>>(
      future: _downloadImage(images),
      builder: (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
        if (snapshot.hasData) {
          return Semantics(
            label: '$title 게시글의 이미지',
            child: Container(
              alignment: Alignment.topCenter,
              height: width * 0.26,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(13),
                  topRight: Radius.circular(13),
                ),
              ),
              child: Image.network(snapshot.data![0],
                  width: width, fit: BoxFit.cover),
            ),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}

Widget _buildTopSide(
    BuildContext context, String category, List<String> images, String title) {
  double width = MediaQuery.of(context).size.width;
  return Container(
    width: width,
    child: Stack(
      children: [
        _imageWidget(context, images, title, width),
        Container(
            padding: const EdgeInsets.all(10),
            alignment: Alignment.topLeft,
            child: _buildCategory(category: category, width: width))
      ],
    ),
  );
}

Widget _buildCategory({required String category, required double width}) {
  return Container(
      padding: const EdgeInsets.all(8.0),
      margin: const EdgeInsets.only(left: 5.0, right: 5.0),
      decoration: ShapeDecoration(
        color: colors.primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(69),
        ),
      ),
      child: Text(
        category == '교육' ? '교육/활동' : category,
        style: const TextStyle(
            fontFamily: fonts.font,
            fontSize: fonts.captionTitlePt,
            color: colors.textColor,
            fontWeight: FontWeight.normal),
      ));
}

Widget _buildMiddleSide(BuildContext context, String title) {
  return Container(
      padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
      alignment: Alignment.topLeft,
      child: SizedBox(
          child: Text(
        title,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
          color: colors.textColor,
          fontSize: fonts.captionTitlePt,
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
          Container(
              padding: const EdgeInsets.only(left: 20, bottom: 10),
              child: createdAt),
          _buildScraps(
              count: scraps, icon: custom_icons.communityPostListScraps),
        ],
      ));
}

Widget _buildScraps({required String count, required icon}) {
  return Container(
      padding: const EdgeInsets.only(bottom: 10, right: 20),
      child: Row(children: [
        custom_icons.communityPostListScraps,
        Text(count,
            style: const TextStyle(
              color: colors.subColor,
              fontSize: fonts.createdAtPt,
              fontFamily: fonts.font,
              fontWeight: FontWeight.normal,
            )),
      ]));
}

Widget autoInfoPostListTile(
    BuildContext context, AutoInformationPostModel? post) {
  TimeConvertor createdAt =
      TimeConvertor(createdAt: post!.createdAt, fontSize: fonts.createdAtPt);
  debugPrint('***************${post.images}');

  return GestureDetector(
      onTap: () {
        HapticFeedback.lightImpact();
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => AutoInfoPost(post: post)));
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
            Expanded(
                flex: 3,
                child: _buildTopSide(
                    context, post.category, post.images, post.title)),
            Expanded(flex: 2, child: _buildMiddleSide(context, post.title)),
            Expanded(
                flex: 1,
                child: _buildBottomSide(createdAt, post.scraps.toString()))
          ],
        ),
      ));
}
