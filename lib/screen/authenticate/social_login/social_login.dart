import 'package:flutter/material.dart';
import 'package:byourside/size.dart';
import 'package:byourside/widget/custom_form.dart';
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

  late CustomForm _customForm;
  // late bool _authenticated;
  // late StreamController<int> _userEvents;
  // int _counter = 0;

  @override
  initState() {
    super.initState();
    // _userEvents = new StreamController<int>();
    // _userEvents.add(0);
    _customForm = CustomForm();
    // _authenticated = false;
  }

  // void _incrementCounter() {
  //   _counter++;
  //   _userEvents.add(_counter);
  // }

  // _LoginScreenState() {
  //   _customForm = CustomForm();
  //   _authenticated = false;
  // }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // SizedBox(height: xlarge_gap),
            SizedBox(height: large_gap), // 1. 추가
            _customForm,
            // CustomForm(), // 2. 추가
            //SocialButtonForm("kakao"),
            googleLogin(),
          ],
        ),
      ),
    );
  }

}