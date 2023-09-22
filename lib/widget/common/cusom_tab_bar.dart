import 'package:byourside/constants/colors.dart' as colors;
import 'package:byourside/constants/fonts.dart' as fonts;
import 'package:byourside/constants/constants.dart' as constants;
import 'package:flutter/material.dart';

class CustomTabBar extends StatefulWidget {
  CustomTabBar({
    Key? key,
    required this.community,
    required this.autoInformation
  }) : super(key: key);

  Widget community;
  Widget autoInformation;

  @override
  State<CustomTabBar> createState() => _CustomTabBarState();
}

class _CustomTabBarState extends State<CustomTabBar> with SingleTickerProviderStateMixin {
  late TabController tabController = TabController(
    length: 2,
    vsync: this,
    initialIndex: 0,
    animationDuration: const Duration(milliseconds: 800),
  );

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: _tabBar()
          ),
          Expanded(
            child: TabBarView(
              controller: tabController,
              children: [
                widget.community,
                widget.autoInformation
              ],
            ),
          )
      ]);
  }

   Widget _tabBar() {
    return TabBar(
      controller: tabController,
      labelColor: colors.textColor,
      unselectedLabelColor: colors.subColor,
      dividerColor: colors.subColor,
      indicatorColor: colors.textColor,
      indicatorWeight: 1,
      labelStyle: const TextStyle(
        fontSize: 13,
        fontFamily: fonts.font,
        fontWeight: FontWeight.w700,
      ),
      unselectedLabelStyle: const TextStyle(
        fontSize: 13,
        fontFamily: fonts.font,
        fontWeight: FontWeight.w700,
      ),
      tabs: const [
        Tab(text: constants.communityTitle),
        Tab(text: constants.autoInformationTitle),
      ],
    );
  }
}
