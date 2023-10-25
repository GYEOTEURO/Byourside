import 'package:byourside/model/community_post.dart';
import 'package:byourside/model/save_data.dart';
import 'package:byourside/screen/authenticate/controller/user_controller.dart';
import 'package:byourside/screen/bottom_nav_bar.dart';
import 'package:byourside/widget/common/custom_bottom_sheet.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:byourside/constants/icons.dart' as custom_icons;

final User? user = FirebaseAuth.instance.currentUser;
final SaveData saveData = SaveData();

IconButton communityPostOptions(BuildContext context, String collectionName, CommunityPostModel post){
  return IconButton(
            icon: custom_icons.postOption, 
            onPressed: (){
              HapticFeedback.lightImpact();
              customBottomSheet(context, post.uid == user!.uid, 
              () { deletePost(context, post.category, post.id!); }, 
              () { reportPost(context, collectionName, post.id!); }, 
              () { blockPost(context, post.nickname); });
            });
}

deletePost(BuildContext context, String category, String documentID){
  Get.offAll(() => const BottomNavBar());
  saveData.deleteCommunityPost(category, documentID);
}

reportPost(BuildContext context, String collectionName, String id){
  saveData.report(collectionName, 'post', id);
  Navigator.pop(context);
  Navigator.pop(context);
}

blockPost(BuildContext context, String blockUid){
  Get.offAll(() => const BottomNavBar());
  Get.find<UserController>().addBlockedUser(blockUid);
}