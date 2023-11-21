import 'package:byourside/widget/authenticate/setup/institution_name_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:byourside/constants/text.dart' as text;
import 'package:byourside/utils/validation_utils.dart';
import 'package:byourside/widget/complete_button.dart';
import 'package:byourside/widget/common/title_only_appbar.dart';
import 'package:byourside/widget/location/location_section.dart';
import 'package:byourside/model/authenticate/save_user_data.dart';
import 'package:byourside/widget/authenticate/setup/age_section.dart';
import 'package:byourside/widget/authenticate/setup/purpose_select.dart';
import 'package:byourside/widget/authenticate/setup/nickname_section.dart';
import 'package:byourside/screen/authenticate/controller/auth_controller.dart';
import 'package:byourside/widget/authenticate/setup/disability_type_button.dart';
import 'package:byourside/screen/authenticate/controller/nickname_controller.dart';
import 'package:byourside/widget/authenticate/setup/user_type/user_type_selection.dart';
import 'package:byourside/constants/colors.dart' as colors;

class SetupUser extends StatefulWidget {
  const SetupUser({Key? key}) : super(key: key);

  @override
  State<SetupUser> createState() => _SetupUserState();
}

class _SetupUserState extends State<SetupUser> {
  final TextEditingController _birthYear = TextEditingController();
  final NicknameController _nicknameController = Get.find<NicknameController>();
  final TextEditingController _institutionNameController = TextEditingController();
  Map<String, String>? location;
  String _selectedUserType = '';
  String _selectedDisabilityType = '';
  String _selectedPurpose = '';
  Map<String, dynamic>? pushMessage;

  final User? user = FirebaseAuth.instance.currentUser;

  Future<Map<String, dynamic>> _getPushMessageInfo() async {
    Map<String, dynamic>? pushMessageInfo = {
      'deviceToken': await FirebaseMessaging.instance.getToken(),
      'tokenCreatedAt': Timestamp.now(),
    };

    return pushMessageInfo;
  }

  void _handleUserTypeSelected(String userType) {
    setState(() {
      _selectedUserType = userType;
    });
  }

  void onLocationChanged(Map<String, String>? newLocation) {
    setState(() {
      location = newLocation;
    });
  }

  void _handleLocationSelected(String selectedArea, String selectedDistrict) {
    Map<String, String> locationInfo = {
      'area': selectedArea,
      'district': selectedDistrict,
    };

    onLocationChanged(locationInfo); 
  }

  void _handleDisabilityTypeSelected(String type) {
    setState(() {
      _selectedDisabilityType = type;
    });
  }

  void _onCompleteButtonPressed(BuildContext context) async {
    HapticFeedback.lightImpact();
    var age = int.tryParse(_birthYear.text) ?? 0;
    var inputsValid = _validateInputs();
    pushMessage = await _getPushMessageInfo();

    if (inputsValid) {
      SaveUserData.saveUserInfo(
        birthYear: age,
        disabilityType: _selectedDisabilityType,
        institutionName: _institutionNameController.text,
        location: location,
        nickname: _nicknameController.controller.text,
        registrationPurpose: _selectedPurpose,
        userType: _selectedUserType,
        pushMessage: pushMessage,
      );

      AuthController.instance.handleUserInfoCompletion();
    }
  }

  bool _validateInputs() {
    
    return ValidationUtils.validateInputs(
      context,
      _nicknameController,
      _selectedUserType,
      _selectedDisabilityType,
      _institutionNameController.text,
      _birthYear.text,
      location,
      _selectedPurpose,
    );
  }

  

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: text.setupTitle,
      child: Scaffold(
        appBar: titleOnlyAppbar(context, text.setupTitle, showBackButton: false, backgroundColor: colors.appBarColor),
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const NicknameSection(),
                    UserTypeSelection(
                      selectedType: _selectedUserType,
                      onTypeSelected: _handleUserTypeSelected,
                    ),
                    DisabilityType(
                      initialType: _selectedDisabilityType,
                      onChanged: _handleDisabilityTypeSelected,
                    ),
                    (_selectedUserType == text.worker)
                        ? Align(
                            alignment: Alignment.centerLeft, 
                            child: InstitutionNameTextField(
                              controller: _institutionNameController,
                              onTap: () {
                                HapticFeedback.lightImpact();
                              },
                            ),
                          )
                        : const SizedBox.shrink(),
                    AgeSection(
                      selectedType: _selectedUserType,
                      controller: _birthYear,
                    ),
                    LocationSection(onLocationSelected: _handleLocationSelected),
                    AppPurposeSelection(
                      onChanged: (purpose) {
                        setState(() {
                          _selectedPurpose = purpose;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
            CompleteButton(
              onPressed: () => _onCompleteButtonPressed(context),
              text: text.start,
            ),
          ],
        ),
      ),
    );
  }
}
