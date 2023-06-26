import 'package:byourside/screen/mypage/my_page.dart';
import 'package:byourside/screen/nanum/nanumPostList.dart';
import 'package:byourside/screen/nanum/type_controller.dart';
import 'package:byourside/screen/community/category.dart';
import 'package:byourside/screen/community/overlay_controller.dart';
import 'package:byourside/screen/community/type_controller.dart';
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
  final overlayController = Get.put(OverlayController());

  int _selectedIndex = 0;
  // static TextStyle optionStyle =
  //   TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static final List<Widget> _widgetOptions = <Widget>[
    const CategoryPage(),
    const NanumPostList(
        primaryColor: Color(0xFF045558), collectionName: "nanumPost"),
    const ChatListScreen(),
    const Mypage(),
  ];

  List<Icon> bottomIcons = [
    const Icon(Icons.groups_rounded, semanticLabel: "마음온도"),
    const Icon(Icons.volunteer_activism_outlined, semanticLabel: "마음나눔"),
    const Icon(Icons.chat_outlined, semanticLabel: "채팅"),
    const Icon(Icons.account_circle_outlined, semanticLabel: "마이페이지")
  ];

  List<Icon> bottomUnselectedIcons = [
    const Icon(Icons.groups_outlined, semanticLabel: "마음온도"),
    const Icon(Icons.volunteer_activism_outlined, semanticLabel: "마음나눔"),
    const Icon(Icons.chat_outlined, semanticLabel: "채팅"),
    const Icon(Icons.account_circle_outlined, semanticLabel: "마이페이지")
  ];

  List<Icon> bottomSelectedIcons = [
    const Icon(Icons.groups_rounded, semanticLabel: "마음온도"),
    const Icon(Icons.volunteer_activism, semanticLabel: "마음나눔"),
    const Icon(Icons.chat, semanticLabel: "채팅"),
    const Icon(Icons.account_circle, semanticLabel: "마이페이지")
  ];

  void _onItemTapped(int index) {
    // 정보게시판 dropdown 열려있을때 닫아주기
    if (overlayController.overlayEntry != null) {
      overlayController.controlOverlay(null);
    }

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
        backgroundColor: Colors.white,
        unselectedItemColor: Colors.black38,
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
        selectedItemColor: const Color(0xFF045558),
        onTap: _onItemTapped,
      ),
    );
  }
}
