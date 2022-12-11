import 'package:byourside/screen/authenticate/verify_phone.dart';
import 'package:byourside/screen/home/home.dart';
import 'package:byourside/screen/authenticate/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_phone_auth_handler/firebase_phone_auth_handler.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:byourside/screen/bottomNavigationBar.dart';
import 'package:byourside/screen/ondo/postPage.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MaterialApp(
    home: MyApp(),
    debugShowCheckedModeBanner: false,
  ));
}

const primaryColor = Color(0xFF045558);

class MyApp extends StatefulWidget {
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late TabController controller;

  @override
  Widget build(BuildContext context) {
    return FirebasePhoneAuthProvider(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: '곁',
        initialRoute: "/login",
        routes: {
          "/login": (context) => LoginScreen(primaryColor: primaryColor),
          "/home": (context) => BottomNavBar(primaryColor: primaryColor),
          "/phone": (context) => VerifyPhone(),
        },
      ),
    );
  }
}