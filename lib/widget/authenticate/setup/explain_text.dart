import 'package:flutter/material.dart';

class ExplainText extends StatelessWidget {
  final String text;
  final double width;

  const ExplainText({
    Key? key,
    required this.text,
    required this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: width, // You may need to pass deviceWidth as a parameter or use another appropriate value.
        fontWeight: FontWeight.w700,
      ),
      textAlign: TextAlign.left,
    );
  }
}
