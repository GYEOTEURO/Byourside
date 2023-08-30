import 'package:byourside/screen/authenticate/controller/auth_controller.dart';
import 'package:byourside/screen/authenticate/controller/nickname_controller.dart';
import 'package:byourside/model/authenticate/save_user_data.dart';
import 'package:byourside/utils/validation_utils.dart';
import 'package:byourside/widget/app_bar.dart';
import 'package:byourside/widget/authenticate/setup/age_section.dart';
import 'package:byourside/widget/authenticate/setup/disability_type_button.dart';
import 'package:byourside/widget/authenticate/setup/location_section.dart';
import 'package:byourside/widget/authenticate/setup/nickname_section.dart';
import 'package:byourside/widget/authenticate/setup/purpose_select.dart';
import 'package:byourside/widget/authenticate/setup/user_type_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';


final TextEditingController _birthYear = TextEditingController();

class SetupUser extends StatefulWidget {
  const SetupUser({Key? key}) : super(key: key);

  @override
  State<SetupUser> createState() => _SetupUserState();
}

class _SetupUserState extends State<SetupUser> {
  final NicknameController _nicknameController = Get.find<NicknameController>();
  Map<String, String>? location; 
  bool isUserDataStored = false;
  String _selectedUserType = '';
  String _selectedDisabilityType = '';
  String _selectedPurpose = '';
  
  final User? user = FirebaseAuth.instance.currentUser;


  void _handleUserTypeSelected(String userType) {
    setState(() {
      _selectedUserType = userType;
    });
  }

  void _handleLocationSelected(String selectedArea, String selectedDistrict) {
    Map<String, String> locationInfo = {
      'area': selectedArea,
      'district': selectedDistrict,
    };

    setState(() {
      location = locationInfo; 
    });
  }

  void _handleDisabilityTypeSelected(String type) {
    setState(() {
      _selectedDisabilityType = type;
    });
  }


  void _onCompleteButtonPressed(BuildContext context) async {
    HapticFeedback.lightImpact(); 
    if (ValidationUtils.validateInputs(context, _nicknameController,_selectedUserType, _selectedDisabilityType, _birthYear.text, location, _selectedPurpose)) {
      SaveUserData.saveUserInfo(
        birthYear: _birthYear.text,
        selectedType: _selectedDisabilityType,
        location: location,
        nickname: _nicknameController.controller.text,
        registrationPurpose: _selectedPurpose,
        userType: _selectedUserType,
      );
      AuthController.instance.handleUserInfoCompletion();
    }
  }

  Widget _buildButtonDesign(BuildContext context) {
    return ElevatedButton(
      onPressed: () => _onCompleteButtonPressed(context),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 40),
        textStyle: const TextStyle(
          fontSize: 17,
          fontFamily: 'NanumGothic',
          fontWeight: FontWeight.w500,
        ),
      ),
      child: const Text(
        '완료',
        semanticsLabel: '완료',
      ),
    );
  }

  Widget buildCompleteButton(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: _buildButtonDesign(context),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: '프로필을 완성해주세요',
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  NicknameSection(),  
                  const SizedBox(height: 20),
                  UserTypeSelection(
                    selectedType: _selectedUserType,
                    onTypeSelected: _handleUserTypeSelected,
                  ),
                  const SizedBox(height: 20),
                   DisabilityType(
                    initialType: _selectedDisabilityType,
                    onChanged: _handleDisabilityTypeSelected,
                  ),
                  const SizedBox(height: 20),
                  AgeSection(controller: _birthYear), 
                  const SizedBox(height: 20),
                  LocationSection(onLocationSelected: _handleLocationSelected),
                  const SizedBox(height: 20,),
                  AppPurposeSelection(
                    onChanged: (purpose) {
                      setState(() {
                        _selectedPurpose = purpose; // 선택한 목적 업데이트
                      });
                    }
                  ),
                ],
              ),
            ),
          ),
          buildCompleteButton(context),
        ],
      ),
    );
  }
}
