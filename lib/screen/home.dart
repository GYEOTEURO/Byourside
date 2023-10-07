import 'package:byourside/constants/colors.dart' as colors;
import 'package:byourside/constants/fonts.dart' as fonts;
import 'package:byourside/constants/icons.dart' as custom_icons;
import 'package:byourside/model/load_data.dart';
import 'package:byourside/screen/authenticate/controller/user_controller.dart';
import 'package:byourside/widget/common/app_bar_select_button.dart';
import 'package:byourside/widget/auto_information/stream_autoInfo_post.dart';
import 'package:byourside/widget/common/icon_buttons.dart';
import 'package:byourside/widget/community/stream_community_post.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final User? user = FirebaseAuth.instance.currentUser;
  final LoadData loadData = LoadData();
  String? disabilityType =
      Get.find<UserController>().userModel.disabilityType!.split(' ')[0];
  String? district = Get.find<UserController>().userModel.district;
  String? area = Get.find<UserController>().userModel.area;

  Widget _appbar() {
    return Container(
              height: 100.h,
              color: colors.homeAppBarColor,
              child: Column(
                children: [
                  //SizedBox(height: MediaQuery.of(context).size.height / 20.5),
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
                    Center(child: custom_icons.logo),
              ])
            );
  }

  Widget _title(SvgPicture icon, String title) {
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
            fontWeight: FontWeight.w700
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
              custom_icons.speechBubble,
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
          custom_icons.hobee
      ]);
  }

  Widget _autoInformationNewPosts() {
    return Flexible(
      child: horizontalScrollStreamAutoInfoPost(() =>
          loadData.readNewAutoInformationPosts(
              disabilityType: disabilityType, area: area, district: district)),
    );
  }

  Widget _communityHotPosts() {
    return Flexible(
        child: streamCommunityPost(() =>
            loadData.readHotCommunityPosts(disabilityType: disabilityType)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _appbar(),
          _title(custom_icons.autoInformation, '정보 게시판 최신글'),
          _autoInformationNewPosts(),
          _bubbleHobee(),
          _title(custom_icons.community, '소통 게시판 인기글'),
          _communityHotPosts()
        ])
      );
  }
}
