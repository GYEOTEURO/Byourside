import 'package:byourside/screen/authenticate/controller/user_controller.dart';
import 'package:byourside/screen/mypage/options.dart';
import 'package:byourside/widget/title_only_appbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:byourside/constants/constants.dart' as constants;
import 'package:byourside/constants/icons.dart' as custom_icons;
import 'package:get/get.dart';


class Mypage extends StatefulWidget {
  const Mypage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _Mypage();
  }
}

class _Mypage extends State<Mypage> {
  final UserController userController = Get.find<UserController>(); // Get the UserController instance

  late String uid;
  late String displayName;
  User? user;
  
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
    var age = currentYear - birthYear!;
    return age;
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: titleOnlyAppbar(context, '마이페이지'),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(getRelativeHeight(0.02)), 
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center, 
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: getRelativeHeight(0.02)), // Add padding to the first Row
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
                // Second Row for displaying district, birthYear, and disabilityType
                Row(
                  mainAxisAlignment: MainAxisAlignment.center, // Align the new Row horizontally
                  children: [
                    Text(
                      userController.userModel.district!,
                      style: TextStyle(
                            fontSize: getRelativeWidth(0.045),
                            fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(width: getRelativeWidth(0.03)),
                    Text(
                      calculateAge(userController.userModel.birthYear) as String,
                      style: TextStyle(
                            fontSize: getRelativeWidth(0.045),
                            fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(width: getRelativeWidth(0.03)),
                    Text(
                      userController.userModel.disabilityType!,
                      style: TextStyle(
                            fontSize: getRelativeWidth(0.045),
                            fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                // No padding for items below the Rows
                myPageOptions(context, '내 활동', constants.myActivity),
                SizedBox(height: getRelativeHeight(0.04)),
                myPageOptions(context, '기타', constants.etc),
              ],
            ),
          ),
        ),
      ),
    );
  }
}