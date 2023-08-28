import 'dart:io';
import 'package:byourside/screen/authenticate/controller/auth_controller.dart';
import 'package:byourside/screen/authenticate/policy/personal_data.dart';
import 'package:byourside/screen/authenticate/policy/personal_policy.dart';
import 'package:byourside/widget/authenticate/social_login_button.dart';
import 'package:flutter/material.dart';
import 'package:byourside/constants/auth_icons.dart';


class SocialLogin extends StatelessWidget {
  const SocialLogin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isIOS = Platform.isIOS;

    return Scaffold(
      body: DecoratedBox(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFFFDF8D), Color(0xFFFFCE50), Color(0xFFFFB950)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildIconContainer(
                width: 152.72,
                height: 145.02,
                svgIcon: AuthIcons.beesideLogo,
              ),
              const SizedBox(height: 100),
              _buildButtonContainer(
                color: Colors.white,
                icon: _buildIconContainer(
                  width: 39,
                  height: 44,
                  backgroundColor: Colors.white,
                  svgIcon: AuthIcons.googleIcon,
                ),
                text: 'Google 계정으로 로그인',
              ),
              const SizedBox(height: 20),
              if (isIOS) 
              _buildButtonContainer(
                color: Colors.white,
                icon: _buildIconContainer(
                  width: 39,
                  height: 44,
                  backgroundColor: Colors.white,
                  svgIcon: AuthIcons.appleIcon,
                ),
                text: 'Apple로 로그인',
              ),
              const SizedBox(height: 30),
              _buildTextButton(
                text: '이용약관',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const PersonalData()), // MyApp 페이지로 이동
                  );
                },
              ),
              AuthIcons.tosLine,
              const SizedBox(height: 5),
              _buildTextButton(
                text: '개인정보 처리방침',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const PersonalPolicy()), // PersonalPolicy 페이지로 이동
                  );
                },
              ),
              AuthIcons.policyLine,
            ],
          ),
        ),
      ),
    );
  }


Widget _buildButtonContainer({
  required Color color,
  required Widget icon,
  required String text,
}) {
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
              child: icon,
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

  Widget _buildIconContainer({
    required double width,
    required double height,
    Color backgroundColor = Colors.transparent, 
    required Widget svgIcon,
  }) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: backgroundColor,
      ),
      child: svgIcon,
    );
  }


  Widget _buildTextButton({
    required String text,
    required VoidCallback onPressed,
  }) {
    return TextButton(
      onPressed: onPressed,
      child: Stack(
        children: [
          Column(
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
        ],
      ),
    );
  }

}
