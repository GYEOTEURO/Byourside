import 'package:byourside/constants.dart' as constants;
import 'package:byourside/model/community_post.dart';
import 'package:byourside/model/save_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ScrapButton extends StatefulWidget {
  const ScrapButton(
      {super.key,
      required this.collectionName,
      required this.post,
      required this.uid});

  final String collectionName;
  final CommunityPostModel post;
  final String uid;

  @override
  State<ScrapButton> createState() => _ScrapButtonState();
}

class _ScrapButtonState extends State<ScrapButton> {
  @override
  Widget build(BuildContext context) {
    SaveData saveData = SaveData();
    String uid = widget.uid;
    String collectionName = widget.collectionName;
    CommunityPostModel post = widget.post;

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return OutlinedButton.icon(
      onPressed: () {
        HapticFeedback.lightImpact(); // 약한 진동
        post.scrapPeople!.contains(uid)
            ? saveData.cancelScrap(collectionName, post.id!, uid)
            : saveData.addScrap(collectionName, post.id!, uid);
      },
      style: ElevatedButton.styleFrom(
        fixedSize: Size(width * 0.38, height * 0.06),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(4))),
        side: const BorderSide(
            color: Color.fromARGB(255, 64, 130, 75), width: 1.5),
        foregroundColor: const Color.fromARGB(255, 64, 130, 75),
      ),
      icon: post.scrapPeople!.contains(uid)
          ? const Icon(Icons.star, semanticLabel: '스크랩 취소')
          : const Icon(Icons.star_outline, semanticLabel: '스크랩 추가'),
      label: const Text('스크랩',
          semanticsLabel: '스크랩',
          style: TextStyle(
              fontFamily: constants.font, fontWeight: FontWeight.w600)),
    );
  }
}
