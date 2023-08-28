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
    var deviceWidth = MediaQuery.of(context).size.width;
    var deviceHeight = MediaQuery.of(context).size.height;

    return Container(
      width: deviceWidth * 0.85,
      height: deviceHeight * 0.06,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(deviceWidth * 0.11),
        color: color,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2), // Shadow color
            blurRadius: 6, // Spread of the shadow
            offset: const Offset(0, 3), // Shadow offset (x, y)
          ),
        ],
      ),
      child: TextButton(
        onPressed: () async {
          onPressed(context);
        },
        child: Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.only(right: deviceWidth * 0.024),
                child: Container(
                  width: deviceWidth * 0.12,
                  height: deviceHeight * 0.05,
                  decoration: const BoxDecoration(
                    color: Colors.transparent,
                  ),
                  child: icon,
                ),
              ),
              Text(
                text,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: deviceWidth * 0.048,
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
