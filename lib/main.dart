import 'package:byourside/screen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

const primaryColor = Color(0xFF045558);

class MyApp extends StatefulWidget {
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late TabController controller;


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '곁',
      initialRoute: "/login",
      routes: {
        "/login": (context) => LoginScreen(primaryColor:primaryColor),
        //"/home": (context) => HomePage(),
      },
    );
  }
}
