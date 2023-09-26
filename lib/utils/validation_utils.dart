import 'package:byourside/screen/authenticate/controller/nickname_controller.dart';
import 'package:byourside/widget/common/delete_report_block_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ValidationUtils {
  static void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return DeleteReportBlockAlert(
          message: message,
          subMessage: '',
          buttonText: '확인',
          onPressed: () {
            HapticFeedback.lightImpact(); // 약한 진동
            Navigator.of(context).pop(true);
          }, 
        );
      },
    );
  }
  
  static bool validateInputs(
    BuildContext context,
    NicknameController nicknameController,
    String selectedUserType,
    String selectedDisabilityType,
    String birthYear,
    Map<String, String>? location,
    String selectedPurpose,
  ) {
    print(location);
    if (nicknameController.controller.text.isEmpty) {
      _showErrorDialog(context, '닉네임을 입력하세요.');
      return false;
    }
    if (!nicknameController.isNicknameChecked.value) {
      _showErrorDialog(context, '닉네임 중복을 확인하세요.');
      return false;
    } else if (nicknameController.nickNameExist.value) {
      _showErrorDialog(context, '이미 존재하는 닉네임입니다. 다른 닉네임을 사용하세요.');
      return false;
    }
    if (selectedUserType.isEmpty) {
      _showErrorDialog(context, '사용자 유형을 선택하세요.');
      return false;
    }
    if (selectedDisabilityType.isEmpty) {
      _showErrorDialog(context, '장애 유형을 선택하세요.');
      return false;
    }
    if (birthYear.isEmpty || birthYear.length != 4 || int.tryParse(birthYear) == null) {
      _showErrorDialog(context, '나이를 입력하세요');
      return false;
    }
    if (location == null || location.isEmpty) { 
      _showErrorDialog(context, '위치를 선택하세요');
      return false;
    }
    if (selectedPurpose.isEmpty) {
      _showErrorDialog(context, '어플 사용 목적을 선택하세요.');
      return false;
    }
    return true;
  }
}
