import 'package:byourside/main.dart';
import 'package:byourside/model/firebase_user.dart';
import 'package:byourside/screen/bottom_nav_bar.dart';
import 'package:byourside/widget/app_bar.dart';
import 'package:byourside/widget/authenticate/disability_type_button.dart';
import 'package:byourside/widget/authenticate/nickname_widgets.dart';
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
  int _selectedDisabilityButtonIndex = 0;
  
  final User? user = FirebaseAuth.instance.currentUser;

  void _handleUserButtonPressed(int index) {
    setState(() {
      _selectedUserButtonIndex = index;
    });
    // 여기에서 버튼을 눌렀을 때 수행할 로직 구현
  }

  void _handleDisabilityButtonPressed(int index) {
    setState(() {
      _selectedDisabilityButtonIndex = index;
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
                  buildDisabilityTypeButtons(_selectedDisabilityButtonIndex, _handleDisabilityButtonPressed),
                  const SizedBox(height: 20),
                  buildAgeInputField(),
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
Widget buildAgeInputField() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text(
        '나이를 입력해 주세요',
        style: TextStyle(
          fontSize: 14,
          color: Colors.grey,
        ),
      ),
      Row(
        children: [
          Flexible(
            child: Semantics(
              container: true,
              textField: true,
              label: '몇 년생인지 입력하세요.',
              hint: '(예: 1990)',
              child: TextFormField(
                decoration: const InputDecoration(
                  hintText: '1990',
                ),
                keyboardType: TextInputType.number,
                // ... 텍스트필드 관련 설정 및 검증 로직 ...
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Text('년생'),
          ),
        ],
      ),
    ],
  );
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
