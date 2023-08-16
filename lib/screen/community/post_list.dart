import 'package:byourside/constants/constants.dart' as constants;
import 'package:byourside/constants/colors.dart' as colors;
import 'package:byourside/constants/icons.dart' as customIcons;
import 'package:byourside/model/community_post.dart';
import 'package:byourside/screen/community/post_list_appbar.dart';
import 'package:byourside/screen/community/community_categories.dart';
import 'package:byourside/screen/community/controller/category_controller.dart';
import 'package:byourside/screen/community/community_add_post.dart';
import 'package:byourside/screen/community/controller/disability_type_controller.dart';
import 'package:byourside/screen/community/community_post_list_tile.dart';
import 'package:byourside/user_block_list_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../model/load_data.dart';

class CommunityPostList extends StatefulWidget {
  const CommunityPostList(
      {Key? key})
      : super(key: key);

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
    final userBlockListController = Get.put(UserBlockListController());

    List<String>? blockList = userBlockListController.blockList ?? [];

    return Scaffold(
      appBar: const CommunityPostListAppBar(),
      body: Column(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: communityCategoryButtons()
          ),
          StreamBuilder<List<CommunityPostModel>>(
            stream: loadData.readCommunityPosts(category: communityCategoryController.category, disabilityType: communityDisabilityTypeController.disabilityType),
            builder: (context, snapshots) {
              if (snapshots.hasData) {
                return ListView.builder(
                    itemCount: snapshots.data!.length,
                    shrinkWrap: true,
                    itemBuilder: (_, index) {
                      CommunityPostModel post = snapshots.data![index];
                      if (blockList.contains(post.uid)) {
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
            }),],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          HapticFeedback.lightImpact(); // 약한 진동
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const CommunityAddPost()));
        },
        backgroundColor: colors.primaryColor,
        child: customIcons.addPost,
    ));
  }
}
