import 'package:byourside/constants/fonts.dart' as fonts;
import 'package:byourside/constants/colors.dart' as colors;
import 'package:byourside/constants/text.dart' as text;
import 'package:byourside/widget/common/fully_rounded_rectangle_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class WarningDialog extends StatelessWidget {
  final String warningObject;

  const WarningDialog({super.key, required this.warningObject});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        semanticLabel: text.warningMessage[warningObject],
        title: Text(
          text.warningMessage[warningObject]!,
          semanticsLabel: text.warningMessage[warningObject],
          style: const TextStyle(
              color: colors.textColor,
              fontSize: fonts.captionTitlePt,
              fontFamily: fonts.font,
              fontWeight: FontWeight.bold),
        ),
        actions: [
          fullyRoundedRectangleButton('확인', () {
            HapticFeedback.lightImpact();
            Navigator.of(context).pop();
          }),
        ]);
  }
}
