import 'package:byourside/screen/authenticate/user.dart';
import 'package:byourside/screen/authenticate/verify_email.dart';
import 'package:byourside/screen/authenticate/verify_phone.dart';
import 'package:byourside/screen/authenticate/login_screen.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_phone_auth_handler/firebase_phone_auth_handler.dart';
import 'package:byourside/screen/bottomNavigationBar.dart';
// import 'package:flutter_recaptcha_v3/flutter_recaptcha_v2.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseAppCheck.instance.activate(
    webRecaptchaSiteKey: 'recaptcha-v3-site-key',
    // Default provider for Android is the Play Integrity provider. You can use the "AndroidProvider" enum to choose
    // your preferred provider. Choose from:
    // 1. debug provider
    // 2. safety net provider
    // 3. play integrity provider
    androidProvider: AndroidProvider.playIntegrity,
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
  // RecaptchaV2Controller recaptchaV2Controller = RecaptchaV2Controller();

  @override
  Widget build(BuildContext context) {
    // return StreamProvider<FirebaseUser?>.value(
    //   value: AuthService().user,
    //   initialData: null,
    //   child: MaterialApp(
    //     theme: ThemeData(
    //       brightness: Brightness.light,
    //       primaryColor: primaryColor,
    //       buttonTheme: ButtonThemeData(
    //         buttonColor: primaryColor,
    //         textTheme: ButtonTextTheme.primary,
    //         colorScheme:
    //         Theme.of(context).colorScheme.copyWith(secondary: Colors.white),
    //       ),
    //       fontFamily: 'Georgia',
    //       textTheme: const TextTheme(
    //         headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
    //         headline6: TextStyle(fontSize: 20.0, fontStyle: FontStyle.italic),
    //         bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
    //       ),
    //     ),
    //     home: Wrapper(),
    //   ),);
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
        // RecaptchaV2(
        //   apiKey: "6LdtvqkjAAAAALWlvmPxUEoi3Sj2bsjbJmJt1Uw8",
        //   // for enabling the reCaptcha
        //   apiSecret: "6LdtvqkjAAAAAMFyC4Lk9cbRfSHPM8fytu6AebSW",
        //   // for verifying the responded token
        //   controller: recaptchaV2Controller,
        //   onVerifiedError: (err) {
        //     print(err);
        //   },
        //   onVerifiedSuccessfully: (success) {
        //     setState(() {
        //       if (success) {
        //         // You've been verified successfully.
        //       } else {
        //         // "Failed to verify.
        //       }
        //     });
        //   },
        // ),
      ],
    );
  }
}