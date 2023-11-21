import 'package:get/get.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationController extends GetxController {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  @override
  void onInit() async{
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
 
    _onMessage();
    super.onInit();
  }

  final AndroidNotificationChannel channel = const AndroidNotificationChannel(
    'high_importance_channel',
    'high_importance_notification',
    description: 'This channel is used for important notifications.', // description
    importance: Importance.max,
  );

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  void _onMessage() async{
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
   
    AndroidInitializationSettings androidInitializationSettings =
      const AndroidInitializationSettings('@mipmap/android_app_logo');

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
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;

      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                  channel.id,
                  channel.name,
                  channelDescription: channel.description
              ),
            ),
        );
      }

      Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
        print('백그라운드 메시지 처리.. ${message.notification!.body!}');
      }

      FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

      if (message.notification != null) {
        print('${message.notification!.body}');
      }
    });
  }

}