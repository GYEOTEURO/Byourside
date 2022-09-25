import 'package:byourside/widget/social_button_from.dart';
import 'package:flutter/material.dart';
import '../size.dart';
import '../widget/custom_form.dart';
import '../widget/logo.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key?key, required this.primaryColor}) : super(key: key);
  final Color primaryColor;

  @override
  State<LoginScreen> createState() {
    return _LoginScreenState();
  }
}

class _LoginScreenState extends State<LoginScreen> {

  late CustomForm _customForm;
  late bool _authenticated;

  _LoginScreenState() {
    _customForm = CustomForm();
    _authenticated = false;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // SizedBox(height: xlarge_gap),
            Logo("Login"),
            SizedBox(height: large_gap), // 1. 추가
            CustomForm(), // 2. 추가
            SocialButtonForm("kakao"),
          ],
        ),
      ),
    );
  }

}