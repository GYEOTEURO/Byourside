import 'package:flutter/material.dart';
import 'package:byourside/constants/colors.dart' as colors;
import 'package:byourside/constants/fonts.dart' as fonts;
import 'package:flutter/services.dart';

Widget outlinedRoundedRectangleButton(String buttonText, Function pressedFunc) {
  return OutlinedButton(
    style: OutlinedButton.styleFrom(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(69),
      ),
      side: const BorderSide(color: colors.primaryColor),
  ),
  onPressed: () {
    HapticFeedback.lightImpact();
    pressedFunc();
  },
  child: Text(
    buttonText,
    semanticsLabel: buttonText,
    textAlign: TextAlign.center,
    style: const TextStyle(
      color: colors.textColor,
      fontSize: 13,
      fontFamily: fonts.font,
      fontWeight: FontWeight.w700,
    ),
  )
);

}