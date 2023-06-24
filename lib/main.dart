import 'package:byourside/screen/authenticate/info/user_type.dart';
import 'package:byourside/screen/authenticate/info/user_paricipator.dart';
import 'package:byourside/screen/authenticate/info/user_protector.dart';
import 'package:byourside/screen/authenticate/info/user_someone_else.dart';
import 'package:byourside/screen/authenticate/auth_home.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_phone_auth_handler/firebase_phone_auth_handler.dart';
import 'package:get/get.dart';
import 'package:byourside/screen/bottomNavigationBar.dart';
import 'package:permission_handler/permission_handler.dart';
import 'firebase_options.dart';

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
  );
  FirebaseAppCheck firebaseAppCheck = FirebaseAppCheck.instance;
  // firebaseAppCheck.installAppCheckProviderFactory(
  //     PlayIntegrityAppCheckProviderFactory.getInstance());
  await firebaseAppCheck.activate(
    webRecaptchaSiteKey: dotenv.env['WEB_RECAPTCHA_SITE_KEY'],
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
              '/login': (context) => const LoginScreen(),
              '/': (context) => const BottomNavBar(primaryColor: primaryColor),
              '/user': (context) => const SetupUser(),
              '/user_protector': (context) => const Protector(),
              '/user_participator': (context) => const Participator(),
              '/user_someoneElse': (context) => const SomeoneElse(),
            },
          ),
        ),
      ],
    );
  }
}