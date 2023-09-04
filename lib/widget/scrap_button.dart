import 'package:byourside/constants/icons.dart' as customIcons;
import 'package:byourside/model/save_data.dart';
import 'package:flutter/material.dart';

final SaveData saveData = SaveData();

Widget scrapsButton(String collectionName, bool isClicked, List<String> scrapsUser, String category, String documentID, String uid, Function(List<String>) updateScraps){
  return isClicked ? 
    IconButton(
      icon: customIcons.communityPostScrapsFull, 
      onPressed: (){
        saveData.cancelLikeOrScrap(collectionName, category, documentID, uid, 'scraps');
        updateScraps(scrapsUser..remove(uid));
      }
    )
    : IconButton(
    icon: customIcons.communityPostScrapsEmpty, 
    onPressed: (){
      saveData.addLikeOrScrap(collectionName, category, documentID, uid, 'scraps');
      scrapsUser.add(uid);
      updateScraps(scrapsUser..add(uid));
    });
}