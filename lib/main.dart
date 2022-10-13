import 'package:byourside/screen/bottomNavigationBar.dart';
import 'package:byourside/screen/post/postPage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

// 앱의 메인 색상인 primaryColor 지정
const primaryColor = Color(0xFF045558);

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const String _title = '곁';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Post page',
      theme: ThemeData(),
      home: const MyHomePage(title: 'Temperature Post Page'),
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
      appBar: AppBar(
        // AppBar 색상 primaryColor로 지정
        backgroundColor: primaryColor,
        title: Text(widget.title),
      ),
      // bottomNavigationBar: BottomNavBar(),
      // 누르면 글 작성하는 PostPage로 navigate하는 버튼
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => BottomNavBar(
                      // PostPage 위젯에 primartColor와 title명을 인자로 넘김
                      primaryColor: primaryColor)));
        },
        backgroundColor: primaryColor,
        child: const Icon(Icons.add),
      ),
    );
  }
}
