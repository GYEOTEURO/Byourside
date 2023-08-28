import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:byourside/constants/colors.dart';
import 'package:byourside/screen/authenticate/controller/auth_controller.dart';
import 'package:byourside/constants/auth_icons.dart';
import 'package:byourside/widget/authenticate/login/policy_link.dart';
import 'package:byourside/widget/authenticate/login/social_login_button.dart';
import 'package:byourside/screen/authenticate/policy/personal_data.dart';
import 'package:byourside/screen/authenticate/policy/personal_policy.dart';

class SocialLogin extends StatelessWidget {
  const SocialLogin({Key? key}) : super(key: key);

  void _navigateToPage(BuildContext context, Widget page) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }

  Widget _buildIconRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AuthIcons.beeIcon,
        const SizedBox(width: 20),
        AuthIcons.beeIcon,
        const SizedBox(width: 20),
        AuthIcons.beeIcon,
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isIOS = Platform.isIOS;

    var deviceWidth = MediaQuery.of(context).size.width;
    var deviceHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: DecoratedBox(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: gradientColors,
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: deviceHeight * 0.15),
                  Container(
                    width: deviceWidth * 0.35,
                    height: deviceHeight * 0.25,
                    decoration: const BoxDecoration(
                      color: Colors.transparent,
                    ),
                    child: AuthIcons.beesideLogo,
                  ),
                  SizedBox(height: deviceHeight * 0.1),
                  SocialLoginButton(
                    color: Colors.white,
                    icon: AuthIcons.googleIcon,
                    text: 'Google 계정으로 로그인',
                    onPressed: (context) async {
                      await AuthController.instance.loginWithGoogle(context);
                    },
                  ),
                  SizedBox(height: deviceHeight * 0.03),
                  if (isIOS)
                    SocialLoginButton(
                      color: Colors.white,
                      icon: AuthIcons.appleIcon,
                      text: 'Apple로 로그인',
                      onPressed: (context) async {
                        await AuthController.instance.signInWithApple();
                      },
                    ),
                  SizedBox(height: deviceHeight * 0.05),
                  PolicyLink(
                    text: '이용약관',
                    onPressed: () =>
                        _navigateToPage(context, const PersonalData()),
                    icon: AuthIcons.tosLine,
                  ),
                  PolicyLink(
                    text: '개인정보 처리방침',
                    onPressed: () =>
                        _navigateToPage(context, const PersonalPolicy()),
                    icon: AuthIcons.policyLine,
                  ),
                ],
              ),
              _buildIconRow(),
            ],
          ),
        ),
      ),
    );
  }
}
