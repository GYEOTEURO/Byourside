import 'package:flutter/material.dart';
import 'package:byourside/constants/colors.dart' as colors;

Widget buildInfoContainer(String labelText, String valueText, double deviceWidth, double deviceHeight, double ratio) {
  double containerHeight = deviceHeight * 0.06;
  double containerWidth = deviceWidth * ratio;

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        labelText,
        style: TextStyle(
          fontSize: deviceWidth * 0.035,
          fontWeight: FontWeight.w400,
          color: colors.subColor,
        ),
      ),
      SizedBox(height: deviceHeight * 0.01),
      Container(
        width: containerWidth,
        height: containerHeight,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: colors.primaryColor),
        ),
        child: Center(
          child: Text(
            valueText,
            style: TextStyle(
              fontSize: deviceWidth * 0.036,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
    ],
  );
}
