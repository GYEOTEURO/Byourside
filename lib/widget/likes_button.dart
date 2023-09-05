import 'package:byourside/constants/icons.dart' as custom_icons;
import 'package:byourside/model/save_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

final SaveData saveData = SaveData();

Widget likesButton(String collectionName, bool isClicked, List<String> likesUser, String category, String documentID, String uid, Function(List<String>) updateLikes){
  return isClicked ? 
    IconButton(
      icon: custom_icons.communityPostLikesFull, 
      onPressed: (){
        HapticFeedback.lightImpact();
        saveData.cancelLikeOrScrap(collectionName, category, documentID, uid, 'likes');
        updateLikes(likesUser..remove(uid));
      }
    )
    : IconButton(
        icon: custom_icons.communityPostLikesEmpty, 
        onPressed: (){
          HapticFeedback.lightImpact();
          saveData.addLikeOrScrap(collectionName, category, documentID, uid, 'likes');
          updateLikes(likesUser..add(uid));
        }
    );
}