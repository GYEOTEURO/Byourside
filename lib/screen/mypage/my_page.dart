import 'package:byourside/screen/authenticate/controller/user_controller.dart';
import 'package:byourside/screen/mypage/options.dart';
import 'package:byourside/widget/info_container.dart';
import 'package:byourside/widget/title_only_appbar.dart';
import 'package:byourside/constants/constants.dart' as constants;
import 'package:byourside/constants/icons.dart' as custom_icons;
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class Mypage extends StatefulWidget {
  const Mypage({Key? key}) : super(key: key);

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
    var currentYear = DateTime.now().year;
    var age = currentYear - (birthYear ?? 0);
    return age;
  }

  @override
  Widget build(BuildContext context) {
    var age = calculateAge(userController.userModel.birthYear);

    return Scaffold(
      appBar: titleOnlyAppbar(context, '마이페이지'),
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
                      custom_icons.profile,
                      SizedBox(width: getRelativeWidth(0.03)),
                      Text(
                        userController.userModel.nickname!,
                        style: TextStyle(
                          fontSize: getRelativeWidth(0.05),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    buildInfoContainer('거주지', userController.userModel.district!, _deviceWidth, _deviceHeight),
                    buildInfoContainer('나이', '$age살', _deviceWidth, _deviceHeight),
                    buildInfoContainer('장애 유형', userController.userModel.disabilityType!, _deviceWidth, _deviceHeight),
                  ],
                ),
                SizedBox(height: getRelativeHeight(0.04)),
                Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      myPageOptions(context, '내 활동', constants.myActivity),
                      SizedBox(height: getRelativeHeight(0.04)),
                      myPageOptions(context, '기타', constants.etc),
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
