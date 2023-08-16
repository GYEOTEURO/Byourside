import 'package:byourside/screen/community/post_list.dart';
import 'package:byourside/screen/mypage/my_page.dart';
import 'package:flutter/material.dart';
import 'package:byourside/constants/colors.dart' as colors;
import 'package:byourside/constants/icons.dart' as customIcons;
import 'package:flutter_svg/flutter_svg.dart';


class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 2;
  static final List<Widget> _widgetOptions = <Widget>[
    Container(),
    const CommunityPostList(),
    Container(),
    Container()
  ];

  List<SvgPicture> bottomIcons = [
    customIcons.autoInformationBgr,
    customIcons.communityBgr,
    customIcons.home,
    customIcons.myPageBgr,
  ];

  List<SvgPicture> bottomUnselectedIcons = [
    customIcons.autoInformationBgr,
    customIcons.communityBgr,
    customIcons.homeBgr,
    customIcons.myPageBgr,
  ];

  List<SvgPicture> bottomSelectedIcons = [
    customIcons.autoInformation,
    customIcons.community,
    customIcons.home,
    customIcons.myPage,
  ];

  void _onItemTapped(int index) {
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
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: bottomIcons[0],
            label: '정보',
          ),
          BottomNavigationBarItem(
            icon: bottomIcons[1],
            label: '소통',
          ),
          BottomNavigationBarItem(
            icon: bottomIcons[2],
            label: '홈',
          ),
          BottomNavigationBarItem(
            icon: bottomIcons[3],
            label: '마이',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: colors.textColor,
        onTap: _onItemTapped,
      ),
    );
  }
}
