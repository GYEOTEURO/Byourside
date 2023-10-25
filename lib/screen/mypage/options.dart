import 'package:byourside/screen/authenticate/controller/auth_controller.dart';
import 'package:byourside/widget/common/delete_report_block_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:byourside/constants/colors.dart' as colors;
import 'package:byourside/constants/fonts.dart' as fonts;

Future<bool> showLogoutConfirmationDialog(BuildContext context) async {
  return await showDialog(
    context: context,
    builder: (BuildContext context) {
      return DeleteReportBlockAlert(
        message: '로그아웃 하시겠습니까?',
        subMessage: '',
        buttonText: '로그아웃',
        onPressed: () => Navigator.of(context).pop(true),
      );
    },
  );
}


Future<void> handleLogoutAction(BuildContext context) async {
  AuthController authController = AuthController.instance;
  bool confirmLogout = await showLogoutConfirmationDialog(context);

  if (confirmLogout) {
    authController.logout();
  }
}


Widget myPageOptions(BuildContext context, String optionName, List<Map<String, dynamic>> options) {
  return Column(
    children: [
      Container(
        width: MediaQuery.of(context).size.width * 0.9,
        alignment: Alignment.centerLeft,
        child: Text(
          optionName,
          style: const TextStyle(
              color: colors.textColor,
              fontSize: 15,
              fontFamily: fonts.font,
              fontWeight: FontWeight.w700,
            ),
          ), 
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.01),
        for(int i = 0; i < options.length; i++)
          OutlinedButton(
              onPressed: () {
                HapticFeedback.lightImpact(); // 약한 진동
                if (options[i].containsKey('action')) {
                options[i]['action'](context);
              }
              if (options[i].containsKey('page')) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => options[i]['page'],
                  ),
                );
              }
            },
            style: OutlinedButton.styleFrom(
              elevation: 0,
              minimumSize: Size.fromHeight(MediaQuery.of(context).size.height * 0.07),
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                side: const BorderSide(width: 0.50, color: colors.subColor),
                borderRadius: BorderRadius.circular(10),
              )
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                options[i]['name'],
                style: const TextStyle(
                  color: colors.textColor,
                  fontSize: 15,
                  fontFamily: fonts.font,
                  fontWeight: FontWeight.w400,
                ),
              )
          ))
        ]);
}
