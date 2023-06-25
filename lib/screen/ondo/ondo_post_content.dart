import 'package:byourside/magic_number.dart';
import 'package:byourside/model/chat_list.dart';
import 'package:byourside/model/ondo_post.dart';
import 'package:byourside/widget/block_user.dart';
import 'package:byourside/screen/chat/chat_page.dart';
import 'package:byourside/widget/report.dart';
import 'package:byourside/widget/delete_post_or_comment.dart';
import 'package:byourside/widget/image_slider.dart';
import 'package:byourside/widget/likes_button.dart';
import 'package:byourside/widget/scrap_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import '../../model/load_data.dart';
import '../../model/save_data.dart';

class OndoPostContent extends StatefulWidget {
  const OndoPostContent(
      {super.key,
      required this.collectionName,
      required this.documentID,
      required this.primaryColor});

  final String collectionName;
  final String documentID;
  final Color primaryColor;

  @override
  State<OndoPostContent> createState() => _OndoPostContentState();
}

class _OndoPostContentState extends State<OndoPostContent> {
  final User? user = FirebaseAuth.instance.currentUser;
  final SaveData saveData = SaveData();
  final LoadData loadData = LoadData();

  final List<String> _decList = postReportReasonList;

  Widget _buildListItem(String? collectionName, OndoPostModel? post) {
    List<String> datetime = post!.datetime!.toDate().toString().split(' ');
    String date = datetime[0].replaceAll('-', '/');
    String hour = datetime[1].split(':')[0];
    String minute = datetime[1].split(':')[1];

    String? type;
    if (post.type!.length == 1) {
      type = post.type![0];
    } else if (post.type!.length > 1) {
      post.type!.sort();
      type = '${post.type![0]}/${post.type![1]}';
    }

    return Column(children: [
      Align(
          alignment: Alignment.centerLeft,
          child: SelectionArea(
              child: Text(
            ' ${post.title!}',
            semanticsLabel: ' ${post.title!}',
            style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            fontFamily: font),
          ))),
      Row(children: [
        Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      post.type!.isEmpty
                          ? '${post.nickname!} | $date $hour:$minute'
                          : '${post.nickname!} | $date $hour:$minute | $type',
                      semanticsLabel: post.type!.isEmpty
                          ? "${post.nickname!}  ${date.split('/')[0]}년 ${date.split('/')[1]}월 ${date.split('/')[2]}일 $hour시 $minute분"
                          : "${post.nickname!}  ${date.split('/')[0]}년 ${date.split('/')[1]}월 ${date.split('/')[2]}일 $hour시 $minute분  $type",
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontFamily: font,
                        fontWeight: FontWeight.w600,
                      ),
                    )),
        if (user?.uid == post.uid)
          DeletePostOrComment(collectionName: widget.collectionName, documentID: widget.documentID) // 공통 모듈 폴더
        else
          Row(children: [
            Report(
                decList: _decList, collectionType: 'post', id: post.id!),
            Container(
                margin: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                child: BlockUser(nickname: post.nickname!, collectionType: 'post')), //이름 명사로 짓기
          ])
      ]),
      const Divider(thickness: 1, height: 1, color: Colors.black),
      if (post.images!.isNotEmpty)
        ImageSlider(post: post),
      Container(
          padding: const EdgeInsets.fromLTRB(0, 25, 0, 20),
          alignment: Alignment.centerLeft,
          child: SelectionArea(
              child: Text(
            post.content!,
            semanticsLabel: post.content,
            style: const TextStyle(
              fontSize: 16,
              fontFamily: font,
              fontWeight: FontWeight.w600,
            ),
          ))),
      //Divider(thickness: 1, height: 0.5, color: Colors.black),
      Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        LikesButton(collectionName: collectionName!, post: post, uid: user!.uid),
        ScrapButton(collectionName: collectionName, post: post, uid: user!.uid),
      ]),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    String collectionName = widget.collectionName;
    String documentID = widget.documentID;

    return StreamBuilder<OndoPostModel>(
        stream: loadData.readOndoDocument(
            collectionName: collectionName, documentID: documentID),
        builder: (context, AsyncSnapshot<OndoPostModel> snapshot) {
          if (snapshot.hasData) {
            OndoPostModel? post = snapshot.data;
            return _buildListItem(collectionName, post);
          } else {
            return const SelectionArea(
                child: Center(
                    child: Text('게시물을 찾을 수 없습니다.',
                        semanticsLabel: '게시물을 찾을 수 없습니다.',
                        style: TextStyle(
                          fontFamily: font,
                          fontWeight: FontWeight.w600,
                        ))));
          }
        });
  }
}
