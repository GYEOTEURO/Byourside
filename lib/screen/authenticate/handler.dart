import 'package:byourside/screen/authenticate/login.dart';
import 'package:byourside/screen/authenticate/register.dart';
import 'package:flutter/material.dart';

class Handler extends StatefulWidget {
  const Handler({super.key});

  @override
  State<StatefulWidget> createState() {
    return _Handler();
  }
}

class _Handler extends State<Handler> {

  bool showSignin = true;

  void toggleView(){
    setState(() {
      showSignin = !showSignin;
    });
  }
  @override
  Widget build(BuildContext context) {
    // TODO: 코딩 스타일 맞추기
    if(showSignin)
    {
      return Login(toggleView : toggleView);
    }else
    {
      return Register(toggleView : toggleView);
    }
  }
}