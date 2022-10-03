import 'package:byourside/main.dart';
import 'package:byourside/screen/wrapper.dart';
import 'package:byourside/widget/social_button_from.dart';
import 'package:flutter/material.dart';
import '../size.dart';
import '../widget/custom_form.dart';
import '../widget/google_login.dart';
import '../widget/logo.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

import 'package:byourside/widget/auth.dart';
import '../model/firebase_user.dart';

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

  @override
  initState() {
    super.initState();
    _customForm = CustomForm();
  }

  @override
  Widget build(BuildContext context) {
    return StreamProvider<FirebaseUser?>.value(
      value: AuthService().user,
      initialData: null,
      child: MaterialApp(
        theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: primaryColor,
          buttonTheme: ButtonThemeData(
            buttonColor: primaryColor,
            textTheme: ButtonTextTheme.primary,
            colorScheme:
            Theme.of(context).colorScheme.copyWith(secondary: Colors.white),
          ),
          fontFamily: 'Georgia',
          textTheme: const TextTheme(
            headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
            headline6: TextStyle(fontSize: 20.0, fontStyle: FontStyle.italic),
            bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
          ),
        ),
        home: Wrapper(),
      ),);

  }

  //     Scaffold(
  //     body: Padding(
  //       padding: const EdgeInsets.all(16.0),
  //       child: ListView(
  //         children: [
  //           // SizedBox(height: xlarge_gap),
  //           Logo("Login"),
  //           SizedBox(height: large_gap), // 1. 추가
  //           CustomForm(), // 2. 추가
  //           //SocialButtonForm("kakao"),
  //           googleLogin(),
  //           // kakaoLogin(),
  //         ],
  //       ),
  //     ),
  //   );
  // }

}