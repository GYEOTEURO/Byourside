import 'package:byourside/widget/common/report_only_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:byourside/constants/text.dart' as text;
import 'package:byourside/screen/authenticate/controller/nickname_controller.dart';

class ValidationUtils {
  static void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ReportOnlyAlert(
          message: message,
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
    String institutionName,
    String birthYear,
    Map<String, String>? location,
    String selectedPurpose,
  ) {
    int currentYear = DateTime.now().year;
    int? birthYearValue = int.tryParse(birthYear);

    if (nicknameController.controller.text.isEmpty) {
      _showErrorDialog(context, text.askNickName);
      return false;
    }
    if (!nicknameController.isNicknameChecked.value) {
      _showErrorDialog(context, text.askVerify);
      return false;
    } else if (nicknameController.nickNameExist.value) {
      _showErrorDialog(context, text.usedNickName);
      return false;
    } else if (nicknameController.controller.text != nicknameController.lastCheckedNickname.value) {
        _showErrorDialog(context, text.askVerify);
        return false;
    }
    if (selectedUserType.isEmpty) {
      _showErrorDialog(context, text.askUserType);
      return false;
    }
    if (selectedDisabilityType.isEmpty) {
      _showErrorDialog(context, text.askDisabilityType);
      return false;
    }
    if (selectedUserType == text.worker && institutionName.isEmpty) {
      _showErrorDialog(context, text.institutionNameLabel);
      return false;
    }
    if (birthYear.isEmpty) {
      _showErrorDialog(context, text.askUserAge);
      return false;
    } else if (birthYear.length != 4 || int.tryParse(birthYear) == null || birthYearValue! > currentYear || birthYearValue < currentYear - 200) {
      print( int.tryParse(birthYear) == null );
      _showErrorDialog(context, text.enterValidateAge);
      return false;
    }
    if (location == null || location.isEmpty) {
      _showErrorDialog(context, text.selectLocation);
      return false;
    }
    if (selectedPurpose.isEmpty) {
      _showErrorDialog(context, text.askPurpose);
      return false;
    }
    return true;
  }
}
