import 'package:byourside/main.dart';
import 'package:byourside/model/firebase_user.dart';
import 'package:byourside/screen/authenticate/verify_email.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

GlobalKey<FormState> _formKey_self = GlobalKey<FormState>();
final List<bool> _selectedType = <bool>[false, false];
final List<bool> _selectedDegree = <bool>[false, false];

final TextEditingController _nickname = TextEditingController();
final TextEditingController _purpose = TextEditingController();
final TextEditingController _selfAge = TextEditingController();

const List<Widget> type = <Widget>[
  Text('뇌병변 장애', semanticsLabel: '뇌병변 장애', style: TextStyle(fontSize: 17)),
  Text('발달 장애', semanticsLabel: '발달 장애', style: TextStyle(fontSize: 17))
];
const List<Widget> degree = <Widget>[
  Text('심한 장애', semanticsLabel: '심한 장애', style: TextStyle(fontSize: 17)),
  Text('심하지 않은 장애', semanticsLabel: '심하지 않은 장애', style: TextStyle(fontSize: 17))
];

class self extends StatefulWidget {
  const self({Key? key}) : super(key: key);

  @override
  State<self> createState() => selfState();
}

class selfState extends State<self> {
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
                      "이미 존재하는 닉네임입니다. 다른 닉네임을 사용하세요. 돌아가려면 하단의 확인 버튼을 눌러주세요.",
                  content: Text(
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
                        child: Text('확인',
                            semanticsLabel: '확인',
                            style: const TextStyle(
                              fontSize: 14,
                              fontFamily: 'NanumGothic',
                              fontWeight: FontWeight.w600,
                            )))
                  ]);
            });
      }
    } else {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
                semanticLabel: "사용가능한 닉네임입니다. 돌아가려면 하단의 확인 버튼을 눌러주세요.",
                content: Text(
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
                      child: Text('확인',
                          semanticsLabel: '확인',
                          style: const TextStyle(
                            fontSize: 14,
                            fontFamily: 'NanumGothic',
                            fontWeight: FontWeight.w600,
                          )))
                ]);
          });
    }
    return doc.exists;
  }

  final someoneElseField = Container(
      child: Semantics(
          container: true,
          textField: true,
          label: '방문 목적',
          hint: '(예: 자녀 장애 초기증상 판별)',
          child: TextFormField(
            decoration: InputDecoration(
              labelText: "방문 목적",
              hintText: "(예: 자녀 장애 초기증상 판별)",
              floatingLabelStyle: TextStyle(
                  color: primaryColor,
                  fontSize: 22,
                  fontFamily: 'NanumGothic',
                  fontWeight: FontWeight.w500),
              errorStyle: TextStyle(
                  color: Color.fromARGB(255, 255, 45, 45),
                  fontSize: 17,
                  fontFamily: 'NanumGothic',
                  fontWeight: FontWeight.w500),
              contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
              hintStyle: TextStyle(
                  color: Colors.grey,
                  fontSize: 17,
                  fontFamily: 'NanumGothic',
                  fontWeight: FontWeight.w500),
              labelStyle: TextStyle(
                  color: primaryColor,
                  fontSize: 17,
                  fontFamily: 'NanumGothic',
                  fontWeight: FontWeight.w500),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: primaryColor),
                  borderRadius: BorderRadius.circular(20)),
              errorBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: Color.fromARGB(255, 255, 45, 45)),
                  borderRadius: BorderRadius.circular(20)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: primaryColor),
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
            },
          )));

  bool isNumeric(String s) {
    if (s == null) {
      return false;
    }
    return double.tryParse(s) != null;
  }

  final nicknameField = Container(
      child: Semantics(
          container: true,
          textField: true,
          label: '닉네임을 입력하세요.',
          hint: '(예: 홍길동)',
          child: TextFormField(
            decoration: InputDecoration(
              labelText: "닉네임을 입력하세요",
              hintText: "(예: 홍길동) ",
              floatingLabelStyle: TextStyle(
                  color: primaryColor,
                  fontSize: 22,
                  fontFamily: 'NanumGothic',
                  fontWeight: FontWeight.w500),
              errorStyle: TextStyle(
                  color: Color.fromARGB(255, 255, 45, 45),
                  fontSize: 17,
                  fontFamily: 'NanumGothic',
                  fontWeight: FontWeight.w500),
              contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
              hintStyle: TextStyle(
                  color: Colors.grey,
                  fontSize: 17,
                  fontFamily: 'NanumGothic',
                  fontWeight: FontWeight.w500),
              labelStyle: TextStyle(
                  color: primaryColor,
                  fontSize: 17,
                  fontFamily: 'NanumGothic',
                  fontWeight: FontWeight.w500),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: primaryColor),
                  borderRadius: BorderRadius.circular(20)),
              errorBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: Color.fromARGB(255, 255, 45, 45)),
                  borderRadius: BorderRadius.circular(20)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: primaryColor),
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
            },
          )));

  void storeSelfInfo(
    String? nickname,
    String? age,
    String? purpose,
    List<bool>? selectedType,
    List<bool>? selectedDegree,
  ) async {
    // image url 포함해 firestore에 document 저장
    FirebaseFirestore.instance.collection('user').doc(user!.uid).set({
      "nickname": nickname,
      "purpose": purpose,
      "age": age,
      "type": selectedType,
      "degree": selectedDegree,
      "groups": [],
      "profilePic": "",
      "blockList": [],
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
          title: Text("세부 정보 입력",
              semanticsLabel: "세부 정보 입력",
              style: TextStyle(
                  fontFamily: 'NanumGothic', fontWeight: FontWeight.bold)),
          backgroundColor: Theme.of(context).primaryColor,
          leading: IconButton(
              icon: Icon(Icons.arrow_back,
                  semanticLabel: "뒤로 가기", color: Colors.white),
              onPressed: () {
                Navigator.pop(context);
              }),
        ),
        body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(children: [
              Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 30, 50, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "3/4",
                        semanticsLabel: "3/4",
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
                  key: _formKey_self,
                  child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "닉네임을 입력하세요.",
                              semanticsLabel: "닉네임을 입력하세요.",
                              style: TextStyle(
                                  color: primaryColor,
                                  fontSize: 17,
                                  fontFamily: 'NanumGothic',
                                  fontWeight: FontWeight.w600),
                            ),
                            SizedBox(height: height * 0.01),
                            Text(
                              "특수기호 '_'는 사용이 불가합니다.",
                              semanticsLabel: "특수기호 _ 는 사용이 불가합니다.",
                              style: TextStyle(
                                  color: primaryColor,
                                  fontSize: 14,
                                  fontFamily: 'NanumGothic',
                                  fontWeight: FontWeight.w600),
                            ),
                            SizedBox(height: height * 0.03),
                            nicknameField,
                            SizedBox(height: height * 0.04),
                            Text(
                              "나이를 입력하세요.",
                              semanticsLabel: "나이를 입력하세요.",
                              style: TextStyle(
                                  color: primaryColor,
                                  fontSize: 17,
                                  fontFamily: 'NanumGothic',
                                  fontWeight: FontWeight.w600),
                            ),
                            SizedBox(height: height * 0.02),
                            Semantics(
                                container: true,
                                textField: true,
                                label: "나이",
                                hint: '(예: 21)',
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    labelText: "나이",
                                    hintText: "(예: 21)",
                                    floatingLabelStyle: TextStyle(
                                        color: primaryColor,
                                        fontSize: 22,
                                        fontFamily: 'NanumGothic',
                                        fontWeight: FontWeight.w500),
                                    errorStyle: TextStyle(
                                        color: Color.fromARGB(255, 255, 45, 45),
                                        fontSize: 17,
                                        fontFamily: 'NanumGothic',
                                        fontWeight: FontWeight.w500),
                                    contentPadding: const EdgeInsets.fromLTRB(
                                        20.0, 15.0, 20.0, 15.0),
                                    hintStyle: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 17,
                                        fontFamily: 'NanumGothic',
                                        fontWeight: FontWeight.w500),
                                    labelStyle: TextStyle(
                                        color: primaryColor,
                                        fontSize: 17,
                                        fontFamily: 'NanumGothic',
                                        fontWeight: FontWeight.w500),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: primaryColor),
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    errorBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Color.fromARGB(
                                                255, 255, 45, 45)),
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: primaryColor),
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(32.0)),
                                  ),
                                  keyboardType: TextInputType.number,
                                  controller: _selfAge,
                                  validator: (value) {
                                    if (value != null) {
                                      if (value.split(' ').first != '' &&
                                          value.isNotEmpty &&
                                          isNumeric(value)) {
                                        return null;
                                      }
                                      return '숫자만 입력 가능합니다.';
                                    }
                                  },
                                )),
                            SizedBox(height: height * 0.03),
                            Text(
                              "방문 목적을 입력하세요.",
                              semanticsLabel: "방문 목적을 입력하세요.",
                              style: TextStyle(
                                  color: primaryColor,
                                  fontSize: 17,
                                  fontFamily: 'NanumGothic',
                                  fontWeight: FontWeight.w600),
                            ),
                            SizedBox(height: height * 0.03),
                            someoneElseField,
                            SizedBox(height: height * 0.03),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "장애 유형",
                                    semanticsLabel: "장애 유형",
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontFamily: 'NanumGothic',
                                        fontWeight: FontWeight.w500),
                                  ),
                                  SizedBox(
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
                            SizedBox(height: height * 0.03),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "장애 정도",
                                    semanticsLabel: "장애 정도",
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontFamily: 'NanumGothic',
                                        fontWeight: FontWeight.w500),
                                  ),
                                  SizedBox(
                                    width: 30,
                                  ),
                                  ToggleButtons(
                                    direction: Axis.horizontal,
                                    onPressed: (int index) {
                                      HapticFeedback.lightImpact(); // 약한 진동
                                      setState(() {
                                        _selectedDegree[index] = true;
                                        _selectedDegree[(1 - index).abs()] =
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
                                    isSelected: _selectedDegree,
                                    children: degree,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: height * 0.03),
                          ])),
                )
              ]),
            ])),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            HapticFeedback.lightImpact(); // 약한 진동
            if (_formKey_self.currentState!.validate() &&
                _purpose.text != null &&
                _purpose.text != '' &&
                _selfAge.text.split(' ').first != '' &&
                (_selectedDegree[0] || _selectedDegree[1]) &&
                (_selectedType[0] || _selectedType[1])) {
              doesDocExist = await checkDocExist(_nickname.text);
              if (doesDocExist == false) {
                storeSelfInfo(_nickname.text, _selfAge.text, _purpose.text,
                    _selectedType, _selectedDegree);
                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => VerifyEmail()));
              }
            }
          },
          backgroundColor: primaryColor,
          child: const Text(
            "완료",
            semanticsLabel: "완료",
            style: TextStyle(
                fontSize: 17,
                fontFamily: 'NanumGothic',
                fontWeight: FontWeight.w500),
          ),
        ));
  }
}
