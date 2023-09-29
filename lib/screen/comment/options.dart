import 'package:byourside/model/comment.dart';
import 'package:byourside/model/save_data.dart';
import 'package:byourside/screen/authenticate/controller/user_controller.dart';
import 'package:byourside/widget/common/custom_bottom_sheet.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:byourside/constants/icons.dart' as custom_icons;

final User? user = FirebaseAuth.instance.currentUser;
final SaveData saveData = SaveData();

IconButton commentOptions(BuildContext context, String collectionName, String documentID, CommentModel comment){
  return IconButton(
          icon: custom_icons.commentOption,
          onPressed: (){ 
            HapticFeedback.lightImpact();
            customBottomSheet(context, comment.uid == user!.uid, 
              () { deleteComment(context, collectionName, documentID, comment.id!); }, 
              () { reportComment(context, collectionName, comment.id!); }, 
              () { blockComment(context, comment.nickname); });
          }
      );
}

deleteComment(BuildContext context, String collectionName, String documentID, String commentID){
    saveData.deleteComment(collectionName, documentID, commentID);
    Navigator.pop(context);
  }

reportComment(BuildContext context, String collectionName, String id){
  saveData.report(collectionName.split('_')[0], 'comment', id);
  Navigator.pop(context);
}

blockComment(BuildContext context, String blockUid){
  Navigator.pop(context);
  Get.find<UserController>().addBlockedUser(blockUid);
}