import 'package:byourside/model/firebase_user.dart';
import 'package:byourside/screen/bottom_nav_bar.dart';
import 'package:byourside/widget/app_bar.dart';
import 'package:byourside/widget/authenticate/age_input_field.dart';
import 'package:byourside/widget/authenticate/disability_type_button.dart';
import 'package:byourside/widget/authenticate/nickname_widgets.dart';
import 'package:byourside/widget/authenticate/purpose_select.dart';
import 'package:byourside/widget/authenticate/user_type_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

GlobalKey<FormState> _formKeySelf = GlobalKey<FormState>();
final List<bool> _selectedType = <bool>[false, false];

final TextEditingController _nickname = TextEditingController();
final TextEditingController _purpose = TextEditingController();
final TextEditingController _birthYear = TextEditingController();


class UserSetUp extends StatefulWidget {
  const UserSetUp({Key? key}) : super(key: key);

  @override
  State<UserSetUp> createState() => _UserSetUpState();
}

class _UserSetUpState extends State<UserSetUp> {
  bool nickNameExist = false;
  bool isNicknameChecked = false;
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
    // List<Map>? location,
    String? nickname,
    String? registrationPurpose,
    String? userType,
  ) async {
    FirebaseFirestore.instance.collection('userInfo').doc(user!.uid).set({
      'birthYear': birthYear,
      'blockedUsers': [],
      'disabilityType': selectedType,
      'location': [], // location,
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
          if (_formKeySelf.currentState!.validate() &&
              _nickname.text != '' &&
              _selectedPurpose != '' &&
              _birthYear.text.split(' ').first != '' ) {
            storeSelfInfo(
              _birthYear.text,
              _selectedDisabilityType,
              _nickname.text,
              _selectedPurpose,
              _selectedUserType,
            );

            if (mounted) {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const BottomNavBar()));
            }
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
                  NicknameSection(
                    onChanged: (nickname) {
                      // 사용자의 닉네임 업데이트
                      _nickname.text = nickname;
                    },
                  ),
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
                  AgeInputField(controller: _birthYear), 
                  const SizedBox(height: 20),
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
