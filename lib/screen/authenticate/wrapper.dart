import 'package:byourside/screen/authenticate/social_login/social_login.dart';
import 'package:byourside/screen/bottom_nav_bar.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:byourside/model/firebase_user.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<FirebaseUser?>(context);
    user = null;
    // print("wrapper");
    // print(user?.uid);
    // print("1");
    // print(user?.phoneNum);
    // print("2");
    // print(user?.displayName);
      // return const SocialLogin();

    // TODO: if로 다시 시작
    if (user == null) {
      return const SocialLogin();
    } else {
      return const BottomNavBar();
    }
  }
}