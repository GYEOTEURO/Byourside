import 'package:byourside/widget/fully_rounded_rectangle_button.dart';
import 'package:byourside/widget/outlined_rounded_rectangle_button.dart';
import 'package:flutter/material.dart';
import 'package:byourside/constants/fonts.dart' as fonts;
import 'package:byourside/constants/colors.dart' as colors;
class DeleteReportBlockAlert extends StatelessWidget {
  final String message;
  final String subMessage;
  final String buttonText;
  final Function onPressed;

  const DeleteReportBlockAlert({
    Key? key,
    required this.message,
    required this.subMessage,
    required this.buttonText,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      semanticLabel: message + subMessage,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            message,
            semanticsLabel: message,
            style: const TextStyle(
              color: colors.textColor,
              fontFamily: fonts.font,
              fontWeight: FontWeight.w400,
              fontSize: 13
            ),
          ),
          Text(
            subMessage,
            semanticsLabel: subMessage,
            style: const TextStyle(
              color: colors.subColor,
              fontFamily: fonts.font,
              fontWeight: FontWeight.w400,
              fontSize: 10
            ),
          ),
        ],
      ),
      actions: [
        fullyRoundedRectangleButton('취소하기', () {
          Navigator.of(context).pop(false); // Return false when canceled
        }),
        outlinedRoundedRectangleButton(buttonText, () {
          onPressed();
        }),
      ],
    );
  }
}
