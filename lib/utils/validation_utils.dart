import 'package:byourside/model/authenticate/nickname_controller.dart';
import 'package:byourside/widget/alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ValidationUtils {
  static void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) {
        return CustomAlertDialog(
          message: message,
          buttonText: '확인',
          onPressed: () {
            HapticFeedback.lightImpact(); // 약한 진동
            Navigator.pop(context);
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
    Map<String, String> location,
    String selectedPurpose,
  ) {
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
    if (birthYear.isEmpty) {
      _showErrorDialog(context, '나이를 입력하세요');
      return false;
    }
    if (location.isEmpty) {
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