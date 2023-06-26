import 'package:byourside/screen/community/post_list.dart';
import 'package:byourside/screen/mypage/my_page.dart';
import 'package:byourside/screen/community/type_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:byourside/constants.dart' as constants;

class BottomNavBar extends StatefulWidget {
  const BottomNavBar();

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  final communityController = Get.put(CommunityTypeController());

  int _selectedIndex = 0;
  // static TextStyle optionStyle =
  //   TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static final List<Widget> _widgetOptions = <Widget>[
    const CommunityPostList(
      category: '',
      collectionName: '',
      primaryColor: constants.mainColor,
    ),
    const Mypage(),
  ];

  List<Icon> bottomIcons = [
    const Icon(Icons.groups_rounded, semanticLabel: constants.communityTitle),
    const Icon(Icons.account_circle_outlined, semanticLabel: '마이페이지')
  ];

  List<Icon> bottomUnselectedIcons = [
    const Icon(Icons.groups_outlined, semanticLabel: constants.communityTitle),
    const Icon(Icons.account_circle_outlined, semanticLabel: '마이페이지')
  ];

  List<Icon> bottomSelectedIcons = [
    const Icon(Icons.groups_rounded, semanticLabel: constants.communityTitle),
    const Icon(Icons.account_circle, semanticLabel: '마이페이지')
  ];

  void _onItemTapped(int index) {
    // 다른 탭으로 넘어갈 때, 필터링 초기화
    communityController.filtering(null);

    // 탭을 클릭했을떄 지정한 페이지로 이동
    setState(() {
      _selectedIndex = index;
      for (int i = 0; i < bottomIcons.length; i++) {
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
            label: '커뮤니티',
          ),
          BottomNavigationBarItem(
            icon: bottomIcons[1],
            label: '마이페이지',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: constants.mainColor,
        onTap: _onItemTapped,
      ),
    );
  }
}
