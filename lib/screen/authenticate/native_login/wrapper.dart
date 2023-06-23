import 'package:byourside/screen/authenticate/info/user_type.dart';
import 'package:byourside/screen/authenticate/native_login/verify_phone.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:byourside/model/firebase_user.dart';
import '../handler.dart';
import 'package:byourside/screen/authenticate/native_login/verify_email.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<FirebaseUser?>(context);

    // print(user?.uid);
    // print(user?.phoneNum);
    // print(user?.displayName);
    // TODO: if로 다시 시작
    if (user == null) {
      return const Handler();
    } else if (user.phoneNum == null || user.phoneNum == '') {
      return const VerifyPhone();
    } else if (user.displayName == null || user.displayName == '') {
      return const SetupUser();
    } else {
      return const VerifyEmail();
    }
  }
}
