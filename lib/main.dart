import 'package:byourside/screen/login_screen.dart';
import 'package:flutter/material.dart';
void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late TabController controller;
  bool login = false;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: '곁',
        theme: ThemeData(
            brightness: Brightness.dark,
            primaryColor: Colors.black,
        ),
        home: DefaultTabController(
          length: 4,
          child: Scaffold(
            body: TabBarView(
              physics: NeverScrollableScrollPhysics(),
              children: [
                LoginScreen(),
                LoginScreen(),
                LoginScreen(),
                LoginScreen(),
              ],
            ),
            // bottomNavigationBar: Bottom(),
          ),
        )
    );
  }
}
