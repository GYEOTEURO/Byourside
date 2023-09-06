import 'package:flutter/material.dart';
import 'package:byourside/constants/colors.dart' as colors;
import 'package:byourside/constants/fonts.dart' as fonts;
import 'package:flutter/services.dart';

Widget linkUrlButton(Function pressedFunc) {
  return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: colors.primaryColor,
        padding: const EdgeInsets.only(top: 10, bottom: 10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(69),
        ),
      ),
      onPressed: () {
        HapticFeedback.lightImpact();
        pressedFunc();
      },
      child: const Text(
        '원문보기',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: colors.textColor,
          fontSize: fonts.semiBodyPt,
          fontFamily: fonts.font,
          fontWeight: FontWeight.bold,
        ),
      ));
}
