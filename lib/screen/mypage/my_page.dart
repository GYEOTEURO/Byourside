import 'package:byourside/screen/mypage/options.dart';
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
  late String uid;
  late String displayName;
  User? user;
  

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
