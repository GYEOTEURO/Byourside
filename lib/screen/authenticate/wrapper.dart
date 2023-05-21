import 'package:byourside/screen/authenticate/user.dart';
import 'package:byourside/screen/authenticate/verify_phone.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import '../../model/firebase_user.dart';
import 'handler.dart';
import 'verify_email.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<FirebaseUser?>(context);

    // print(user?.uid);
    // print(user?.phoneNum);
    // print(user?.displayName);
    if (user == null) {
      return const Handler();
    } else if (user.phoneNum == null || user.phoneNum == "") {
      return const VerifyPhone();
    } else if (user.displayName == null || user.displayName == "") {
      return const SetupUser();
    } else {
      return const VerifyEmail();
    }
  }
}
