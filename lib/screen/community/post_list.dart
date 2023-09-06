import 'package:byourside/constants/constants.dart' as constants;
import 'package:byourside/constants/colors.dart' as colors;
import 'package:byourside/constants/icons.dart' as custom_icons;
import 'package:byourside/screen/authenticate/controller/user_controller.dart';
import 'package:byourside/model/community_post.dart';
import 'package:byourside/screen/community/community_post_list_tile.dart';
import 'package:byourside/screen/community/post_list_appbar.dart';
import 'package:byourside/widget/category_buttons.dart';
import 'package:byourside/screen/community/add_post.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../model/load_data.dart';

class CommunityPostList extends StatefulWidget {
  const CommunityPostList({Key? key}) : super(key: key);

  @override
  State<CommunityPostList> createState() => _CommunityPostListState();
}

class _CommunityPostListState extends State<CommunityPostList> {
  final User? user = FirebaseAuth.instance.currentUser;
  final LoadData loadData = LoadData();
  String selectedChipValue = constants.communityCategories[0];
  String? selectedDisabilityTypeValue =
      Get.find<UserController>().userModel.disabilityType!.split(' ')[0] ==
              '해당없음'
          ? '발달'
          : Get.find<UserController>().userModel.disabilityType!.split(' ')[0];

  void _handleChipSelected(String value) {
    setState(() {
      selectedChipValue = value;
    });
  }

  void _handleDisabilityTypeSelected(String value) {
    setState(() {
      selectedDisabilityTypeValue = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: [
          CommunityPostListAppBar(
              onDisabilityTypeSelected: _handleDisabilityTypeSelected),
          SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: CategoryButtons(
                  category: constants.communityCategories,
                  onChipSelected: _handleChipSelected)),
          Expanded(
            child: StreamBuilder<List<CommunityPostModel>>(
              stream: loadData.readCommunityPosts(category: selectedChipValue, disabilityType: selectedDisabilityTypeValue),
              builder: (context, snapshots) {
                if (snapshots.hasData) {
                  return ListView.builder(
                      itemCount: snapshots.data!.length,
                      shrinkWrap: true,
                      itemBuilder: (_, index) {
                        CommunityPostModel post = snapshots.data![index];
                        if (Get.find<UserController>().userModel.blockedUsers!.contains(post.nickname)) {
                          return Container();
                        } else {
                          return communityPostListTile(context, post);
                        }
                      });
              } else {
                return SelectionArea(
                  child: Center(
                    child: custom_icons.loading
                  )
                );
              }
            })
          )
          ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          HapticFeedback.lightImpact();
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const CommunityAddPost()));
        },
        backgroundColor: colors.primaryColor,
        child: custom_icons.addPost,
    ));
  }
}
