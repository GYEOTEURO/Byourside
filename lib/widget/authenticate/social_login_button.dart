import 'package:flutter/material.dart';

class SocialLoginButton extends StatelessWidget {
  final Color color;
  final Widget icon;
  final String text;
  final VoidCallback onPressed;

  const SocialLoginButton({super.key, 
    required this.color,
    required this.icon,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 328,
      height: 43.96,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        color: color,
      ),
      child: Stack(
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 22),
                child: Container(
                  width: 39,
                  height: 44,
                  decoration: const BoxDecoration(
                    color: Colors.transparent,
                  ),
                  child: icon, // Use the provided icon here
                ),
              ),
            ],
          ),
          Center(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
