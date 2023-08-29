import 'package:byourside/constants/colors.dart' as colors;
import 'package:byourside/constants/fonts.dart' as fonts;
import 'package:byourside/constants/constants.dart' as constants;
import 'package:byourside/widget/stream_community_post.dart';
import 'package:byourside/widget/title_only_appbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../model/load_data.dart';

class MyScrap extends StatefulWidget {
  const MyScrap({Key? key}) : super(key: key);
  final String title = '스크랩한 게시글';

  @override
  State<MyScrap> createState() => _MyScrapState();
}

class _MyScrapState extends State<MyScrap> with SingleTickerProviderStateMixin {
  final User? user = FirebaseAuth.instance.currentUser;
  final LoadData loadData = LoadData();
  late TabController tabController = TabController(
    length: constants.scrapTabbar.length,
    vsync: this,
    initialIndex: 0,

    /// 탭 변경 애니메이션 시간
    animationDuration: const Duration(milliseconds: 800),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: titleOnlyAppbar(context, widget.title),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: _tabBar()
          ),
          Expanded(
            child: TabBarView(
              controller: tabController,
              children: [
                streamCommunityPost(() => loadData.readScrapPost(collectionName: 'community', uid: user!.uid)),
                Container()
                //streamCommunityPost(() => loadData.readScrapPost(collectionName: 'autoInformation', uid: user!.uid), []),
              ],
            ),
          )
      ]),
    );
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
        height: 1.69,
      ),
      unselectedLabelStyle: const TextStyle(
        fontSize: 13,
        fontFamily: fonts.font,
        fontWeight: FontWeight.w700,
        height: 1.69,
      ),
      tabs: [
        for(int i=0; i<constants.scrapTabbar.length; i++)
        Tab(text: constants.scrapTabbar[i]),
      ],
    );
  }
}
