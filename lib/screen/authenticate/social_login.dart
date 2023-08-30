import 'dart:io';
import 'package:byourside/screen/authenticate/policy.dart';
import 'package:flutter/material.dart';
import 'package:byourside/constants/colors.dart' as colors;
import 'package:byourside/constants/auth_icons.dart' as auth_icons;
import 'package:byourside/constants/constants.dart' as constants;
import 'package:byourside/screen/authenticate/controller/auth_controller.dart';
import 'package:byourside/widget/authenticate/login/policy_link.dart';
import 'package:byourside/widget/authenticate/login/social_login_button.dart';

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
        auth_icons.beeIcon,
        const SizedBox(width: 20),
        auth_icons.beeIcon,
        const SizedBox(width: 20),
        auth_icons.beeIcon,
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
            colors: colors.gradientColors,
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
                  
                  SizedBox(height: deviceHeight * 0.15), // 기존 위치로 이동
                  Container(
                    width: deviceWidth * 0.35,
                    height: deviceHeight * 0.25,
                    decoration: const BoxDecoration(
                      color: Colors.transparent,
                    ),
                    child: auth_icons.beesideLogo,
                  ),
                  SizedBox(height: deviceHeight * 0.1),
                  SocialLoginButton(
                    color: Colors.white,
                    icon: auth_icons.googleIcon,
                    text: 'Google 계정으로 로그인',
                    onPressed: (context) async {
                      await AuthController.instance.loginWithGoogle(context);
                    },
                  ),
                  SizedBox(height: deviceHeight * 0.03),
                  if (isIOS)
                    SocialLoginButton(
                      color: Colors.white,
                      icon: auth_icons.appleIcon,
                      text: 'Apple로 로그인',
                      onPressed: (context) async {
                        await AuthController.instance.signInWithApple();
                      },
                    ),
                  SizedBox(height: deviceHeight * 0.05),
                  PolicyLink(
                    text: '이용약관',
                    onPressed: () =>
                        _navigateToPage(context, Policy(policy: constants.usingPolicy)),
                    icon: auth_icons.tosLine,
                  ),
                  PolicyLink(
                    text: '개인정보 처리방침',
                    onPressed: () =>
                        _navigateToPage(context, Policy(policy: constants.personalData)),
                    icon: auth_icons.policyLine,
                  ),
                  _buildIconRow(),
                ],
              ),
              
            ],
          ),
        ),
      ),
    );
  }
}
