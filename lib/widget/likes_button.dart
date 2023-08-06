import 'package:byourside/constants.dart' as constants;
import 'package:byourside/model/community_post.dart';
import 'package:byourside/model/save_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LikesButton extends StatefulWidget {
  const LikesButton(
      {super.key,
      required this.collectionName,
      required this.post,
      required this.uid});

  final String collectionName;
  final CommunityPostModel post;
  final String uid;

  @override
  State<LikesButton> createState() => _LikesButtonState();
}

class _LikesButtonState extends State<LikesButton> {
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
        post.likesUser!.contains(uid)
            ? saveData.cancelLikeOrScrap(collectionName, post.id!, uid, 'likes')
            : saveData.addLikeOrScrap(collectionName, post.id!, uid, 'likes');
      },
      style: ElevatedButton.styleFrom(
        fixedSize: Size(width * 0.38, height * 0.06),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(4))),
        side: const BorderSide(
            color: Color.fromARGB(255, 255, 45, 45), width: 1.5),
        foregroundColor: const Color.fromARGB(255, 255, 45, 45),
      ),
      icon: post.likesUser!.contains(uid)
          ? const Icon(Icons.favorite, semanticLabel: '좋아요 취소')
          : const Icon(Icons.favorite_outline, semanticLabel: '좋아요 추가'),
      label: Text('좋아요  ${post.likes}',
          semanticsLabel: '좋아요  ${post.likes}',
          style: const TextStyle(
              fontFamily: constants.font, fontWeight: FontWeight.w600)),
    );
  }
}
