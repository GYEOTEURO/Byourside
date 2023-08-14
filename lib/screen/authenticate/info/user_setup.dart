import 'package:byourside/main.dart';
import 'package:byourside/model/firebase_user.dart';
import 'package:byourside/screen/bottom_nav_bar.dart';
import 'package:byourside/widget/alert_dialog.dart';
import 'package:byourside/widget/app_bar.dart';
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

const List<Widget> type = <Widget>[
  Text('뇌병변 장애', semanticsLabel: '뇌병변 장애', style: TextStyle(fontSize: 17)),
  Text('발달 장애', semanticsLabel: '발달 장애', style: TextStyle(fontSize: 17)),
  Text('해당없음', semanticsLabel: '해당없음', style: TextStyle(fontSize: 17))

];

class UserSetUp extends StatefulWidget {
  const UserSetUp({Key? key}) : super(key: key);

  @override
  State<UserSetUp> createState() => _UserSetUpState();
}

class _UserSetUpState extends State<UserSetUp> {
  bool nickNameExist = false;
  bool isNicknameChecked = false;
  bool someoneElse = false;
  bool isUserDataStored = false;
  bool isUserTypeSelected = false;      
  int _selectedDisabilityButtonIndex = 0;
  
  final User? user = FirebaseAuth.instance.currentUser;


  void _handleDisabilityButtonPressed(int index) {
    setState(() {
      _selectedDisabilityButtonIndex = index;
    });
    // 여기에서 버튼을 눌렀을 때 수행할 로직 구현
  }

  Future<void> checkNicknameExist(BuildContext context, String nickname) async {
    var collection = FirebaseFirestore.instance.collection('userInfo');
    var querySnapshot = await collection.where('nickname', isEqualTo: nickname).get();

    if (querySnapshot.docs.isNotEmpty) {
      setState(() {
        nickNameExist = true; 
      });
    } else {
      setState(() {
        nickNameExist = false; // 닉네임이 사용 가능함을 상태 변수에 표시
      });
    }
  }

  Future<void> showAlertDialog(BuildContext context, String contentText) async {
    await showDialog(
      context: context,
      builder: (context) {
        return CustomAlertDialog(
          message: contentText,
          buttonText: '확인',
        );
      },
    );
  }

  bool isNumeric(String s) {
    return double.tryParse(s) != null;
  }

  final nicknameField = Semantics(
      container: true,
      textField: true,
      label: '닉네임을 입력하세요.',
      hint: '(예: 홍길동)',
      child: TextFormField(
        decoration: const InputDecoration(
          labelText: '닉네임을 입력하세요',
          hintText: '(예: 홍길동) ',
        ),
        autofocus: true,
        controller: _nickname,
        validator: (value) {
          if (value != null) {
            for (int i = 0; i < value.length; i++) {
              if (value[i] == '_') {
                return '특수기호 _는 포함이 불가능합니다.';
              }
            }
            if (value.split(' ').first != '' && value.isNotEmpty) {
              return null;
            }
            return '필수 입력란입니다. 닉네임을 입력하세요';
          }
          return null;
        },
      ));

  Widget buildNicknameSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          nicknameField,
          ElevatedButton(
            onPressed: () {
              checkNicknameExist(context, _nickname.text);
              setState(() {
                isNicknameChecked = true;
              });
            },
            child: const Text('중복확인'),
          ),
          Text(
            isNicknameChecked
                ? nickNameExist
                    ? '이미 존재하는 닉네임입니다. 다른 닉네임을 사용하세요.'
                    : '사용가능한 닉네임입니다.'
                : '',
            style: TextStyle(
              color: nickNameExist ? Colors.red : Colors.green,
              fontFamily: 'NanumGothic',
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildFloatingActionButton(BuildContext context) {
    return FloatingActionButton(
      onPressed: () async {
        HapticFeedback.lightImpact(); // 약한 진동
        if (_formKeySelf.currentState!.validate() &&
            _purpose.text != '' &&
            _selfAge.text.split(' ').first != '' &&
            (_selectedType[0] || _selectedType[1])) {
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

  void onPressed() {
  // 버튼이 클릭되었을 때의 로직
  isUserTypeSelected = !isUserTypeSelected; // 버튼 상태 토글
  // 다른 로직 추가 가능
  }

  Widget buildUserTypeButtons(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            UserTypeButton.buildButton(context, '장애 아동 보호자', isUserTypeSelected, onPressed),
            UserTypeButton.buildButton(context, '장애인', isUserTypeSelected, onPressed),
            UserTypeButton.buildButton(context, '종사자', isUserTypeSelected, onPressed),
          ],
        ),
        const SizedBox(height: 20),
        UserTypeButton.buildNoOptionButton(context, isUserTypeSelected, onPressed),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget buildTypeButton(String text, bool isSelected, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(isSelected ? Colors.blue : Colors.white),
        foregroundColor: MaterialStateProperty.all(isSelected ? Colors.white : Colors.blue),
        side: MaterialStateProperty.all(BorderSide(color: isSelected ? Colors.white : Colors.blue)),
      ),
      child: Text(text),
    );
  }

  Widget buildDisabilityTypeButtons(int selectedIndex, Function(int) onButtonPressed) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal, // 가로 스크롤 가능하도록 변경
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          buildTypeButton('뇌병변 장애', selectedIndex == 0, () => onButtonPressed(0)),
          buildTypeButton('발달 장애', selectedIndex == 1, () => onButtonPressed(1)),
          buildTypeButton('해당없음', selectedIndex == 2, () => onButtonPressed(2)),
        ],
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
      appBar: CustomAppBar(
        title: '세부 정보 입력',
        onBack: () {
          Navigator.pop(context);
        },
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20), // 추가적인 공간 확보
            buildNicknameSection(context),
            const SizedBox(height: 20), // 추가적인 공간 확보
            buildUserTypeButtons(context),
            const SizedBox(height: 20), // 추가적인 공간 확보
            buildDisabilityTypeButtons(_selectedDisabilityButtonIndex, _handleDisabilityButtonPressed),
            const SizedBox(height: 20), // 추가적인 공간 확보
          ],
        ),
      ),
    floatingActionButton: buildFloatingActionButton(context));
  }
}
