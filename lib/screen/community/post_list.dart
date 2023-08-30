import 'package:byourside/constants/constants.dart' as constants;
import 'package:byourside/constants/colors.dart' as colors;
import 'package:byourside/constants/icons.dart' as customIcons;
import 'package:byourside/screen/community/post_list_appbar.dart';
import 'package:byourside/widget/category_buttons.dart';
import 'package:byourside/screen/community/community_add_post.dart';
import 'package:byourside/user_block_list_controller.dart';
import 'package:byourside/widget/stream_community_post.dart';
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
  String selectedChipValue = constants.communityCategories[0];

  void _handleChipSelected(String value) {
    setState(() {
      selectedChipValue = value;
    });
  }

  String selectedDisabilityTypeValue = '발달';

  void _handleDisabilityTypeSelected(String value) {
    setState(() {
      selectedDisabilityTypeValue = value;
    });
  }

  @override
  Widget build(BuildContext context) {
   final userBlockListController = Get.put(UserBlockListController());

    List<String>? blockedUser = userBlockListController.blockedUser ?? [];

    return Scaffold(
      appBar: CommunityPostListAppBar(onDisabilityTypeSelected: _handleDisabilityTypeSelected),
      body: Column(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: CategoryButtons(category: constants.communityCategories, onChipSelected: _handleChipSelected)
          ),
          streamCommunityPost(() => 
          loadData.readCommunityPosts(category: selectedChipValue, disabilityType: selectedDisabilityTypeValue), 
          blockedUser)
          ]),
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
