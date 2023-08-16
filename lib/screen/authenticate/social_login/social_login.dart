
import 'package:byourside/model/auth_controller.dart';
import 'package:byourside/widget/social_login_button.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SocialLogin extends StatelessWidget {
  const SocialLogin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SNS LOGIN'),
      ),
      body: Center(
        child: Column(
          children: [
            SocialLoginButton(
              buttonText: 'Google 로그인',
              buttonColor: Colors.red,
              iconColor: Colors.white,
              icon: FontAwesomeIcons.google,
              onPressed: (context) async {
                await AuthController.instance.loginWithGoogle(context);
              },
            ),
            SocialLoginButton(
              buttonText: 'Apple 로그인',
              buttonColor: Colors.black,
              iconColor: Colors.white,
              icon: FontAwesomeIcons.apple,
              onPressed: (context) async {
                await AuthController.instance.signInWithApple();
              },
            ),
          ],
        ),
      ),
    );
  }
}
