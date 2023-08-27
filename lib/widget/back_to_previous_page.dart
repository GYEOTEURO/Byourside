import 'package:byourside/constants/icons.dart' as customIcons;
import 'package:flutter/material.dart';

Widget backToPreviousPage(BuildContext context){
  return IconButton(
    icon: customIcons.back, 
    onPressed: (){
      Navigator.pop(context);
    }
  );
}