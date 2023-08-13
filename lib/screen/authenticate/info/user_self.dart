import 'package:byourside/main.dart';
import 'package:byourside/model/firebase_user.dart';
import 'package:byourside/screen/bottom_nav_bar.dart';
import 'package:byourside/widget/alert_dialog.dart';
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
  Text('발달 장애', semanticsLabel: '발달 장애', style: TextStyle(fontSize: 17))
];

class Self extends StatefulWidget {
  const Self({Key? key}) : super(key: key);

  @override
  State<Self> createState() => SelfState();
}

class SelfState extends State<Self> {
  bool nickNameExist = true;
  final User? user = FirebaseAuth.instance.currentUser;
  bool someoneElse = false;
  bool isUserDataStored = false;


  Future<void> checkNicknameExist(BuildContext context, String nickname) async {
    var collection = FirebaseFirestore.instance.collection('displayNameList');
    var querySnapshot = await collection.where('nickname', isEqualTo: nickname).get();

    if (querySnapshot.docs.isNotEmpty) {
      showAlertDialog(context, '이미 존재하는 닉네임입니다. 다른 닉네임을 사용하세요.');
    } else {
      showAlertDialog(context, '사용가능한 닉네임입니다.');
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


  final someoneElseField = Semantics(
      container: true,
      textField: true,
      label: '방문 목적',
      hint: '(예: 자녀 장애 초기증상 판별)',
      child: TextFormField(
        decoration: const InputDecoration(
          labelText: '방문 목적',
          hintText: '(예: 자녀 장애 초기증상 판별)',
        ),
        controller: _purpose,
        validator: (value) {
          if (value != null) {
            if (value.split(' ').first != '' && value.isNotEmpty) {
              return null;
            }
            return '필수 입력란입니다. 방문 목적을 입력하세요';
          }
          return null;
        },
      ));

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
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          title: const Text('세부 정보 입력',
              semanticsLabel: '세부 정보 입력',
              style: TextStyle(
                  fontFamily: 'NanumGothic', fontWeight: FontWeight.bold)),
          backgroundColor: Theme.of(context).primaryColor,
          leading: IconButton(
              icon: const Icon(Icons.arrow_back,
                  semanticLabel: '뒤로 가기', color: Colors.white),
              onPressed: () {
                Navigator.pop(context);
              }),
        ),
        body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(children: [
              Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                
                Form(
                  key: _formKeySelf,
                  child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            nicknameField,
                            ElevatedButton(
                              onPressed: () {
                                checkNicknameExist(context, _nickname.text);
                              },
                              child: const Text('중복확인'),
                            ),
                            someoneElseField,
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    '장애 유형',
                                    semanticsLabel: '장애 유형',
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontFamily: 'NanumGothic',
                                        fontWeight: FontWeight.w500),
                                  ),
                                  const SizedBox(
                                    width: 30,
                                  ),
                                  ToggleButtons(
                                    direction: Axis.horizontal,
                                    onPressed: (int index) {
                                      HapticFeedback.lightImpact(); // 약한 진동
                                      setState(() {
                                        _selectedType[index] = true;
                                        _selectedType[(1 - index).abs()] =
                                            false;
                                      });
                                    },
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(8)),
                                    selectedBorderColor: primaryColor,
                                    selectedColor: Colors.white,
                                    fillColor: primaryColor,
                                    color: primaryColor,
                                    constraints: BoxConstraints(
                                      minHeight: height * 0.06,
                                      minWidth: width * 0.3,
                                    ),
                                    isSelected: _selectedType,
                                    children: type,
                                  ),
                                ],
                              ),
                            ),
                          ])),
                )
              ]),
            ])),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            HapticFeedback.lightImpact(); // 약한 진동
            if (_formKeySelf.currentState!.validate() &&
                _purpose.text != '' &&
                _selfAge.text.split(' ').first != '' &&
                (_selectedType[0] || _selectedType[1])) {
              
                storeSelfInfo(_nickname.text, _selfAge.text, _purpose.text,
                    _selectedType, _selectedDegree);
                  if (mounted) {
                    Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const BottomNavBar()));
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
                fontWeight: FontWeight.w500),
          ),
        ));
  }
}
