import 'package:byourside/constants.dart' as constants;
import 'package:byourside/model/community_post.dart';
import 'package:byourside/screen/community/appbar.dart';
import 'package:byourside/screen/community/controller/category_controller.dart';
import 'package:byourside/screen/community/community_add_post.dart';
import 'package:byourside/screen/community/post.dart';
import 'package:byourside/screen/community/controller/disability_type_controller.dart';
import 'package:byourside/screen/community/community_post_list_tile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:multiple_stream_builder/multiple_stream_builder.dart';
import '../../model/load_data.dart';

class CommunityPostList extends StatefulWidget {
  const CommunityPostList(
      {Key? key})
      : super(key: key);

  final String title = '커뮤니티'; //appbar에서 조정하도록 수정

  @override
  State<CommunityPostList> createState() => _CommunityPostListState();
}

class _CommunityPostListState extends State<CommunityPostList> {
  final User? user = FirebaseAuth.instance.currentUser;
  final LoadData loadData = LoadData();

  @override
  Widget build(BuildContext context) {
    final communityCategoryController = Get.put(CommunityCategoryController());
    final communityDisabilityTypeController = Get.put(CommunityDisabilityTypeController());

    List<String> blockList;

    return Scaffold(
      appBar: CommunityAppBar(title: widget.title),
      body: StreamBuilder2<List<CommunityPostModel>, DocumentSnapshot>(
          streams: StreamTuple2(
              loadData.readCommunityPosts(category: communityCategoryController.category, disabilityType: communityDisabilityTypeController.disabilityType),
              loadData.readUserInfo(uid: user!.uid)),
          builder: (context, snapshots) {
            //snapshot 이름 구분
            if (snapshots.snapshot2.hasData) {
              blockList = snapshots.snapshot2.data!['blockList'] == null
                  ? []
                  : snapshots.snapshot2.data!['blockList'].cast<String>();
            } else {
              blockList = [];
            }
            if (snapshots.snapshot1.hasData) {
              return ListView.builder(
                  itemCount: snapshots.snapshot1.data!.length,
                  shrinkWrap: true,
                  itemBuilder: (_, index) {
                    CommunityPostModel post = snapshots.snapshot1.data![index];
                    if (blockList.contains(post.nickname)) {
                      return Container();
                    } else {
                      return communityPostListTile(context, post);
                    }
                  });
            } else {
              return const SelectionArea(
                  child: Center(
                      child: Text(
                '게시글 목록 가져오는 중...',
                semanticsLabel: '게시글 목록 가져오는 중...',
                style: TextStyle(
                  fontFamily: constants.font,
                  fontWeight: FontWeight.w600,
                ),
              )));
            }
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          HapticFeedback.lightImpact(); // 약한 진동
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const CommunityAddPost()));
        },
        backgroundColor: constants.mainColor,
        child: const Icon(Icons.add, semanticLabel: '커뮤니티 글쓰기'),
    ));
  }
}
