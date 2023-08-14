import 'package:byourside/model/auth_controller.dart';
import 'package:byourside/screen/authenticate/info/user_setup.dart';
import 'package:byourside/screen/authenticate/social_login/social_login.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_phone_auth_handler/firebase_phone_auth_handler.dart';
import 'package:get/get.dart';
import 'package:byourside/screen/bottom_nav_bar.dart';
import 'package:permission_handler/permission_handler.dart';
import 'firebase_options.dart';
import 'package:byourside/constants.dart' as constants;

import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<bool> getPermission() async {
  // Request multiple permissions at once. -> 카메라나 위치는 또 물어보는데 스토리지 빼고는 자동으로 수락해줘서 안물어봄
  Map<Permission, PermissionStatus> permissions = await [
    Permission.storage,
    Permission.speech,
    Permission.bluetooth,
    Permission.notification
  ].request();

  if (permissions.values.every((element) => element.isGranted)) {
    return Future.value(true);
  } else {
    return Future.value(false);
  }
}

void main() async {
  await dotenv.load(fileName: 'assets/config/.env');

  WidgetsFlutterBinding.ensureInitialized();
  getPermission();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ).then((value) => Get.put(AuthController()));

  FlutterError.onError = (errorDetails) {
      FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };
    // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };

  FirebaseAppCheck firebaseAppCheck = FirebaseAppCheck.instance;

  await firebaseAppCheck.activate(
    webRecaptchaSiteKey: dotenv.env['WEB_RECAPTCHA_SITE_KEY'],
    androidProvider: AndroidProvider.playIntegrity,
  );
  
  runApp(GetMaterialApp(
    theme: ThemeData(
      fontFamily: constants.font,
    ),
    home: const MyApp(),
    // debugShowCheckedModeBanner: false,
  ));
}

const primaryColor = Color(0xFF045558);

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        FirebasePhoneAuthProvider(
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              fontFamily: 'NanumGothic',
            ),
            title: '곁',
            initialRoute: '/login',
            routes: {
              '/login': (context) => const SocialLogin(),
              '/bottom_nav': (context) => const BottomNavBar(),
              '/user': (context) => const UserSetUp(),
            },
          ),
        ),
      ],
    );
  }
}
