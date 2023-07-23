import 'package:byourside/screen/authenticate/user.dart';
import 'package:byourside/screen/authenticate/user_paricipator.dart';
import 'package:byourside/screen/authenticate/user_protector.dart';
import 'package:byourside/screen/authenticate/user_someoneElse.dart';
import 'package:byourside/screen/authenticate/verify_email.dart';
import 'package:byourside/screen/authenticate/verify_phone.dart';
import 'package:byourside/screen/authenticate/login_screen.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_phone_auth_handler/firebase_phone_auth_handler.dart';
import 'package:get/get.dart';
import 'package:byourside/screen/bottom_nav_bar.dart';
import 'package:permission_handler/permission_handler.dart';
import 'firebase_options.dart';
import 'package:byourside/constants.dart' as constants;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

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

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('백그라운드 메시지 처리.. ${message.notification!.body!}');
}

void initializeNotification() async {
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(const AndroidNotificationChannel(
          'high_importance_channel', 'high_importance_notification',
          importance: Importance.max));

  await flutterLocalNotificationsPlugin.initialize(const InitializationSettings(
    android: AndroidInitializationSettings('@mipmap/ic_launcher'),
  ));

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
}

void main() async {
  await dotenv.load(fileName: 'assets/config/.env');
  WidgetsFlutterBinding.ensureInitialized();
  getPermission();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  initializeNotification();
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
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  var messageString = '';

  void getDeviceToken() async {
    final token = await FirebaseMessaging.instance.getToken();
    print('디바이스 토큰: $token');
  }

  @override
  void initState() {
    getDeviceToken();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      RemoteNotification? notification = message.notification;

      if (notification != null) {
        FlutterLocalNotificationsPlugin().show(
          notification.hashCode,
          notification.title,
          notification.body,
          const NotificationDetails(
            android: AndroidNotificationDetails(
              'high_importance_channel',
              'high_importance_notification',
              importance: Importance.max,
            ),
          ),
        );
        setState(() {
          messageString = message.notification!.body!;
          print('Foreground 메시지 수신: $messageString');
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Text('메시지 내용: $messageString'),
        FirebasePhoneAuthProvider(
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              fontFamily: 'NanumGothic',
            ),
            title: '곁',
            initialRoute: '/login',
            routes: {
              '/login': (context) =>
                  const LoginScreen(primaryColor: primaryColor),
              '/': (context) => const BottomNavBar(),
              '/phone': (context) => const VerifyPhone(),
              '/email': (context) => const VerifyEmail(),
              '/user': (context) => const SetupUser(),
              '/user_protector': (context) => const protector(),
              '/user_participator': (context) => const participator(),
              '/user_someoneElse': (context) => const someoneElse(),
            },
          ),
        ),
      ],
    );
  }
}
