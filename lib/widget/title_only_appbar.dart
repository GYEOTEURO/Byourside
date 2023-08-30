import 'package:byourside/widget/icon_buttons.dart';
import 'package:flutter/material.dart';
import 'package:byourside/constants/colors.dart' as colors;
import 'package:byourside/constants/fonts.dart' as fonts;

PreferredSizeWidget titleOnlyAppbar(BuildContext context, String title) {
  return AppBar(
    backgroundColor: Colors.white,
    elevation: 1,
    title: Text(
      title,
      style: const TextStyle(
        color: colors.textColor,
        fontSize: 20,
        fontFamily: fonts.font,
        fontWeight: FontWeight.w700,
        height: 1.50,
      ),
    ),
    leading: backToPreviousPage(context),
  );
}