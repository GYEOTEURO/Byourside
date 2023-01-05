import 'package:byourside/main.dart';
import 'package:byourside/model/firebase_user.dart';
import 'package:byourside/screen/authenticate/verify_email.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

GlobalKey<FormState> _formKey_protector = GlobalKey<FormState>();

final List<bool> _selectedProtectorGender = <bool>[false, false];
final List<bool> _selectedChildGender = <bool>[false, false];
final List<bool> _selectedChildType = <bool>[false, false];
final List<bool> _selectedChildDegree = <bool>[false, false];

final TextEditingController _nickname = TextEditingController();
final TextEditingController _protectorAge = TextEditingController();
final TextEditingController _childAge = TextEditingController();
final TextEditingController _belong = TextEditingController();

const List<Widget> gender = <Widget>[
  Text('남자', style: TextStyle(fontSize: 17)),
  Text('여자', style: TextStyle(fontSize: 17))
];
const List<Widget> type = <Widget>[
  Text('뇌병변 장애', style: TextStyle(fontSize: 17)),
  Text('발달 장애', style: TextStyle(fontSize: 17))
];
const List<Widget> degree = <Widget>[
  Text('심한 장애', style: TextStyle(fontSize: 17)),
  Text('심하지 않은 장애', style: TextStyle(fontSize: 17))
];

class protector extends StatefulWidget {
  const protector({Key? key}) : super(key: key);

  @override
  State<protector> createState() => _protectorState();
}

class _protectorState extends State<protector> {
  bool doesDocExist = true;
  final User? user = FirebaseAuth.instance.currentUser;
  bool protector = true;
  bool isUserDataStored = false;

  Future<bool> checkDocExist(String name) async {
    var collection = FirebaseFirestore.instance.collection('displayNameList');
    var doc = await collection.doc(name).get();
    if (doc.exists == true) {
      if (mounted) {
        showDialog(
            context: context,
            builder: (context) {
              return const AlertDialog(
                content: Text('이미 존재하는 닉네임입니다. 다른 닉네임을 사용하세요.',
                    style: TextStyle(fontSize: 17)),
              );
            });
      }
    } else {
      showDialog(
          context: context,
          builder: (context) {
            return const AlertDialog(
              content: Text('사용가능한 닉네임입니다.', style: TextStyle(fontSize: 17)),
            );
          });
    }
    return doc.exists;
  }

  bool isNumeric(String s) {
    if (s == null) {
      return false;
    }
    return double.tryParse(s) != null;
  }

  final nicknameField = Container(
      child: TextFormField(
    decoration: const InputDecoration(
      labelText: "닉네임을 입력하세요",
      hintText: "(예: 홍길동) ",
      hintStyle: TextStyle(color: Colors.grey, fontSize: 17),
      labelStyle: TextStyle(color: primaryColor, fontSize: 17),
    ),
    autofocus: true,
    controller: _nickname,
    validator: (value) {
      if (value != null) {
        if (value.split(' ').first != '' && value.isNotEmpty) {
          return null;
        }
        return '필수 입력란입니다. 닉네임을 입력하세요';
      }
    },
  ));

  void storeProtectorInfo(
      String? nickname,
      String? protectorAge,
      List<bool>? selectedProtectorGender,
      String? childAge,
      List<bool>? selectedChildGender,
      List<bool>? selectedChildType,
      List<bool>? selectedChildDegree,
      String? belong) async {
    // image url 포함해 firestore에 document 저장
    FirebaseFirestore.instance.collection('user').doc(user!.uid).set({
      "nickname": nickname,
      "protectorAge": protectorAge,
      "protectorGender": selectedProtectorGender,
      "childAge": childAge,
      "childGender": selectedChildGender,
      "childType": selectedChildType,
      "childDegree": selectedChildDegree,
      "belong": belong,
      "groups": [],
      "profilePic": "",
    });
    FirebaseFirestore.instance
        .collection('displayNameList')
        .doc('$nickname')
        .set({'current': true});
    if (user != null) {
      await user?.updateDisplayName(nickname);
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
          title: Text("세부 정보 입력"),
          titleTextStyle: TextStyle(fontSize: height * 0.04),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        body: SingleChildScrollView(
            child: Column(children: [
          Column(children: [
            Form(
              key: _formKey_protector,
              child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        nicknameField,
                        SizedBox(height: height * 0.02),
                        TextFormField(
                          decoration: const InputDecoration(
                            labelText: "보호자 나이",
                            hintText: "(예: 33)",
                            hintStyle:
                                TextStyle(color: Colors.grey, fontSize: 17),
                            labelStyle:
                                TextStyle(color: primaryColor, fontSize: 17),
                          ),
                          keyboardType: TextInputType.number,
                          controller: _protectorAge,
                          validator: (value) {
                            if (value != null) {
                              if (value.split(' ').first != '' &&
                                  value.isNotEmpty &&
                                  isNumeric(value)) {
                                return null;
                              }
                              return '유효한 나이를 입력하세요. 숫자만 입력 가능합니다.';
                            }
                          },
                        ),
                        SizedBox(height: height * 0.02),
                        TextFormField(
                          decoration: const InputDecoration(
                            labelText: "자녀 나이",
                            hintText: "(예: 7)",
                            hintStyle:
                                TextStyle(color: Colors.grey, fontSize: 17),
                            labelStyle:
                                TextStyle(color: primaryColor, fontSize: 17),
                          ),
                          keyboardType: TextInputType.number,
                          controller: _childAge,
                          validator: (value) {
                            if (value != null) {
                              if (value.split(' ').first != '' &&
                                  value.isNotEmpty &&
                                  isNumeric(value)) {
                                return null;
                              }
                              return '유효한 나이를 입력하세요. 숫자만 입력 가능합니다.';
                            }
                          },
                        ),
                        SizedBox(height: height * 0.02),
                        TextFormField(
                          decoration: const InputDecoration(
                            labelText: "소속 복지관/학교",
                            hintText: "(예: 서울뇌성마비복지관)",
                            hintStyle:
                                TextStyle(color: Colors.grey, fontSize: 17),
                            labelStyle:
                                TextStyle(color: primaryColor, fontSize: 17),
                          ),
                          controller: _belong,
                          validator: (value) {
                            if (value != null) {
                              if (value.split(' ').first != '' &&
                                  value.isNotEmpty) {
                                return null;
                              }
                              return '필수 입력란입니다. 소속을 입력하세요';
                            }
                          },
                        ),
                        SizedBox(height: height * 0.03),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text("보호자 성별", style: TextStyle(fontSize: 17)),
                            SizedBox(
                              width: 30,
                            ),
                            ToggleButtons(
                              direction: Axis.horizontal,
                              onPressed: (int index) {
                                HapticFeedback.lightImpact(); // 약한 진동
                                setState(() {
                                  _selectedProtectorGender[index] = true;
                                  _selectedProtectorGender[(1 - index).abs()] =
                                      false;
                                });
                              },
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(8)),
                              selectedBorderColor: primaryColor,
                              selectedColor: Colors.white,
                              fillColor: primaryColor,
                              color: primaryColor,
                              constraints: BoxConstraints(
                                minHeight: height * 0.06,
                                minWidth: width * 0.3,
                              ),
                              isSelected: _selectedProtectorGender,
                              children: gender,
                            )
                          ],
                        ),
                        SizedBox(height: height * 0.03),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("자녀 성별", style: TextStyle(fontSize: 17)),
                            SizedBox(
                              width: 30,
                            ),
                            ToggleButtons(
                              direction: Axis.horizontal,
                              onPressed: (int index) {
                                HapticFeedback.lightImpact(); // 약한 진동
                                setState(() {
                                  _selectedChildGender[index] = true;
                                  _selectedChildGender[(1 - index).abs()] =
                                      false;
                                });
                              },
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(8)),
                              selectedBorderColor: primaryColor,
                              selectedColor: Colors.white,
                              fillColor: primaryColor,
                              color: primaryColor,
                              constraints: BoxConstraints(
                                minHeight: height * 0.06,
                                minWidth: width * 0.3,
                              ),
                              isSelected: _selectedChildGender,
                              children: gender,
                            ),
                          ],
                        ),
                        SizedBox(height: height * 0.03),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("장애 유형", style: TextStyle(fontSize: 17)),
                            SizedBox(
                              width: 30,
                            ),
                            ToggleButtons(
                              direction: Axis.horizontal,
                              onPressed: (int index) {
                                HapticFeedback.lightImpact(); // 약한 진동
                                setState(() {
                                  _selectedChildType[index] = true;
                                  _selectedChildType[(1 - index).abs()] = false;
                                });
                              },
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(8)),
                              selectedBorderColor: primaryColor,
                              selectedColor: Colors.white,
                              fillColor: primaryColor,
                              color: primaryColor,
                              constraints: BoxConstraints(
                                minHeight: height * 0.06,
                                minWidth: width * 0.3,
                              ),
                              isSelected: _selectedChildType,
                              children: type,
                            ),
                          ],
                        ),
                        SizedBox(height: height * 0.03),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("장애 정도", style: TextStyle(fontSize: 17)),
                            SizedBox(
                              width: 30,
                            ),
                            ToggleButtons(
                              direction: Axis.horizontal,
                              onPressed: (int index) {
                                HapticFeedback.lightImpact(); // 약한 진동
                                setState(() {
                                  _selectedChildDegree[index] = true;
                                  _selectedChildDegree[(1 - index).abs()] =
                                      false;
                                });
                              },
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(8)),
                              selectedBorderColor: primaryColor,
                              selectedColor: Colors.white,
                              fillColor: primaryColor,
                              color: primaryColor,
                              constraints: BoxConstraints(
                                minHeight: height * 0.06,
                                minWidth: width * 0.3,
                              ),
                              isSelected: _selectedChildDegree,
                              children: degree,
                            ),
                          ],
                        ),
                        SizedBox(height: height * 0.03),
                      ])),
            )
          ])
        ])),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            HapticFeedback.lightImpact(); // 약한 진동
            if (_formKey_protector.currentState!.validate() &&
                _nickname.text.split(' ').first != '' &&
                _protectorAge.text.split(' ').first != '' &&
                _childAge.text.split(' ').first != '' &&
                _belong.text.split(' ').first != '' &&
                (_selectedChildDegree[0] || _selectedChildDegree[1]) &&
                (_selectedChildGender[0] || _selectedChildGender[1]) &&
                (_selectedChildType[0] || _selectedChildType[1]) &&
                (_selectedProtectorGender[0] || _selectedProtectorGender[1])) {
              doesDocExist = await checkDocExist(_nickname.text);
              if (doesDocExist == false) {
                storeProtectorInfo(
                    _nickname.text,
                    _protectorAge.text,
                    _selectedProtectorGender,
                    _childAge.text,
                    _selectedChildGender,
                    _selectedChildType,
                    _selectedChildDegree,
                    _belong.text);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => VerifyEmail()));
              }
            }
            ;
          },
          backgroundColor: primaryColor,
          child: const Text("완료", style: TextStyle(fontSize: 17)),
        ));
  }
}
