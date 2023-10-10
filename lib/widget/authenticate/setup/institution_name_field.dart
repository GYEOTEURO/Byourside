import 'package:flutter/material.dart';
import 'package:byourside/constants/text.dart' as text;
import 'package:byourside/constants/fonts.dart' as fonts;
import 'package:byourside/constants/colors.dart' as colors;

Widget buildInstitutionNameTextField({
  TextEditingController? controller,
  Function()? onTap,
  BuildContext? context, 
}) {
  double deviceWidth = 0;
  double deviceHeight = 0;

  WidgetsBinding.instance.addPostFrameCallback((_) {
    deviceWidth = MediaQuery.of(context!).size.width;
    deviceHeight = MediaQuery.of(context).size.height;
  });

  return SizedBox(
    width: deviceWidth * 0.66, 
    height: deviceHeight * 0.07, 
    child: TextFormField(
      onTap: onTap,
      controller: controller,
      maxLines: 1,
      decoration: InputDecoration(
        labelText: text.institutionNameLabel,
        fillColor: colors.bgrColor,
        filled: true,
        hintText: text.institutionNameHint,
        labelStyle: TextStyle(
          color: colors.textColor,
          fontSize: deviceWidth * 0.036, 
          fontFamily: fonts.font,
          fontWeight: FontWeight.w500,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(deviceWidth * 0.087),
          borderSide: BorderSide.none,
        ),
      ),
      autofocus: false,
    ),
  );
}
