import 'package:byourside/screen/mypage/my_page.dart';
import 'package:byourside/screen/nanum/nanumPostList.dart';
import 'package:byourside/screen/ondo/postList.dart';
import 'package:byourside/screen/ondo/postPage.dart';
import 'package:flutter/material.dart';

import 'mypage/my_page.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key, required this.primaryColor}) : super(key: key);
  final Color primaryColor;

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}
class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;
  static TextStyle optionStyle =
    TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static final List<Widget> _widgetOptions = <Widget>[
    PostList(primaryColor: Color(0xFF045558)),
    NanumPostList(primaryColor: Color(0xFF045558)),
    Text(
      'Index 2: Chat',
      style: optionStyle,
    ),
    Mypage(),
  ];
  void _onItemTapped(int index) {
    // 탭을 클릭했을떄 지정한 페이지로 이동
    setState(() {
      _selectedIndex = index;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Color(0xFF045558),
        unselectedItemColor: Color.fromARGB(255, 0, 0, 0),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.groups_rounded),
            label: '마음온도',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.volunteer_activism),
            label: '마음나눔',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: '채팅',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: '마이페이지',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Color.fromARGB(255, 255, 255, 255),
        onTap: _onItemTapped,
      ),
    );
  }
}
