import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  final String title;

  const Logo(this.title);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(20),
          child: Image.asset(
            "images/hug 1.png",
            width: 50,
          ),
        ),
        Image.asset(
          "images/곁.png",
          width: 120,
        ),
      ],
    );
  }
}
