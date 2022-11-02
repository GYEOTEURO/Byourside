<<<<<<< HEAD
import 'package:byourside/screen/authenticate/verify_phone.dart';
import 'package:byourside/screen/home/home.dart';
import 'package:byourside/screen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_phone_auth_handler/firebase_phone_auth_handler.dart';
=======
import 'package:byourside/screen/bottomNavigationBar.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
>>>>>>> origin/feature/temperature/postList

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
<<<<<<< HEAD
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

  @override
  Widget build(BuildContext context) {
    return FirebasePhoneAuthProvider(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: '곁',
        initialRoute: "/login",
        routes: {
          "/login": (context) => LoginScreen(primaryColor: primaryColor),
          "/home": (context) => Home(),
          "/phone": (context) => VerifyPhone(),
        },
      ),
=======
 runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String _title = '곁';

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: _title,
      home: MyStatefulWidget(),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({super.key});

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      bottomNavigationBar: BottomNavBar(),
>>>>>>> origin/feature/temperature/postList
    );
  }
}
