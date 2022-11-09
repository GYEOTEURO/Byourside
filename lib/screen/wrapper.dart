import 'package:byourside/model/auth_provider.dart';
import 'package:byourside/screen/authenticate/verify_phone.dart';
import 'package:byourside/widget/auth.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import '../model/firebase_user.dart';
import 'authenticate/handler.dart';
import 'authenticate/verify_email.dart';

class Wrapper extends StatelessWidget{

  @override
  Widget build(BuildContext context) {

    final user =  Provider.of<FirebaseUser?>(context);
    AuthProvider _authProvider = Provider.of<AuthProvider>(context);

    if (_authProvider.authOk == false) {
      return VerifyPhone();
    }
    else if(_authProvider.haveEmail == false)//user == null)
    {
      return Handler();
    }else if(user == null){
      return Handler();
    }else
    {
      // Navigator.pushNamed(context, "/email");
        return VerifyEmail();
    }

  }
}