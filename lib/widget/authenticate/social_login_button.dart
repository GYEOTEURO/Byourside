import 'package:flutter/material.dart';

class SocialLoginButton extends StatelessWidget {
  final Color color;
  final Widget icon;
  final String text;
  final void Function(BuildContext) onPressed;

  const SocialLoginButton({
    Key? key,
    required this.color,
    required this.icon,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 328,
      height: 43.96,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        color: color,
      ),
      child: TextButton(
        onPressed: () async {
          onPressed(context);
        },
        child: Center( // Wrap the Row with Center
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Container(
                  width: 39,
                  height: 44,
                  decoration: const BoxDecoration(
                    color: Colors.transparent,
                  ),
                  child: icon,
                ),
              ),
              Text(
                text,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 19,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
