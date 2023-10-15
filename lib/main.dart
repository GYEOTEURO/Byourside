import 'package:byourside/screen/authenticate/controller/auth_controller.dart';
import 'package:byourside/screen/authenticate/controller/nickname_controller.dart';
import 'package:byourside/screen/authenticate/setup_user.dart';
import 'package:byourside/screen/authenticate/social_login.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:byourside/screen/bottom_nav_bar.dart';
import 'package:permission_handler/permission_handler.dart';
import 'firebase_options.dart';
import 'package:byourside/constants/fonts.dart' as fonts;
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

  AndroidNotificationChannel channel = const AndroidNotificationChannel(
    'high_importance_channel', // id
    'high_importance_notification', // title
    description:
        'This channel is used for important notifications.', // description
    importance: Importance.max,
  );

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  AndroidInitializationSettings androidInitializationSettings =
      const AndroidInitializationSettings('mipmap/ic_launcher');

  DarwinInitializationSettings iosInitializationSettings =
      const DarwinInitializationSettings(
    requestAlertPermission: false,
    requestBadgePermission: false,
    requestSoundPermission: false,
  );

  InitializationSettings initializationSettings = InitializationSettings(
    android: androidInitializationSettings,
    iOS: iosInitializationSettings,
  );
  await flutterLocalNotificationsPlugin.initialize(initializationSettings);

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
  ).then((value) {
    Get.put(AuthController());
    Get.put(NicknameController());
  });

  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };

  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };
  initializeNotification();
  FirebaseAppCheck firebaseAppCheck = FirebaseAppCheck.instance;

  await firebaseAppCheck.activate(
    webRecaptchaSiteKey: dotenv.env['WEB_RECAPTCHA_SITE_KEY'],
    androidProvider: AndroidProvider.playIntegrity,
  );

  runApp(GetMaterialApp(
    theme: ThemeData(
      fontFamily: fonts.font,
    ),
    home: const MyApp(),
    // debugShowCheckedModeBanner: false,
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  var messageString = '';


  @override
  void initState() {
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
        MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Beeside',
              initialRoute: '/login',
              routes: {
                '/login': (context) => const SocialLogin(),
                '/bottom_nav': (context) => const BottomNavBar(),
                '/user': (context) => const SetupUser(),
              },
            )
      ],
    );
  }
}
