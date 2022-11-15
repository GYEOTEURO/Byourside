import 'package:byourside/model/auth_provider.dart';
import 'package:byourside/screen/authenticate/verify_phone.dart';
import 'package:byourside/widget/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
    if(user == null || user.phoneNum == null)
    {
      return Handler();
    }else
    {
      return VerifyEmail();
    }
    // AuthProvider _authProvider = Provider.of<AuthProvider>(context);
    //
    // if (auth.currentUser != null) {
    //   _authProvider.setVerificationId(auth.currentUser!.uid);
    //   FirebaseUser(uid: auth.currentUser!.uid);
    //   if (auth.currentUser!.phoneNumber != null) {
    //     _authProvider.changeAuthOk(true);
    //   }
    //   if (auth.currentUser!.emailVerified != null) {
    //     _authProvider.changeHaveEmail(true);
    //   }
    // }

    // if (_authProvider.authOk == false && user == null && auth.currentUser == null) {
    //   print(_authProvider.authOk);
    //   print(user);
    //   // print(auth.currentUser);
    //   return VerifyPhone();
    // }
    // else if(_authProvider.haveEmail == false && auth.currentUser == null)
    // {
    //   print(auth.currentUser);
    //   print("haveEmail");
    //   return Handler();
    // }else if(user == null && auth.currentUser == null){
    //   print("user");
    //   return Handler();
    // }else
    // {
    //   // Navigator.pushNamed(context, "/email");
    //   print("verifyemail");
    //   return VerifyEmail();
    // }

  }
}