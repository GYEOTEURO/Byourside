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
            HapticFeedback.lightImpact(); 
            Navigator.of(context).pop(true);
          },
        );
      },
    );
  }

  static bool validateInputs({
    required BuildContext context,
    required NicknameController nicknameController,
    required String selectedUserType,
    required String selectedDisabilityType,
    required String institutionName,
    required String birthYear,
    required Map<String, String>? location,
    required String selectedPurpose,
  }) {
    int currentYear = DateTime.now().year;
    int? birthYearValue = int.tryParse(birthYear);

    bool showErrorAndReturn(String errorMessage) {
      _showErrorDialog(context, errorMessage);
      return false;
    }

    if (nicknameController.controller.text.isEmpty) {
      return showErrorAndReturn(text.askNickName);
    }

    if (!nicknameController.isNicknameChecked.value || nicknameController.nickNameExist.value) {
      return showErrorAndReturn(text.askVerify);
    }

    if (nicknameController.controller.text != nicknameController.lastCheckedNickname.value) {
      return showErrorAndReturn(text.askVerify);
    }

    if (selectedUserType.isEmpty) {
      return showErrorAndReturn(text.askUserType);
    }

    if (selectedDisabilityType.isEmpty) {
      return showErrorAndReturn(text.askDisabilityType);
    }

    if (selectedUserType == text.worker && institutionName.isEmpty) {
      return showErrorAndReturn(text.institutionNameLabel);
    }

    if (birthYear.isNotEmpty) {
      if (birthYear.length != 4 ||
          int.tryParse(birthYear) == null ||
          birthYearValue! > currentYear ||
          birthYearValue < currentYear - 200) {
        return showErrorAndReturn(text.enterValidateAge);
      }
    }
    
    if (location == null || location.isEmpty) {
      return showErrorAndReturn(text.selectLocation);
    }

    if (selectedPurpose.isEmpty || selectedPurpose == text.askPurpose) {
      return showErrorAndReturn(text.askPurpose);
    }

    return true;
  }
}
