import 'package:byourside/screen/authenticate/user.dart';
import 'package:byourside/screen/authenticate/user_paricipator.dart';
import 'package:byourside/screen/authenticate/user_protector.dart';
import 'package:byourside/screen/authenticate/user_someoneElse.dart';
import 'package:byourside/screen/authenticate/verify_email.dart';
import 'package:byourside/screen/authenticate/verify_phone.dart';
import 'package:byourside/screen/authenticate/login_screen.dart';
import 'package:byourside/screen/chat/chat_list_screen.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_phone_auth_handler/firebase_phone_auth_handler.dart';
import 'package:get/get.dart';
import 'package:byourside/screen/bottomNavigationBar.dart';
import 'package:permission_handler/permission_handler.dart';
import 'firebase_options.dart';

Future<bool> getPermission() async {
  // Request multiple permissions at once. -> 카메라나 위치는 또 물어보는데 스토리지 빼고는 자동으로 수락해줘서 안물어봄
  Map<Permission, PermissionStatus> permissions = await [
    Permission.storage,
    Permission.speech,
    Permission.bluetooth,
    Permission.notification
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
    theme: ThemeData(
      fontFamily: 'NanumGothic',
      // 폰 자체 뒤로가기 에러 해결
      pageTransitionsTheme: PageTransitionsTheme(
        builders: {
          TargetPlatform.android: CupertinoPageTransitionsBuilder(),
          //TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      })),
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
            theme: ThemeData(
              fontFamily: 'NanumGothic',
              // 폰 자체 뒤로가기 에러 해결
              pageTransitionsTheme: PageTransitionsTheme(
                builders: {
                  TargetPlatform.android: CupertinoPageTransitionsBuilder(),
                  //TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
              })
            ),
            title: '곁',
            initialRoute: "/login",
            routes: {
              "/login": (context) => LoginScreen(primaryColor: primaryColor),
              "/": (context) => BottomNavBar(primaryColor: primaryColor),
              "/phone": (context) => VerifyPhone(),
              "/email": (context) => VerifyEmail(),
              "/user": (context) => SetupUser(),
              "/user_protector": (context) => protector(),
              "/user_participator": (context) => participator(),
              "/user_someoneElse": (context) => someoneElse(),
              "/chat_list": (context) => ChatListScreen(),
            },
          ),
        ),
      ],
    );
  }
}
