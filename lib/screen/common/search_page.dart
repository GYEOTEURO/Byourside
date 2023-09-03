import 'package:byourside/screen/authenticate/controller/user_controller.dart';
import 'package:byourside/model/community_post.dart';
import 'package:byourside/model/load_data.dart';
import 'package:byourside/screen/community/community_post_list_tile.dart';
import 'package:byourside/widget/cusom_tab_bar.dart';
import 'package:byourside/widget/icon_buttons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:byourside/constants/fonts.dart' as fonts;
import 'package:byourside/constants/colors.dart' as colors;
import 'package:get/get.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final User? user = FirebaseAuth.instance.currentUser;
  final LoadData loadData = LoadData();
  TextEditingController query = TextEditingController();

  Widget _streamCommunityHotPosts(){
    return StreamBuilder<List<CommunityPostModel>>(
          stream: loadData.searchCommunityPosts(query.text),
          builder: (context, snapshots) {
            if (snapshots.hasData) {
              return ListView.builder(
                  itemCount: snapshots.data!.length,
                  itemBuilder: (_, index) {
                    CommunityPostModel post = snapshots.data![index];
                    if (Get.find<UserController>().userModel.blockedUsers!.contains(post.nickname)) {
                      return Container();
                    } else {
                      return communityPostListTile(context, post);
                    }
                  });
            } else {
              return Container();
            }
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
              children: [
                Expanded(
                    child: Row(
                      children: [
                      backToPreviousPage(context),
                      Expanded(
                        child: Container(
                          child: Semantics(
                          container: true,
                          textField: true,
                          label: '소통 게시판 내 검색',
                          child: TextFormField(
                            onTap: () { HapticFeedback.lightImpact(); },
                            controller: query,
                            maxLines: 1,
                            decoration: InputDecoration(
                              labelText: '소통 게시판 내 검색',
                              fillColor: colors.bgrColor,
                              filled: true,
                              labelStyle: const TextStyle(
                                  color: colors.textColor,
                                  fontSize: 12,
                                  fontFamily: fonts.font,
                                  fontWeight: FontWeight.w500),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(28),
                                  borderSide: BorderSide.none),
                              )
                            )
                      ),
                    ))
                  ])),
                  CustomTabBar(
                    community: _streamCommunityHotPosts(),
                    autoInformation: Container()),
              ])
        );
  }
}
