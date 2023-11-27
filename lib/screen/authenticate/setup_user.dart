import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:byourside/constants/text.dart' as text;
import 'package:byourside/constants/colors.dart' as colors;
import 'package:byourside/utils/validation_utils.dart';
import 'package:byourside/widget/complete_button.dart';
import 'package:byourside/widget/common/title_only_appbar.dart';
import 'package:byourside/widget/location/location_section.dart';
import 'package:byourside/model/authenticate/save_user_data.dart';
import 'package:byourside/widget/authenticate/setup/age_section.dart';
import 'package:byourside/widget/authenticate/setup/purpose_select.dart';
import 'package:byourside/widget/authenticate/setup/nickname_section.dart';
import 'package:byourside/screen/authenticate/controller/auth_controller.dart';
import 'package:byourside/widget/authenticate/setup/institution_name_field.dart';
import 'package:byourside/widget/authenticate/setup/disability_type_button.dart';
import 'package:byourside/screen/authenticate/controller/nickname_controller.dart';
import 'package:byourside/widget/authenticate/setup/user_type/user_type_selection.dart';

class SetupUser extends StatefulWidget {
  const SetupUser({Key? key}) : super(key: key);

  @override
  State<SetupUser> createState() => _SetupUserState();
}

class _SetupUserState extends State<SetupUser> {
  final TextEditingController birthYearController = TextEditingController();
  final TextEditingController institutionNameController = TextEditingController();
  final NicknameController nicknameController = Get.find<NicknameController>();

  Map<String, String>? location;

  String selectedUserType = '';
  String selectedDisabilityType = '';
  String selectedPurpose = '';

  final User? user = FirebaseAuth.instance.currentUser;

  @override
  void dispose() {
    birthYearController.dispose();
    institutionNameController.dispose();
    super.dispose();
  }

  void handleUserTypeSelected(String userType) {
    _updateState(() {
      selectedUserType = userType;
    });
  }

  void onLocationChanged(Map<String, String>? newLocation) {
    _updateState(() {
      location = newLocation;
    });
  }

  void handleDisabilityTypeSelected(String type) {
    _updateState(() {
      selectedDisabilityType = type;
    });
  }

  void onCompleteButtonPressed(BuildContext context) async {
    HapticFeedback.lightImpact();
    var age = int.tryParse(birthYearController.text) ?? 0;
    var inputsValid = validateInputs();

    if (inputsValid) {
      SaveUserData.saveUserInfo(
        birthYear: age,
        disabilityType: selectedDisabilityType,
        institutionName: institutionNameController.text,
        location: location,
        nickname: nicknameController.controller.text,
        registrationPurpose: selectedPurpose,
        userType: selectedUserType,
      );

      AuthController.instance.handleUserInfoCompletion();
    }
  }

  bool validateInputs() {
    return ValidationUtils.validateInputs(
      context: context,
      nicknameController: nicknameController,
      selectedUserType: selectedUserType,
      selectedDisabilityType: selectedDisabilityType,
      institutionName: institutionNameController.text,
      birthYear: birthYearController.text,
      location: location,
      selectedPurpose: selectedPurpose,
    );
  }

  void handleLocationSelected(String selectedArea, String selectedDistrict) {
    Map<String, String> locationInfo = {
      'area': selectedArea,
      'district': selectedDistrict,
    };

    onLocationChanged(locationInfo);
  }

  void _updateState(void Function() update) {
    setState(update);
  }

  Widget buildScaffoldBody(BuildContext context) {
    return Semantics(
      label: text.setupTitle,
      child: Scaffold(
        appBar: titleOnlyAppbar(
          context,
          text.setupTitle,
          showBackButton: false,
          backgroundColor: colors.appBarColor,
        ),
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
                      selectedType: selectedUserType,
                      onTypeSelected: handleUserTypeSelected,
                    ),
                    DisabilityType(
                      initialType: selectedDisabilityType,
                      onChanged: handleDisabilityTypeSelected,
                    ),
                    if (selectedUserType == text.worker)
                      Align(
                        alignment: Alignment.centerLeft,
                        child: InstitutionNameTextField(
                          controller: institutionNameController,
                          onTap: () {
                            HapticFeedback.lightImpact();
                          },
                        ),
                      ),
                    AgeSection(
                      selectedType: selectedUserType,
                      controller: birthYearController,
                    ),
                    LocationSection(onLocationSelected: handleLocationSelected),
                    AppPurposeSelection(
                      onChanged: (purpose) {
                        _updateState(() {
                          selectedPurpose = purpose;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
            CompleteButton(
              onPressed: () => onCompleteButtonPressed(context),
              text: text.start,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return buildScaffoldBody(context);
  }
}
