import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

import 'package:flutter_dotenv/flutter_dotenv.dart';
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
              'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
              'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static FirebaseOptions web = FirebaseOptions(
    apiKey: dotenv.env['WEB_API_KEY']!,
    appId: dotenv.env['WEB_APP_ID']!,
    messagingSenderId: dotenv.env['WEB_MESSAGING_SENDER_ID']!,
    projectId: 'byourside-2ea11',
    authDomain: 'byourside-2ea11.firebaseapp.com',
    databaseURL: 'https://byourside-2ea11-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'byourside-2ea11.appspot.com',
    measurementId: dotenv.env['WEB_MEASUREMENT_ID']!,
  );

  static FirebaseOptions android = FirebaseOptions(
    apiKey: dotenv.env['ANDROID_API_KEY']!,
    appId: dotenv.env['ANDROID_APP_ID']!,
    messagingSenderId: dotenv.env['ANDROID_MESSAGING_SENDER_ID']!,
    projectId: 'byourside-2ea11',
    databaseURL: 'https://byourside-2ea11-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'byourside-2ea11.appspot.com',
  );

  static FirebaseOptions ios = FirebaseOptions(
    apiKey: dotenv.env['IOS_API_KEY']!,
    appId: dotenv.env['IOS_APP_ID']!,
    messagingSenderId: dotenv.env['IOS_MESSAGING_SENDER_ID']!,
    projectId: 'byourside-2ea11',
    databaseURL: 'https://byourside-2ea11-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'byourside-2ea11.appspot.com',
    androidClientId: dotenv.env['IOS_ANDROID_CLIENT_ID']!,
    iosClientId: dotenv.env['IOS_IOS_CLIENT_ID']!,
    iosBundleId: 'com.example.byourside',
  );

  static FirebaseOptions macos = FirebaseOptions(
    apiKey: dotenv.env['MACOS_API_KEY']!,
    appId: dotenv.env['MACOS_APP_ID']!,
    messagingSenderId: dotenv.env['MACOS_MESSAGING_SENDER_ID']!,
    projectId: 'byourside-2ea11',
    databaseURL: 'https://byourside-2ea11-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'byourside-2ea11.appspot.com',
    androidClientId: dotenv.env['MACOS_ANDROID_CLIENT_ID']!,
    iosClientId: dotenv.env['MACOS_IOS_CLIENT_ID']!,
    iosBundleId: 'com.example.byourside',
  );
}