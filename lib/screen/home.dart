import 'package:byourside/constants/colors.dart' as colors;
import 'package:byourside/constants/fonts.dart' as fonts;
import 'package:byourside/constants/icons.dart' as customIcons;
import 'package:byourside/screen/authenticate/controller/user_controller.dart';
import 'package:byourside/model/community_post.dart';
import 'package:byourside/screen/community/community_post_list_tile.dart';
import 'package:byourside/widget/app_bar_select_button.dart';
import 'package:byourside/widget/icon_buttons.dart';
import 'package:byourside/widget/no_data.dart';
import 'package:byourside/widget/stream_community_post.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../model/load_data.dart';

class Home extends StatefulWidget {
  const Home(
      {Key? key})
      : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final User? user = FirebaseAuth.instance.currentUser;
  final LoadData loadData = LoadData();
  String? disabilityType = Get.find<UserController>().userModel.disabilityType!.split(' ')[0];
  String? district = Get.find<UserController>().userModel.district;

  Widget _appbar(){
    return Container(
              height: MediaQuery.of(context).size.height / 6.5,
              color: colors.homeAppBarColor,
              child: Column(
                children: [
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            const SizedBox(width: 10),
                            appBarSelectButton(context, district!),
                            const SizedBox(width: 5),
                            appBarSelectButton(context, disabilityType!)
                          ])),
                      Row(
                        children: [
                          goToScrapPage(context),
                          goToSearchPage(context)
                        ])
                    ]),
                    Center(child: customIcons.logo),
              ])
            );
  } 

  Widget _titleSeeMore(SvgPicture icon, String title, int index){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        icon,
        Text(
          title,
          style: const TextStyle(
              color: colors.textColor,
              fontSize: 20,
              fontFamily: fonts.font,
              fontWeight: FontWeight.w700,
              height: 1.50,
          ),
        )
    ]);
  }

  Widget _bubbleHobee(){
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              customIcons.speechBubble,
              Container(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 6),
                child: Text(
                '$district민들의 이야기를 들어보세요',
                style: const TextStyle(
                    color: colors.textColor,
                    fontSize: 13,
                    fontFamily: fonts.font,
                    fontWeight: FontWeight.w400
                ),
            ))
            ]
          ),
          customIcons.hobee
      ]);
  }
  Widget _autoInformationNewPosts(){
    return Container(
      height: MediaQuery.of(context).size.height / 5,
    );
  }
  Widget _communityHotPosts(){
    return Flexible(
      child: streamCommunityPost(() => loadData.readHotCommunityPosts(disabilityType: disabilityType))
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _appbar(),
          _titleSeeMore(customIcons.autoInformation, '정보 게시판 최신글', 0),
          _autoInformationNewPosts(),
          _bubbleHobee(),
          _titleSeeMore(customIcons.community, '소통 게시판 인기글', 1),
          _communityHotPosts()
        ])
      ); 
  }
}
