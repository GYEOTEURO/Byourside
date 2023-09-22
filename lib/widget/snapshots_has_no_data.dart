import 'package:flutter/material.dart';
import 'package:byourside/constants/fonts.dart' as fonts;

Widget snapshotsHasNoData(){
  return const SelectionArea(
      child: Center(
          child: Text(
            '없음',
            semanticsLabel: '없음',
            style: TextStyle(
              fontFamily: fonts.font,
              fontWeight: FontWeight.w600,
            ),
          )
  ));
}