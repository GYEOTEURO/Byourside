import 'package:byourside/model/authenticate/firebase_user.dart';
import 'package:byourside/model/authenticate/nickname_controller.dart';
import 'package:byourside/widget/alert_dialog.dart';
import 'package:byourside/widget/app_bar.dart';
import 'package:byourside/widget/authenticate/age_section.dart';
import 'package:byourside/widget/authenticate/disability_type_button.dart';
import 'package:byourside/widget/authenticate/location_section.dart';
import 'package:byourside/widget/authenticate/nickname_section.dart';
import 'package:byourside/widget/authenticate/purpose_select.dart';
import 'package:byourside/widget/authenticate/user_type_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
  List<Map> location = []; 
  bool isUserDataStored = false;
  String _selectedUserType = '';
  String _selectedDisabilityType = '';
  String _selectedPurpose = '';
  
  final User? user = FirebaseAuth.instance.currentUser;


  void _handleUserTypeSelected(String userType) {
    setState(() {
      _selectedUserType = userType;
    });
    // 선택된 사용자 유형에 대한 로직
  }

  void _handleLocationSelected(String selectedArea, String selectedDistrict) {
    Map<String, String> locationInfo = {
      'area': selectedArea,
      'district': selectedDistrict,
    };

    setState(() {
      location= locationInfo as List<Map>; 
    });
  }


  Widget buildDisabilityType({required String initialType, required void Function(String type) onChanged}) {
    return DisabilityType(
      initialType: initialType,
      onChanged: onChanged,
    );
  }

  void _handleDisabilityTypeSelected(String type) {
    setState(() {
      _selectedDisabilityType = type;
    });
  }

    void storeSelfInfo(
    String? birthYear,
    String? selectedType,
    List<Map>? location,
    String? nickname,
    String? registrationPurpose,
    String? userType,
  ) async {
    FirebaseFirestore.instance.collection('userInfo').doc(user!.uid).set({
      'birthYear': birthYear,
      'blockedUsers': [],
      'disabilityType': selectedType,
      'location': location, 
      'nickname': nickname,
      'registrationPurpose': registrationPurpose,
      'userType': userType,
    });

    if (user != null) {
      FirebaseUser(uid: user?.uid, displayName: nickname);
    }
  }

  Widget buildCompleteButton(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: ElevatedButton(
        onPressed: () async {
          HapticFeedback.lightImpact(); // 약한 진동
            if (_validateInputs()) { // 입력 값 유효성 검사
            storeSelfInfo(
              _birthYear.text,
              _selectedDisabilityType,
              location,
              _nicknameController.controller.text,
              _selectedPurpose,
              _selectedUserType,
            );
          }
        },
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
      ),
    );
  }
  
  // TODO: 조건 추가 필요

  bool _validateInputs() {
    if (_nicknameController.controller.text.isEmpty) {
      _showErrorDialog('닉네임을 입력하세요.');
      return false;
    }
    if (!_nicknameController.isNicknameChecked.value) {
      _showErrorDialog('닉네임 중복을 확인하세요.');
      return false;
    } else if (_nicknameController.nickNameExist.value) {
      _showErrorDialog('이미 존재하는 닉네임입니다. 다른 닉네임을 사용하세요.');
      return false;
    }
    if (_selectedUserType.isEmpty) {
      _showErrorDialog('사용자 유형을 선택하세요.');
      return false;
    }
    if (_selectedDisabilityType.isEmpty) {
      _showErrorDialog('장애 유형을 선택하세요.');
      return false;
    }
    if (_birthYear.text.isEmpty) {
      _showErrorDialog('나이를 입력하세요');
      return false;
    }
    if (location.isEmpty) {
      _showErrorDialog('위치를 선택하세요');
      return false;
    }
    if (_selectedPurpose.isEmpty) {
      _showErrorDialog('어플 사용 목적을 선택하세요.');
      return false;
    }
    return true;
  }

  void _showErrorDialog(String message) {
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
                  buildDisabilityType(
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