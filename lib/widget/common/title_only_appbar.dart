import 'package:byourside/widget/common/icon_buttons.dart';
import 'package:flutter/material.dart';
import 'package:byourside/constants/colors.dart' as colors;
import 'package:byourside/constants/fonts.dart' as fonts;

PreferredSizeWidget titleOnlyAppbar(BuildContext context, String title, {bool showBackButton = true}) {
  return AppBar(
    backgroundColor: Colors.white,
    elevation: 1,
    title: Text(
      title,
      semanticsLabel: title,
      style: const TextStyle(
        color: colors.textColor,
        fontSize: 20,
        fontFamily: fonts.font,
        fontWeight: FontWeight.w700
      ),
    ),
    leading: showBackButton ? backToPreviousPage(context) : null, // 조건에 따라 뒤로가기 버튼을 표시하거나 숨깁니다.
  );
}
