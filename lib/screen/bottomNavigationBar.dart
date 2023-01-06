import 'package:byourside/screen/mypage/my_page.dart';
import 'package:byourside/screen/nanum/nanumPostList.dart';
import 'package:byourside/screen/nanum/type_controller.dart';
import 'package:byourside/screen/ondo/category.dart';
import 'package:byourside/screen/ondo/type_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'chat/chat_list_screen.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key, required this.primaryColor}) : super(key: key);
  final Color primaryColor;

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  final ondoController = Get.put(OndoTypeController());
  final nanumController = Get.put(NanumTypeController());

  int _selectedIndex = 0;
  // static TextStyle optionStyle =
  //   TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static final List<Widget> _widgetOptions = <Widget>[
    CategoryPage(),
    const NanumPostList(
        primaryColor: Color(0xFF045558), collectionName: "nanumPost"),
    ChatListScreen(),
    Mypage(),
  ];

  List<Icon> bottomIcons = [
    Icon(Icons.groups_outlined, semanticLabel: "마음온도"),
    Icon(Icons.volunteer_activism_outlined, semanticLabel: "마음나눔"),
    Icon(Icons.chat_outlined, semanticLabel: "채팅"),
    Icon(Icons.account_circle_outlined, semanticLabel: "마이페이지")
  ];

  List<Icon> bottomUnselectedIcons = [
    Icon(Icons.groups_outlined, semanticLabel: "마음온도"),
    Icon(Icons.volunteer_activism_outlined, semanticLabel: "마음나눔"),
    Icon(Icons.chat_outlined, semanticLabel: "채팅"),
    Icon(Icons.account_circle_outlined, semanticLabel: "마이페이지")
  ];

  List<Icon> bottomSelectedIcons = [
    Icon(Icons.group_rounded, semanticLabel: "마음온도"),
    Icon(Icons.volunteer_activism, semanticLabel: "마음나눔"),
    Icon(Icons.chat, semanticLabel: "채팅"),
    Icon(Icons.account_circle, semanticLabel: "마이페이지")
  ];

  void _onItemTapped(int index) {
    // 다른 탭으로 넘어갈 때, 필터링 초기화
    ondoController.filtering(null);
    nanumController.filtering(null);

    // 탭을 클릭했을떄 지정한 페이지로 이동
    setState(() {
      _selectedIndex = index;
      for (int i = 0; i < 4; i++) {
        if (_selectedIndex == i) {
          bottomIcons[i] = bottomSelectedIcons[i];
        } else {
          bottomIcons[i] = bottomUnselectedIcons[i];
        }
      }
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
        unselectedItemColor: Colors.white,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: bottomIcons[0],
            label: '마음온도',
          ),
          BottomNavigationBarItem(
            icon: bottomIcons[1],
            label: '마음나눔',
          ),
          BottomNavigationBarItem(
            icon: bottomIcons[2],
            label: '채팅',
          ),
          BottomNavigationBarItem(
            icon: bottomIcons[3],
            label: '마이페이지',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        onTap: _onItemTapped,
      ),
    );
  }
}
