import 'package:byourside/main.dart';
import 'package:byourside/model/firebase_user.dart';
import 'package:byourside/screen/bottom_nav_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

GlobalKey<FormState> _formKeySomeoneELse = GlobalKey<FormState>();

final TextEditingController _nickname = TextEditingController();
final TextEditingController _purpose = TextEditingController();

class SomeoneElse extends StatefulWidget {
  const SomeoneElse({Key? key}) : super(key: key);

  @override
  State<SomeoneElse> createState() => _SomeoneElseState();
}

class _SomeoneElseState extends State<SomeoneElse> {
  bool doesDocExist = true;
  final User? user = FirebaseAuth.instance.currentUser;
  bool someoneElse = false;
  bool isUserDataStored = false;

  Future<bool> checkDocExist(String name) async {
    var collection = FirebaseFirestore.instance.collection('displayNameList');
    var doc = await collection.doc(name).get();
    if (doc.exists == true) {
      if (mounted) {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                  semanticLabel:
                      '이미 존재하는 닉네임입니다. 다른 닉네임을 사용하세요. 돌아가려면 하단의 확인 버튼을 눌러주세요.',
                  content: const Text(
                    '이미 존재하는 닉네임입니다. 다른 닉네임을 사용하세요.',
                    semanticsLabel: '이미 존재하는 닉네임입니다. 다른 닉네임을 사용하세요.',
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'NanumGothic',
                        fontWeight: FontWeight.w500),
                  ),
                  actions: [
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryColor,
                        ),
                        onPressed: () {
                          HapticFeedback.lightImpact(); // 약한 진동
                          Navigator.pop(context);
                        },
                        child: const Text('확인',
                            semanticsLabel: '확인',
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'NanumGothic',
                              fontWeight: FontWeight.w600,
                            )))
                  ]);
            });
      }
    } else {
      if (mounted){
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
                semanticLabel: '사용가능한 닉네임입니다. 돌아가려면 하단의 확인 버튼을 눌러주세요.',
                content: const Text(
                  '사용가능한 닉네임입니다.',
                  semanticsLabel: '사용가능한 닉네임입니다.',
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'NanumGothic',
                      fontWeight: FontWeight.w500),
                ),
                actions: [
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                      ),
                      onPressed: () {
                        HapticFeedback.lightImpact(); // 약한 진동
                        Navigator.pop(context);
                      },
                      child: const Text('확인',
                          semanticsLabel: '확인',
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'NanumGothic',
                            fontWeight: FontWeight.w600,
                          )))
                ]);
          });
      }
    }
    return doc.exists;
  }

  final someoneElseField = Semantics(
      container: true,
      textField: true,
      label: '방문 목적',
      hint: '(예: 자녀 장애 초기증상 판별)',
      child: TextFormField(
        decoration: InputDecoration(
          labelText: '방문 목적',
          hintText: '(예: 자녀 장애 초기증상 판별)',
          floatingLabelStyle: const TextStyle(
              color: primaryColor,
              fontSize: 22,
              fontFamily: 'NanumGothic',
              fontWeight: FontWeight.w500),
          errorStyle: const TextStyle(
              color: Color.fromARGB(255, 255, 45, 45),
              fontSize: 17,
              fontFamily: 'NanumGothic',
              fontWeight: FontWeight.w500),
          contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintStyle: const TextStyle(
              color: Colors.grey,
              fontSize: 17,
              fontFamily: 'NanumGothic',
              fontWeight: FontWeight.w500),
          labelStyle: const TextStyle(
              color: primaryColor,
              fontSize: 17,
              fontFamily: 'NanumGothic',
              fontWeight: FontWeight.w500),
          enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: primaryColor),
              borderRadius: BorderRadius.circular(20)),
          errorBorder: OutlineInputBorder(
              borderSide:
                  const BorderSide(color: Color.fromARGB(255, 255, 45, 45)),
              borderRadius: BorderRadius.circular(20)),
          focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: primaryColor),
              borderRadius: BorderRadius.circular(20)),
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
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

  final nicknameField = Semantics(
      container: true,
      textField: true,
      label: '닉네임을 입력하세요.',
      hint: '(예: 홍길동)',
      child: TextFormField(
        decoration: InputDecoration(
          labelText: '닉네임을 입력하세요',
          hintText: '(예: 홍길동) ',
          floatingLabelStyle: const TextStyle(
              color: primaryColor,
              fontSize: 22,
              fontFamily: 'NanumGothic',
              fontWeight: FontWeight.w500),
          errorStyle: const TextStyle(
              color: Color.fromARGB(255, 255, 45, 45),
              fontSize: 17,
              fontFamily: 'NanumGothic',
              fontWeight: FontWeight.w500),
          contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintStyle: const TextStyle(
              color: Colors.grey,
              fontSize: 17,
              fontFamily: 'NanumGothic',
              fontWeight: FontWeight.w500),
          labelStyle: const TextStyle(
              color: primaryColor,
              fontSize: 17,
              fontFamily: 'NanumGothic',
              fontWeight: FontWeight.w500),
          enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: primaryColor),
              borderRadius: BorderRadius.circular(20)),
          errorBorder: OutlineInputBorder(
              borderSide:
                  const BorderSide(color: Color.fromARGB(255, 255, 45, 45)),
              borderRadius: BorderRadius.circular(20)),
          focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: primaryColor),
              borderRadius: BorderRadius.circular(20)),
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
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

  void storeSomeoneElseInfo(String? nickname, String? purpose) async {
    // image url 포함해 firestore에 document 저장
    FirebaseFirestore.instance.collection('user').doc(user!.uid).set({
      'nickname': nickname,
      'purpose': purpose,
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
                const Padding(
                  padding: EdgeInsets.fromLTRB(0, 30, 50, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '3/4 단계',
                        semanticsLabel: '3/4 단계',
                        style: TextStyle(
                            color: primaryColor,
                            fontSize: 20,
                            fontFamily: 'NanumGothic',
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
                Form(
                  key: _formKeySomeoneELse,
                  child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text(
                              '닉네임을 입력하세요.',
                              semanticsLabel: '닉네임을 입력하세요.',
                              style: TextStyle(
                                  color: primaryColor,
                                  fontSize: 17,
                                  fontFamily: 'NanumGothic',
                                  fontWeight: FontWeight.w600),
                            ),
                            SizedBox(height: height * 0.01),
                            const Text(
                              "특수기호 '_'는 사용이 불가합니다.",
                              semanticsLabel: '특수기호 _ 는 사용이 불가합니다.',
                              style: TextStyle(
                                  color: primaryColor,
                                  fontSize: 14,
                                  fontFamily: 'NanumGothic',
                                  fontWeight: FontWeight.w600),
                            ),
                            SizedBox(height: height * 0.03),
                            nicknameField,
                            SizedBox(height: height * 0.03),
                            const Text(
                              '방문 목적을 입력하세요.',
                              semanticsLabel: '방문 목적을 입력하세요.',
                              style: TextStyle(
                                  color: primaryColor,
                                  fontSize: 17,
                                  fontFamily: 'NanumGothic',
                                  fontWeight: FontWeight.w600),
                            ),
                            SizedBox(height: height * 0.03),
                            someoneElseField
                          ])),
                )
              ]),
            ])),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            HapticFeedback.lightImpact(); // 약한 진동
            if (_formKeySomeoneELse.currentState!.validate() &&
                _purpose.text != '') {
              doesDocExist = await checkDocExist(_nickname.text);
              if (doesDocExist == false) {
                storeSomeoneElseInfo(_nickname.text, _purpose.text);
                if (mounted){
                  Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const BottomNavBar()));
                }
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
