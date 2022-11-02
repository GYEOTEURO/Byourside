import 'package:byourside/screen/bottomNavigationBar.dart';
import 'package:byourside/screen/ondo/postPage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_core/firebase_core.dart';

// 앱의 메인 색상인 primaryColor 지정
const primaryColor = Color(0xFF045558);
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
 runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String _title = '곁';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Post page',
      theme: ThemeData(),
      home: const MyHomePage(title: 'Temperature Main Page'),
    );
  }
}

// 앱 실행 시 가장 먼저 보이는 화면 위젯 구성
class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // BottomNavBar 위젯에 primartColor와 title명을 인자로 넘김
        body: BottomNavBar(primaryColor: primaryColor));
  }
}
