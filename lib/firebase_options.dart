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
    apiKey: dotenv.env['web_apiKey']!,
    appId: dotenv.env['web_appId']!,
    messagingSenderId: dotenv.env['web_messagingSenderId']!,
    projectId: 'byourside-2ea11',
    authDomain: 'byourside-2ea11.firebaseapp.com',
    databaseURL: 'https://byourside-2ea11-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'byourside-2ea11.appspot.com',
    measurementId: dotenv.env['web_measurementId']!,
  );

  static FirebaseOptions android = FirebaseOptions(
    apiKey: dotenv.env['android_apiKey']!,
    appId: dotenv.env['android_appId']!,
    messagingSenderId: dotenv.env['android_messagingSenderId']!,
    projectId: 'byourside-2ea11',
    databaseURL: 'https://byourside-2ea11-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'byourside-2ea11.appspot.com',
  );

  static FirebaseOptions ios = FirebaseOptions(
    apiKey: dotenv.env['ios_apiKey']!,
    appId: dotenv.env['ios_appId']!,
    messagingSenderId: dotenv.env['ios_messagingSenderId']!,
    projectId: 'byourside-2ea11',
    databaseURL: 'https://byourside-2ea11-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'byourside-2ea11.appspot.com',
    androidClientId: dotenv.env['ios_androidClientId']!,
    iosClientId: dotenv.env['ios_iosClientId']!,
    iosBundleId: 'com.example.byourside',
  );

  static FirebaseOptions macos = FirebaseOptions(
    apiKey: dotenv.env['macos_apiKey']!,
    appId: dotenv.env['macos_appId']!,
    messagingSenderId: dotenv.env['macos_messagingSenderId']!,
    projectId: 'byourside-2ea11',
    databaseURL: 'https://byourside-2ea11-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'byourside-2ea11.appspot.com',
    androidClientId: dotenv.env['macos_androidClientId']!,
    iosClientId: dotenv.env['macos_iosClientId']!,
    iosBundleId: 'com.example.byourside',
  );
}