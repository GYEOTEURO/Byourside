import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; 
import 'package:byourside/constants/text.dart' as text;
import 'package:byourside/constants/colors.dart' as colors;
import 'package:byourside/constants/auth_icons.dart' as auth_icons;
import 'package:byourside/utils/device_size_utils.dart';
import 'package:byourside/widget/authenticate/login/policy_link.dart';
import 'package:byourside/widget/authenticate/login/social_login_button.dart';
import 'package:byourside/screen/authenticate/controller/auth_controller.dart';

class SocialLogin extends StatelessWidget {
  const SocialLogin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isIOS = Platform.isIOS;

    var deviceWidth = getDeviceWidth(context);
    var deviceHeight = getDeviceHeight(context);

    Widget buildLogo() {
      return Container(
        width: deviceWidth * 0.42,
        height: deviceHeight * 0.19,
        decoration: const BoxDecoration(
          color: Colors.transparent,
        ),
        child: auth_icons.beesideLogo,
      );
    }

  // 함수는 하나의 일만 하도록? 음... 그러면 추상화 수준이 달라지지않나.....
    Widget buildButtons(BuildContext context) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SocialLoginButton(
            color: Colors.white,
            icon: auth_icons.googleIcon,
            text: text.googleLoginText,
            onPressed: (context) async {
              HapticFeedback.lightImpact();
              await AuthController.instance.loginWithGoogle(context);
            },
          ),
          SizedBox(height: deviceHeight * 0.04),
          if (isIOS)
            SocialLoginButton(
              color: Colors.white,
              icon: auth_icons.appleIcon,
              text: text.appleLoginText,
              onPressed: (context) async {
                HapticFeedback.lightImpact();
                await AuthController.instance.signInWithApple();
              },
            ),
        ],
      );
    }

    Widget buildPolicyLinks() {
      return Column(
        children: [
          PolicyLink(
            text: text.termsOfService,
            policyPath: text.usingPolicy,
            icon: auth_icons.tosLine,
          ),
          PolicyLink(
            text: text.privacyPolicy,
            policyPath: text.personalData,
            icon: auth_icons.policyLine,
          ),
        ],
      );
    }

    Widget buildIconRow() {
      return SizedBox(
        width: deviceWidth,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            auth_icons.beeIcon,
            auth_icons.beeIcon,
            auth_icons.beeIcon,
          ],
        ),
      );
    }

    // TODO: const도 없애자
    Widget buildScaffoldBody(BuildContext context) {
      return DecoratedBox(
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
              buildIconRow(),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Semantics(
                    label: text.loginTitle,
                    child: SizedBox(height: deviceHeight * 0.27),
                  ),
                  buildLogo(),
                  SizedBox(height: deviceHeight * 0.13),
                  buildButtons(context),
                  SizedBox(height: deviceHeight * 0.07),
                  buildPolicyLinks(),
                  SizedBox(height: deviceHeight * 0.1),                ],
              ),
            ],
          ),
        ),
      );
    }

    return buildScaffoldBody(context);
  }
}
