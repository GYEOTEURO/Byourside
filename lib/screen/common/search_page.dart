import 'package:byourside/model/autoInformation_post.dart';
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
  final TextEditingController query = TextEditingController();

  Widget _streamCommunityPosts(){
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

  Widget _streamAutoInformationPosts(){
    return StreamBuilder<List<AutoInformationPostModel>>(
          stream: loadData.searchAutoInformationPosts(query.text),
          builder: (context, snapshots) {
            if (snapshots.hasData) {
              return ListView.builder(
                  itemCount: snapshots.data!.length,
                  itemBuilder: (_, index) {
                    AutoInformationPostModel post = snapshots.data![index];
                      return Text(post.title);
                      //return communityPostListTile(context, post);
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
                const SizedBox(height: 20),
                Row(
                  children: [
                      backToPreviousPage(context),
                      Flexible(
                        child: Container(
                          padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                          child: Semantics(
                          label: '검색할 키워드를 입력해주세요.',
                          child: TextFormField(
                            onTap: () { HapticFeedback.lightImpact(); },
                            onChanged: (text) {
                              setState(() {});
                            },
                            controller: query,
                            maxLines: 1,
                            decoration: InputDecoration(
                              labelText: '검색할 키워드를 입력해주세요.',
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
                  ]),
                  const SizedBox(height: 20),
                  Flexible(
                    child: CustomTabBar(
                      community: _streamCommunityPosts(),
                      autoInformation: _streamAutoInformationPosts()),
                  )
          ])
        );
  }
}
