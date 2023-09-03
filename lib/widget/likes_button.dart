import 'package:byourside/constants/icons.dart' as customIcons;
import 'package:byourside/model/save_data.dart';
import 'package:flutter/material.dart';

final SaveData saveData = SaveData();

Widget likesButton(String collectionName, bool isClicked, List<String> likesUser, String category, String documentID, String uid, Function(List<String>) updateLikes){
  return isClicked ? 
    IconButton(
      icon: customIcons.communityPostLikesFull, 
      onPressed: (){
        saveData.cancelLikeOrScrap(collectionName, category, documentID, uid, 'likes');
        updateLikes(likesUser..remove(uid));
      }
    )
    : IconButton(
        icon: customIcons.communityPostLikesEmpty, 
        onPressed: (){
          saveData.addLikeOrScrap(collectionName, category, documentID, uid, 'likes');
          updateLikes(likesUser..add(uid));
        }
    );
}