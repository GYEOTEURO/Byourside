import 'package:flutter/material.dart';
import 'package:byourside/size.dart';
import 'package:byourside/widget/google_login.dart';
// import '../widget/logo.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'dart:async';

class SocialLogin extends StatefulWidget {
  const SocialLogin({Key?key}) : super(key: key);

  @override
  State<SocialLogin> createState() {
    return _SocialLoginState();
  }
}

class _SocialLoginState extends State<SocialLogin> {

  @override
  initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: const [
            // SizedBox(height: xlarge_gap),
            SizedBox(height: large_gap), // 1. 추가
            // CustomForm(), // 2. 추가
            //SocialButtonForm("kakao"),
            GoogleLogin(),
          ],
        ),
      ),
    );
  }

}