import 'dart:io';
import 'package:flutter/material.dart';
import 'package:byourside/widget/authenticate/policy_link.dart';
import 'package:byourside/widget/authenticate/social_login_button.dart';
import 'package:byourside/constants/auth_icons.dart';
import 'package:byourside/screen/authenticate/policy/personal_data.dart';
import 'package:byourside/screen/authenticate/policy/personal_policy.dart';

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
              Container(
                width: 152.72,
                height: 145.02,
                decoration: const BoxDecoration(
                  color: Colors.transparent,
                ),
                child: AuthIcons.beesideLogo,
              ),
              const SizedBox(height: 100),
              SocialLoginButton(
                color: Colors.white,
                icon: Container(
                  width: 39,
                  height: 44,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: AuthIcons.googleIcon,
                ),
                text: 'Google 계정으로 로그인', onPressed: () {  },
              ),
              const SizedBox(height: 20),
              if (isIOS) 
                SocialLoginButton(
                  color: Colors.white,
                  icon: Container(
                    width: 39,
                    height: 44,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                    ),
                    child: AuthIcons.appleIcon,
                  ),
                  text: 'Apple로 로그인', onPressed: () {  },
                ),
              const SizedBox(height: 30),
              PolicyLink(
                text: '이용약관',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const PersonalData()),
                  );
                },
                icon: AuthIcons.tosLine,
              ),
              const SizedBox(height: 5),
              PolicyLink(
                text: '개인정보 처리방침',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const PersonalPolicy()),
                  );
                },
                icon:AuthIcons.policyLine,
              ),
            ],
          ),
        ),
      ),
    );
  }

}
