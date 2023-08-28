import 'package:flutter/material.dart';

class PolicyLink extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Widget icon; 

  const PolicyLink({super.key, 
    required this.text,
    required this.onPressed,
    required this.icon, 
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildTextLink(text, onPressed),
        const SizedBox(width: 5),
        icon,
      ],
    );
  }

  Widget _buildTextLink(String text, VoidCallback onPressed) {
    return TextButton(
      onPressed: onPressed,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            text,
            style: const TextStyle(
              fontSize: 13,
              color: Colors.black,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
