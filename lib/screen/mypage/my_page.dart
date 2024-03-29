import 'package:byourside/screen/authenticate/controller/user_controller.dart';
import 'package:byourside/screen/mypage/options.dart';
import 'package:byourside/widget/info_container.dart';
import 'package:byourside/widget/common/title_only_appbar.dart';
import 'package:byourside/constants/pages.dart' as pages;
import 'package:byourside/constants/icons.dart' as custom_icons;
import 'package:byourside/constants/colors.dart' as colors;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // 진동을 사용하기 위한 패키지 추가
import 'package:get/get.dart';

class Mypage extends StatefulWidget {
  const Mypage({Key? key}) : super(key: key);
  final String title = '마이페이지';

  @override
  _MypageState createState() => _MypageState();
}

class _MypageState extends State<Mypage> {
  final UserController userController = Get.find<UserController>();

  double _deviceWidth = 0;
  double _deviceHeight = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        var mediaQuery = MediaQuery.of(context);
        _deviceWidth = mediaQuery.size.width;
        _deviceHeight = mediaQuery.size.height;
      });
    });
  }

  double getRelativeWidth(double value) {
    return _deviceWidth * value;
  }

  double getRelativeHeight(double value) {
    return _deviceHeight * value;
  }

  int calculateAge(int? birthYear) {
    if (birthYear == null || birthYear == 0) {
      return 0; 
    }
    var currentYear = DateTime.now().year;
    var age = currentYear - birthYear;
    return age;
  }

  void _handleIconPressed(BuildContext context) {
    HapticFeedback.lightImpact(); 
  }

  @override
  Widget build(BuildContext context) {
    var age = calculateAge(userController.userModel.birthYear);

    return Scaffold(
      appBar: titleOnlyAppbar(context, widget.title, showBackButton: false, backgroundColor: colors.appBarColor),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(getRelativeHeight(0.03)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: getRelativeHeight(0.02)),
                  child: Row(
                    children: [
                      Semantics(
                        label: '프로필 아이콘',
                        child: GestureDetector(
                          onTap: () => _handleIconPressed(context),
                          child: custom_icons.profile,
                        ),
                      ),
                      SizedBox(width: getRelativeWidth(0.03)),
                      if (userController.userModel.birthYear != null) 
                        Semantics(
                          label: '닉네임: ${userController.userModel.nickname}',
                          child: Text(
                            userController.userModel.nickname!,
                            style: TextStyle(
                              fontSize: getRelativeWidth(0.05),
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                if (age == 0) 
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    buildInfoContainer('거주지', userController.userModel.district!, _deviceWidth, _deviceHeight, 0.43),
                    buildInfoContainer('장애 유형', userController.userModel.disabilityType!, _deviceWidth, _deviceHeight, 0.43),
                  ],
                ),
                if (age != 0) 
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    buildInfoContainer('거주지', userController.userModel.district!, _deviceWidth, _deviceHeight, 0.28),
                    buildInfoContainer('나이', '$age살', _deviceWidth, _deviceHeight, 0.28),
                    buildInfoContainer('장애 유형', userController.userModel.disabilityType!, _deviceWidth, _deviceHeight, 0.28),
                  ],
                ),
                SizedBox(height: getRelativeHeight(0.04)),
                Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      myPageOptions(context, '내 활동', pages.myActivity),
                      SizedBox(height: getRelativeHeight(0.04)),
                      myPageOptions(context, '기타', pages.etc),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}