import 'package:byourside/screen/authenticate/controller/user_controller.dart';
import 'package:byourside/screen/mypage/options.dart';
import 'package:byourside/widget/title_only_appbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:byourside/constants/colors.dart' as colors;
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
  Widget buildInfoContainer(String labelText, String valueText) {
    double containerHeight = getRelativeHeight(0.06); 
    double containerWidth = getRelativeWidth(0.28); 

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelText,
          style: TextStyle(
            fontSize: getRelativeWidth(0.035),
            fontWeight: FontWeight.w400,
            color: colors.subColor,
          ),
        ),
        SizedBox(height: getRelativeHeight(0.01)),
        Container(
          width: containerWidth,
          height: containerHeight,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: colors.primaryColor),
          ),
          child: Center( // Center widget to horizontally and vertically center the text
            child: Text(
              valueText,
              style: TextStyle(
                fontSize: getRelativeWidth(0.036),
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
      ],
    );
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
                  buildInfoContainer('거주지', userController.userModel.district!),
                  buildInfoContainer('나이', '$age살'),
                  buildInfoContainer('장애 유형', userController.userModel.disabilityType!),
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}