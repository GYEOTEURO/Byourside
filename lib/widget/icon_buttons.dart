import 'package:byourside/constants/icons.dart' as customIcons;
import 'package:byourside/screen/community/search_page.dart';
import 'package:byourside/screen/mypage/my_scrap.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Widget backToPreviousPage(BuildContext context){
  return IconButton(
    icon: customIcons.back, 
    onPressed: (){
      Navigator.pop(context);
    }
  );
}

Widget goToSearchPage(BuildContext context) {
  return IconButton(
    icon: customIcons.search, 
    onPressed: (){
      HapticFeedback.lightImpact();
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const CommunitySearch()));
    });
}

Widget goToScrapPage(BuildContext context){
  return IconButton(
    icon: customIcons.gotoScrapPage, 
    onPressed: (){
      HapticFeedback.lightImpact();
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const MyScrap()));
  });
}