import 'package:byourside/widget/common/fully_rounded_rectangle_button.dart';
import 'package:byourside/constants/text.dart' as text;
import 'package:flutter/material.dart';
import 'package:byourside/constants/fonts.dart' as fonts;
import 'package:byourside/constants/colors.dart' as colors;

class ReportOnlyAlert extends StatelessWidget {
  final String message;
  final Function onPressed;

  const ReportOnlyAlert({
    Key? key,
    required this.message,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      semanticLabel: message,
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
        ],
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: fullyRoundedRectangleButton(text.check, () {
                    Navigator.of(context).pop(false);
                  }),
            ),
          ],
        ),
      ],
    );
  }
}
