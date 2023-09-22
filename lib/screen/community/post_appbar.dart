import 'package:byourside/screen/authenticate/controller/user_controller.dart';
import 'package:byourside/model/community_post.dart';
import 'package:byourside/model/save_data.dart';
import 'package:byourside/screen/bottom_nav_bar.dart';
import 'package:byourside/widget/icon_buttons.dart';
import 'package:byourside/widget/custom_bottom_sheet.dart';
import 'package:byourside/widget/likes_button.dart';
import 'package:byourside/widget/scrap_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:byourside/constants/icons.dart' as custom_icons;
import 'package:byourside/constants/colors.dart' as colors;
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class CommunityPostAppBar extends StatefulWidget implements PreferredSizeWidget {
  CommunityPostAppBar(
    {Key? key,
    required this.post}) 
    : super(key: key);

  String collectionName = 'community';
  final CommunityPostModel post;

  @override
  State<CommunityPostAppBar> createState() => _CommunityPostAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _CommunityPostAppBarState extends State<CommunityPostAppBar> {
  final User? user = FirebaseAuth.instance.currentUser;
  List<String> likesUser = [];
  List<String> scrapsUser = [];
  final SaveData saveData = SaveData();

  @override
  void initState() {
    super.initState();
    likesUser = widget.post.likesUser;
    scrapsUser = widget.post.scrapsUser;
  }

  void updateLikes(List<String> updatedLikesUser) {
    setState(() {
      likesUser = updatedLikesUser;
    });
  }

  void updateScraps(List<String> updatedScrapsUser) {
    setState(() {
      scrapsUser = updatedScrapsUser;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: backToPreviousPage(context),
          actions: [
            likesButton(widget.collectionName, isClicked(likesUser), likesUser, widget.post.category, widget.post.id!, user!.uid, updateLikes),
            scrapsButton(widget.collectionName, isClicked(scrapsUser), scrapsUser, widget.post.category, widget.post.id!, user!.uid, updateScraps),
            IconButton(
              icon: custom_icons.postOption, 
              onPressed: (){
                HapticFeedback.lightImpact();
                customBottomSheet(context, widget.post.uid == user!.uid, 
                () { deletePost(context, widget.post.category, widget.post.id!, widget.collectionName); }, 
                () { reportPost(context, widget.collectionName, widget.post.id!); }, 
                () { blockPost(context, user!.uid, widget.post.nickname); });
              }),
          ],
    );
  }

deletePost(BuildContext context, String category, String documentID, String collectionName){
  Get.offAll(() => const BottomNavBar());
  saveData.deleteCommunityPost(category, documentID);
}

reportPost(BuildContext context, String collectionName, String id){
  saveData.report(collectionName, 'post', id);
  Navigator.pop(context);
}

blockPost(BuildContext context, String uid, String blockUid){
  Get.offAll(() => const BottomNavBar());
  Get.find<UserController>().addBlockedUser(blockUid);
}


  bool isClicked(List<String> likesOrScrapsUser) {
    if(likesOrScrapsUser.contains(user!.uid)){
      return true;
    }
    return false;
  }
}
