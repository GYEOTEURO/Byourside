import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SocialLoginButton extends StatelessWidget {
  final String buttonText;
  final Color buttonColor;
  final Color iconColor;
  final IconData icon;
  final void Function(BuildContext) onPressed;

  const SocialLoginButton({super.key, 
    required this.buttonText,
    required this.buttonColor,
    required this.iconColor,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 180.0,
      height: 48.0,
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: buttonColor,
          side: const BorderSide(
            width: 5.0,
            color: Colors.black,
          ),
          minimumSize: const Size(double.infinity, 50),
        ),
        icon: FaIcon(
          icon,
          color: iconColor,
        ),
        label: Text(buttonText),
        onPressed: () async {
          onPressed(context);
        },
      ),
    );
  }
}