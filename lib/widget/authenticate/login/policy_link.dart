import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:byourside/constants/colors.dart' as colors;
import 'package:byourside/constants/fonts.dart' as fonts;
import 'package:byourside/screen/authenticate/policy.dart';

class PolicyLink extends StatelessWidget {
  final String text;
  final Map<String, String> policyPath;
  final Widget icon;

  const PolicyLink({
    Key? key,
    required this.text,
    required this.policyPath,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var deviceHeight = MediaQuery.of(context).size.height;
    var marginValue = deviceHeight * 0.004;

    return TextButton(
      onPressed: () {
        // 경로로 이동하는 로직을 추가
        Get.to(() => Policy(policy: policyPath));
      },
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero,
      ),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(bottom: marginValue),
            child: Text(
              text,
              style: TextStyle(
                fontFamily: fonts.font,
                fontSize: deviceHeight * 0.018,
                color: colors.textColor,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          icon,
        ],
      ),
    );
  }
}
