import 'package:byourside/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomAlertDialog extends StatelessWidget {
  final String message;
  final String buttonText;
  final Function()? onPressed;

  const CustomAlertDialog({
    Key? key,
    required this.message,
    required this.buttonText,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      semanticLabel: message,
      content: Text(
        message,
        semanticsLabel: message,
        style: const TextStyle(
          color: Colors.black,
          fontFamily: 'NanumGothic',
          fontWeight: FontWeight.w500,
        ),
      ),
      actions: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryColor,
          ),
          onPressed: onPressed ?? () {
            HapticFeedback.lightImpact(); // 약한 진동
            Navigator.pop(context);
          },
          child: Text(
            buttonText,
            semanticsLabel: buttonText,
            style: const TextStyle(
              fontSize: 14,
              fontFamily: 'NanumGothic',
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
