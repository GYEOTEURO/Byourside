import 'package:byourside/widget/common/icon_buttons.dart';
import 'package:flutter/material.dart';
import 'package:byourside/constants/fonts.dart' as fonts;
import 'package:byourside/constants/colors.dart' as colors;

Widget commentCount(BuildContext context, String collectionName, int countComments){
  return collectionName.contains('community') == true ?
      Container(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
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
      Column(
        children: [
          const SizedBox(height: 20),
          Row(children: [
              backToPreviousPage(context),
              const SizedBox(width: 8),
              Text(
                '댓글 $countComments',
                style: const TextStyle(
                  color: colors.textColor,
                  fontSize: 20,
                  fontFamily: fonts.font,
                  fontWeight: FontWeight.w700
                ),
              )
        ])
      ]);
}