import 'package:byourside/constants/icons.dart' as custom_icons;
import 'package:byourside/model/save_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

final SaveData saveData = SaveData();

Widget scrapsButton(String collectionName, bool isClicked, List<String> scrapsUser, String category, String documentID, String uid, Function(List<String>) updateScraps){
  return isClicked ? 
    IconButton(
      icon: custom_icons.communityPostScrapsFull, 
      onPressed: (){
        HapticFeedback.lightImpact();
        saveData.cancelLikeOrScrap(collectionName, category, documentID, uid, 'scraps');
        updateScraps(scrapsUser..remove(uid));
      }
    )
    : IconButton(
    icon: custom_icons.communityPostScrapsEmpty, 
    onPressed: (){
      HapticFeedback.lightImpact();
      saveData.addLikeOrScrap(collectionName, category, documentID, uid, 'scraps');
      scrapsUser.add(uid);
      updateScraps(scrapsUser..add(uid));
    });
}