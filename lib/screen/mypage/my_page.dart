import 'package:byourside/screen/mypage/options.dart';
import 'package:byourside/screen/authenticate/controller/auth_controller.dart';
import 'package:byourside/screen/authenticate/social_login/social_login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:byourside/constants/constants.dart' as constants;

class Mypage extends StatefulWidget {
  const Mypage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _Mypage();
  }
}

class _Mypage extends State<Mypage> {
  final AuthController _authController = AuthController.instance;
  late String uid;
  late String displayName;
  User? user;

  void _logout(context) async {
   _authController.logout();
    setState(() {});
    Navigator.of(context).popUntil((route) => route.isFirst);
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => const SocialLogin(
      ),
    ));
    // Navigator.pushNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        myPageOptions(context, '기타', constants.etc),
        myPageOptions(context, '내 활동', constants.myActivity),
      ]
    );
  }
}
