import 'package:byourside/model/autoInformation_post.dart';
import 'package:byourside/widget/cusom_tab_bar.dart';
import 'package:byourside/widget/no_data.dart';
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

  Widget _streamAutoInformationPosts() {
    return StreamBuilder<List<AutoInformationPostModel>>(
            stream: loadData.readScrapAutoInformationPosts(uid: user!.uid),
            builder: (context, snapshots) {
              if (snapshots.hasData) {
                return ListView.builder(
                    itemCount: snapshots.data!.length,
                    shrinkWrap: true,
                    itemBuilder: (_, index) {
                      AutoInformationPostModel post = snapshots.data![index];
                      //return communityPostListTile(context, post);
                      return Text(post.title);
                    });
              } else {
                return noData();
              }
            });
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: titleOnlyAppbar(context, widget.title),
      body: CustomTabBar(
        community: streamCommunityPost(() => loadData.readScrapCommunityPosts(uid: user!.uid)),
        autoInformation: _streamAutoInformationPosts())
    );
  }
}
