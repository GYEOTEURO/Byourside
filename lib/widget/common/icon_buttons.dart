import 'package:byourside/constants/icons.dart' as custom_icons;
import 'package:byourside/screen/common/search_page.dart';
import 'package:byourside/screen/common/my_scrap.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

IconButton backToPreviousPage(BuildContext context){
  return IconButton(
    icon: custom_icons.back, 
    onPressed: (){
      HapticFeedback.lightImpact();
      Navigator.pop(context);
    }
  );
}

IconButton goToSearchPage(BuildContext context) {
  return IconButton(
    icon: custom_icons.search, 
    onPressed: (){
      HapticFeedback.lightImpact();
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const Search()));
    });
}

IconButton goToScrapPage(BuildContext context){
  return IconButton(
    icon: custom_icons.gotoScrapPage, 
    onPressed: (){
      HapticFeedback.lightImpact();
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const MyScrap()));
  });
}