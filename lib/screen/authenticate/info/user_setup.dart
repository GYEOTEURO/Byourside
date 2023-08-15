import 'package:byourside/main.dart';
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
final List<bool> _selectedDegree = <bool>[false, false];

final TextEditingController _nickname = TextEditingController();
final TextEditingController _purpose = TextEditingController();
final TextEditingController _selfAge = TextEditingController();


class UserSetUp extends StatefulWidget {
  const UserSetUp({Key? key}) : super(key: key);

  @override
  State<UserSetUp> createState() => _UserSetUpState();
}

class _UserSetUpState extends State<UserSetUp> {
  bool nickNameExist = false;
  bool isNicknameChecked = false;
  bool isUserDataStored = false;
  int _selectedUserButtonIndex = 0;      
  String _selectedDisabilityType = '';
  String _selectedPurpose = '';
  
  final User? user = FirebaseAuth.instance.currentUser;

  void _handleUserButtonPressed(int index) {
    setState(() {
      _selectedUserButtonIndex = index;
    });
    // 여기에서 버튼을 눌렀을 때 수행할 로직 구현
  }

  Widget buildFloatingActionButton(BuildContext context) {
    return FloatingActionButton(
      onPressed: () async {
        HapticFeedback.lightImpact(); // 약한 진동
        if (_formKeySelf.currentState!.validate() &&
            _purpose.text != '' &&
            _selfAge.text.split(' ').first != '' ) {
          storeSelfInfo(
            _nickname.text,
            _selfAge.text,
            _purpose.text,
            _selectedType,
            _selectedDegree,
          );

          if (mounted) {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const BottomNavBar()));
          }
        }
      },
      backgroundColor: primaryColor,
      child: const Text(
        '완료',
        semanticsLabel: '완료',
        style: TextStyle(
          fontSize: 17,
          fontFamily: 'NanumGothic',
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget buildDisabilityType({required String initialType, required void Function(String type) onChanged}) {
    return DisabilityType(
      initialType: initialType,
      onChanged: onChanged,
    );
  }


  void storeSelfInfo(
    String? nickname,
    String? age,
    String? purpose,
    List<bool>? selectedType,
    List<bool>? selectedDegree,
  ) async {
    // image url 포함해 firestore에 document 저장
    FirebaseFirestore.instance.collection('user').doc(user!.uid).set({
      'nickname': nickname,
      'purpose': purpose,
      'age': age,
      'type': selectedType,
      'degree': selectedDegree,
      'groups': [],
      'profilePic': '',
      'blockList': [],
    });
    FirebaseFirestore.instance
        .collection('displayNameList')
        .doc('$nickname')
        .set({'current': true});
    await user?.updateDisplayName(nickname);
    if (user != null) {
      FirebaseUser(uid: user?.uid, displayName: nickname);
    }
  }


  void _handleDisabilityTypeSelected(String type) {
    setState(() {
      _selectedDisabilityType = type;
    });
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
                  const NicknameSection(),
                  const SizedBox(height: 20),
                  buildUserTypeButtons(_selectedUserButtonIndex, _handleUserButtonPressed),
                  const SizedBox(height: 20),
                  buildDisabilityType(
                    initialType: _selectedDisabilityType,
                    onChanged: _handleDisabilityTypeSelected,
                  ),
                  const SizedBox(height: 20),
                  AgeInputField(controller: _selfAge), 
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


Widget buildCompleteButton(BuildContext context) {
  return Container(
    alignment: Alignment.bottomCenter,
    padding: const EdgeInsets.symmetric(vertical: 20),
    child: ElevatedButton(
      onPressed: () async {
        HapticFeedback.lightImpact();
        // ... 기존 onPressed의 내용 ...
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
