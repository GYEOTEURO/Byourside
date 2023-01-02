import 'package:byourside/screen/authenticate/user.dart';
import 'package:byourside/screen/authenticate/verify_email.dart';
import 'package:byourside/screen/authenticate/verify_phone.dart';
import 'package:byourside/screen/authenticate/login_screen.dart';
import 'package:byourside/screen/ondo/postCategory.dart';
import 'package:byourside/screen/ondo/postList.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_phone_auth_handler/firebase_phone_auth_handler.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:byourside/screen/bottomNavigationBar.dart';
import 'package:byourside/screen/ondo/postPage.dart';
import 'package:permission_handler/permission_handler.dart';

import 'firebase_options.dart';

Future<bool> getPermission() async {
  Map<Permission, PermissionStatus> permissions = await [
    Permission.storage,
    Permission.location,
    Permission.locationWhenInUse
  ].request();
  print('per1 : $permissions');
  if (permissions.values.every((element) => element.isGranted)) {
    return Future.value(true);
  } else {
    return Future.value(false);
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  getPermission();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseAppCheck firebaseAppCheck = FirebaseAppCheck.instance;
  // firebaseAppCheck.installAppCheckProviderFactory(
  //     PlayIntegrityAppCheckProviderFactory.getInstance());
  await firebaseAppCheck.activate(
    webRecaptchaSiteKey: '6LdtvqkjAAAAALWlvmPxUEoi3Sj2bsjbJmJt1Uw8',
    // Default provider for Android is the Play Integrity provider. You can use the "AndroidProvider" enum to choose
    // your preferred provider. Choose from:
    // 1. debug provider
    // 2. safety net provider
    // 3. play integrity provider
    androidProvider: AndroidProvider.playIntegrity,
  );
  runApp(GetMaterialApp(
    home: MyApp(),
    // debugShowCheckedModeBanner: false,
  ));
}

const primaryColor = Color(0xFF045558);

class MyApp extends StatefulWidget {
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        FirebasePhoneAuthProvider(
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: '곁',
            initialRoute: "/login",
            routes: {
              "/login": (context) => LoginScreen(primaryColor: primaryColor),
              "/home": (context) => BottomNavBar(primaryColor: primaryColor),
              "/phone": (context) => VerifyPhone(),
              "/email": (context) => VerifyEmail(),
              "/user": (context) => SetupUser(),
            },
          ),
        ),
      ],
    );
  }
}
