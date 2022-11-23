import 'package:byourside/screen/user.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import '../model/firebase_user.dart';
import 'authenticate/handler.dart';
import 'authenticate/verify_email.dart';

class Wrapper extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    final user =  Provider.of<FirebaseUser?>(context);

    print(user?.uid);
    print(user?.phoneNum);
    print(user?.displayName);
    if(user == null || user.phoneNum == null)
    {
      return Handler();
    }
    else if(user.displayName == null) {
      return SetupUser();
    }
    else {
      return VerifyEmail();
    }
  }
}