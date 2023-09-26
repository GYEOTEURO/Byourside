import 'package:byourside/screen/authenticate/controller/auth_controller.dart';
import 'package:byourside/widget/common/delete_report_block_alert.dart';
import 'package:byourside/widget/common/title_only_appbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:byourside/constants/colors.dart' as colors;
import 'package:byourside/constants/fonts.dart' as fonts;

Future<bool> showDeleteConfirmationDialog(BuildContext context) async {
  return await showDialog(
    context: context,
    builder: (context) => DeleteReportBlockAlert(
        message: '서비스를 탈퇴 하시겠습니까?',
        subMessage: '탈퇴 시, 계정은 삭제되며 복구되지 않습니다.',
        buttonText: '탈퇴하기',
        onPressed: () => Navigator.of(context).pop(true),
    ),
  );
}


void handleDeleteAction(BuildContext context) async {
  AuthController authController = AuthController.instance;
  bool confirmDelete = await showDeleteConfirmationDialog(context);

  if (confirmDelete) {
    CollectionReference userInfo = FirebaseFirestore.instance.collection('userInfo');
    User? user = FirebaseAuth.instance.currentUser;
    
    if (user != null) {
      userInfo.doc(user.uid).delete();
      authController.deleteUser(); 
    }
  }
}

class Setting extends StatefulWidget {
  const Setting({
    Key? key,
    required this.options
  }) : super(key: key);

  final String title = '설정';

  final List<Map<String, dynamic>> options;

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: titleOnlyAppbar(context, widget.title),
      body: Column(
            children: [
              for(int i = 0; i < widget.options.length; i++)
              Column(
                children: [
                OutlinedButton(
                  onPressed: () {
                    HapticFeedback.lightImpact(); 
                    if (widget.options[i].containsKey('action')) {
                      widget.options[i]['action'](context);
                    }
                    if (widget.options[i].containsKey('page')) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => widget.options[i]['page'],
                        ),
                      );
                    }
                  },
                  style: OutlinedButton.styleFrom(
                    minimumSize: Size(MediaQuery.of(context).size.width, MediaQuery.of(context).size.height / 15.5),
                    elevation: 0,
                    side: const BorderSide(color: Colors.white),
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      widget.options[i]['name'],
                      style: const TextStyle(
                        color: colors.textColor,
                        fontSize: 15,
                        fontFamily: fonts.font,
                        fontWeight: FontWeight.w400
                      ),
                    )
                )),
                const Divider(color: colors.bgrColor, thickness: 1)
                ])
          ])
    );
      
  }
}

