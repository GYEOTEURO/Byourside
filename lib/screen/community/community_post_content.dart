import 'package:byourside/constants.dart' as constants;
import 'package:byourside/model/community_post.dart';
import 'package:byourside/widget/block_user.dart';
import 'package:byourside/widget/report.dart';
import 'package:byourside/widget/delete_post_or_comment.dart';
import 'package:byourside/widget/image_slider.dart';
import 'package:byourside/widget/likes_button.dart';
import 'package:byourside/widget/scrap_button.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../model/load_data.dart';
import '../../model/save_data.dart';

class CommunityPostContent extends StatefulWidget {
  const CommunityPostContent(
      {super.key,
      required this.post});

  final CommunityPostModel post;

  @override
  State<CommunityPostContent> createState() => _CommunityPostContentState();
}

class _CommunityPostContentState extends State<CommunityPostContent> {
  final User? user = FirebaseAuth.instance.currentUser;
  final SaveData saveData = SaveData();
  final LoadData loadData = LoadData();

  final List<String> _reportReasonList = constants.postReportReasonList;

  Widget _buildPostContent(String? collectionName, CommunityPostModel? post) {
    List<String> datetime = post!.createdAt.toDate().toString().split(' ');
    String date = datetime[0].replaceAll('-', '/');
    String hour = datetime[1].split(':')[0];
    String minute = datetime[1].split(':')[1];

    return Column(children: [
      Align(
          alignment: Alignment.centerLeft,
          child: SelectionArea(
              child: Text(
            ' ${post.title}',
            semanticsLabel: ' ${post.title}',
            style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontFamily: constants.font),
          ))),
      Row(children: [
        Align(
            alignment: Alignment.centerLeft,
            child: Text(
              '${post.nickname} | $date $hour:$minute',
              semanticsLabel: "${post.nickname}  ${date.split('/')[0]}년 ${date.split('/')[1]}월 ${date.split('/')[2]}일 $hour시 $minute분",
              style: const TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontFamily: constants.font,
                fontWeight: FontWeight.w600,
              ),
            )),
        if (user?.uid == post.uid)
          DeletePostOrComment(
              collectionName: 'communityPost',
              documentID: widget.post.id!) // 공통 모듈 폴더
        else
          Row(children: [
            Report(reportReasonList: _reportReasonList, collectionType: 'post', id: post.id!),
            Container(
                margin: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                child: BlockUser(
                    nickname: post.nickname,
                    collectionType: 'post')), //이름 명사로 짓기
          ])
      ]),
      const Divider(thickness: 1, height: 1, color: Colors.black),
      //if (post.images!.isNotEmpty) ImageSlider(post: post),
      Container(
          padding: const EdgeInsets.fromLTRB(0, 25, 0, 20),
          alignment: Alignment.centerLeft,
          child: SelectionArea(
              child: Text(
            post.content,
            semanticsLabel: post.content,
            style: const TextStyle(
              fontSize: 16,
              fontFamily: constants.font,
              fontWeight: FontWeight.w600,
            ),
          ))),
      //Divider(thickness: 1, height: 0.5, color: Colors.black),
      Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        // LikesButton(
        //     collectionName: collectionName!, post: post, uid: user!.uid),
        // ScrapButton(collectionName: collectionName, post: post, uid: user!.uid),
      ]),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    String collectionName = 'communityPost';

    return _buildPostContent(collectionName, widget.post);}
  }

