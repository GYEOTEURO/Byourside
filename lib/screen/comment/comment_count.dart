import 'package:byourside/widget/common/title_only_appbar.dart';
import 'package:flutter/material.dart';
import 'package:byourside/constants/fonts.dart' as fonts;
import 'package:byourside/constants/colors.dart' as colors;

Widget commentCount(BuildContext context, String collectionName, int countComments){
  return collectionName.contains('community') == true ?
      Container(
        margin: const EdgeInsets.all(7),
        padding: const EdgeInsets.fromLTRB(15, 0, 0, 15),
        alignment: Alignment.bottomLeft, 
        child: Text(
            '댓글 $countComments',
            semanticsLabel: '댓글 $countComments',
            style: const TextStyle(
              color: colors.textColor,
              fontSize: 13,
              fontFamily: fonts.font,
              fontWeight: FontWeight.w400
            ),
          )
      )
      : 
      titleOnlyAppbar(context, '댓글 $countComments');
}