
import 'package:flutter/material.dart';
import 'package:byourside/constants/colors.dart' as colors;
import 'package:byourside/constants/fonts.dart' as fonts;
import 'package:flutter/services.dart';

Widget fullyRoundedRectangleButton(String buttonText, Function pressedFunc) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      backgroundColor: colors.primaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(69),
      ),
  ),
  onPressed: () {
    HapticFeedback.lightImpact();
    pressedFunc();
  },
  child: Text(
    buttonText,
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