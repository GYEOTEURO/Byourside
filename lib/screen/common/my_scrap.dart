import 'package:byourside/widget/auto_information/stream_autoInfo_post.dart';
import 'package:byourside/widget/common/cusom_tab_bar.dart';
import 'package:byourside/widget/community/stream_community_post.dart';
import 'package:byourside/widget/common/title_only_appbar.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: titleOnlyAppbar(context, widget.title),
        body: CustomTabBar(
            community: streamCommunityPost(
                () => loadData.readScrapCommunityPosts(uid: user!.uid)),
            autoInformation: verticalScollStreamAutoInfoPost(
                () => loadData.readScrapAutoInformationPosts(uid: user!.uid))));
  }
}
