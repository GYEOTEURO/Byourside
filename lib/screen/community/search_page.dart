import 'package:byourside/model/authenticate/user_controller.dart';
import 'package:byourside/model/community_post.dart';
import 'package:byourside/model/load_data.dart';
import 'package:byourside/screen/community/community_post_list_tile.dart';
import 'package:byourside/widget/icon_buttons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:byourside/constants/fonts.dart' as fonts;
import 'package:byourside/constants/colors.dart' as colors;
import 'package:get/get.dart';

class CommunitySearch extends StatefulWidget {
  const CommunitySearch({Key? key}) : super(key: key);

  @override
  State<CommunitySearch> createState() => _CommunitySearchState();
}

class _CommunitySearchState extends State<CommunitySearch> {
  final User? user = FirebaseAuth.instance.currentUser;
  final LoadData loadData = LoadData();
  TextEditingController query = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            child: Column(
              children: [
                const SizedBox(height: 30),
                Row(
                  children: [
                  backToPreviousPage(context),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
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
                  ]),
                  Expanded(
                        child: StreamBuilder<List<CommunityPostModel>>(
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
                  })
            )])
        ));
  }
}
