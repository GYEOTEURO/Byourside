import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import '../model/firebase_user.dart';
import 'authenticate/handler.dart';
import 'authenticate/verify_email.dart';

class Wrapper extends StatelessWidget{

  @override
  Widget build(BuildContext context) {

    final user =  Provider.of<FirebaseUser?>(context);

    if(user == null)
    {
      return Handler();
    }else
    {
      // Navigator.pushNamed(context, "/email");
      return VerifyEmail();
    }

  }
}