// ignore_for_file: deprecated_member_use

import 'package:byourside/main.dart';
import 'package:byourside/model/firebase_user.dart';
import 'package:byourside/screen/authenticate/verify_email.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

enum Select { protector, participator, someoneElse }

List<String> purposeType = ['promote', 'recruit'];
String _dropdownValue = 'promote';

const List<Widget> gender = <Widget>[Text('man'), Text('woman')];
const List<Widget> type = <Widget>[
  Text('BrainLesion'),
  Text('developmentalDisability')
];
const List<Widget> degree = <Widget>[Text('stark'), Text('gentle')];

final List<bool> _selectedProtectorGender = <bool>[false, false];
final List<bool> _selectedChildGender = <bool>[false, false];
final List<bool> _selectedChildType = <bool>[false, false];
final List<bool> _selectedChildDegree = <bool>[false, false];

final TextEditingController _nickname = TextEditingController();
final TextEditingController _protectorAge = TextEditingController();
final TextEditingController _childAge = TextEditingController();
final TextEditingController _belong = TextEditingController();
final TextEditingController _organizationName = TextEditingController();
final TextEditingController _purpose = TextEditingController();

class SetupUser extends StatefulWidget {
  const SetupUser({Key? key}) : super(key: key);

  @override
  State<SetupUser> createState() => _SetupUserState();
}

class _SetupUserState extends State<SetupUser> {
  bool isUserDataStored = false;
  bool protector = false;
  bool participator = false;
  bool someoneElse = false;
  Select _select = Select.protector;

  final User? user = FirebaseAuth.instance.currentUser;
  int count = 0;

  @override
  void initState() {
    super.initState();

    Future<bool> isUserDataStored = checkStored();
  }

  Future<bool> checkStored() async {
    return await checkIfDocExists(user!.uid);
  }

  Future<bool> checkIfDocExists(String docId) async {
    var collectionRef = FirebaseFirestore.instance.collection('user');

    var doc = await collectionRef.doc(docId).get();
    return doc.exists;
  }

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
    await user?.updateDisplayName(nickname);
    // print(user);
    if (user != null) {
      FirebaseUser(uid: user?.uid, displayName: nickname);
    }
  }

  void storeParticipatorInfo(
      String? nickname, String? protectorAge, String? dropdownValue) async {
    // if(){
    //   // image url 포함해 firestore에 document 저장
    //   FirebaseFirestore.instance.collection('user').doc(user!.uid).set({
    //     "nickname": nickname,
    //     "protectorAge": protectorAge,
    //     "dropdownValue": dropdownValue,
    //     "groups": [],
    //     "profilePic": "",
    //   });
    //   await user?.updateDisplayName(nickname);
    //   print(user);
    //   if (user != null) {
    //     FirebaseUser(uid: user?.uid, displayName: nickname);
    //   }
    // }
    // else {

    // }

    // image url 포함해 firestore에 document 저장
    FirebaseFirestore.instance.collection('user').doc(user!.uid).set({
      "nickname": nickname,
      "protectorAge": protectorAge,
      "dropdownValue": dropdownValue,
      "groups": [],
      "profilePic": "",
    });
    await user?.updateDisplayName(nickname);
    print(user);
    if (user != null) {
      FirebaseUser(uid: user?.uid, displayName: nickname);
    }
  }

  void storeSomeoneElseInfo(String? nickname, String? purpose) async {
    // image url 포함해 firestore에 document 저장
    FirebaseFirestore.instance.collection('user').doc(user!.uid).set({
      "nickname": nickname,
      "purpose": purpose,
      "groups": [],
      "profilePic": "",
    });
    await user?.updateDisplayName(nickname);
    print(user);
    if (user != null) {
      FirebaseUser(uid: user?.uid, displayName: nickname);
    }
  }

  final nicknameField = Container(
      child: TextFormField(
    decoration: InputDecoration(labelText: "닉네임을 입력하세요"),
    controller: _nickname,
    validator: (value) {
      if (value != null) {
        if (value.split(' ').first != '' && value.isNotEmpty) {
          return null;
        }
        return '유효한 닉네임을 입력하세요';
      }
    },
  ));

  final someoneElseField = Container(
      child: TextFormField(
    decoration: InputDecoration(labelText: "방문 목적"),
    controller: _purpose,
    validator: (value) {
      if (value != null) {
        if (value.split(' ').first != '' && value.isNotEmpty) {
          return null;
        }
        return '유효한 방문 목적을 입력하세요';
      }
    },
  ));

  bool isNumeric(String s) {
    if (s == null) {
      return false;
    }
    return double.tryParse(s) != null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: primaryColor),
      body: SingleChildScrollView(
        child: Column(children: [
          Form(
              child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                nicknameField,
                ListTile(
                  title: Text('장애 아동 보호자'),
                  leading: Radio<Select>(
                    value: Select.protector,
                    groupValue: _select,
                    onChanged: (Select? value) {
                      setState(() {
                        _select = value!;
                        print(_select);
                        protector = true;
                        participator = false;
                        someoneElse = false;
                      });
                    },
                  ),
                ),
                ListTile(
                  title: Text('관계자'),
                  leading: Radio<Select>(
                    value: Select.participator,
                    groupValue: _select,
                    onChanged: (Select? value) {
                      setState(() {
                        _select = value!;
                        protector = false;
                        participator = true;
                        someoneElse = false;
                      });
                    },
                  ),
                ),
                ListTile(
                  title: Text('기타'),
                  leading: Radio<Select>(
                    value: Select.someoneElse,
                    groupValue: _select,
                    onChanged: (Select? value) {
                      setState(() {
                        _select = value!;
                        protector = false;
                        participator = false;
                        someoneElse = true;
                      });
                    },
                  ),
                ),
                (protector)
                    ? Column(children: <Widget>[
                        TextFormField(
                          decoration: InputDecoration(labelText: "보호자 나이"),
                          controller: _protectorAge,
                          validator: (value) {
                            if (value != null) {
                              if (value.split(' ').first != '' &&
                                  value.isNotEmpty &&
                                  isNumeric(value)) {
                                return null;
                              }
                              return '유효한 나이를 입력하세요';
                            }
                          },
                        ),
                        // Text('Protector gender'),
                        const SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("보호자 성별"),
                            SizedBox(
                              width: 30,
                            ),
                            ToggleButtons(
                              direction: Axis.horizontal,
                              onPressed: (int index) {
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
                              constraints: const BoxConstraints(
                                minHeight: 40.0,
                                minWidth: 80.0,
                              ),
                              isSelected: _selectedProtectorGender,
                              children: gender,
                            )
                          ],
                        ),
                        TextFormField(
                          decoration: InputDecoration(labelText: "자녀 나이"),
                          controller: _childAge,
                          validator: (value) {
                            if (value != null) {
                              if (value.split(' ').first != '' &&
                                  value.isNotEmpty &&
                                  isNumeric(value)) {
                                return null;
                              }
                              return '유효한 나이를 입력하세요';
                            }
                          },
                        ),
                        // Text('Child gender'),
                        const SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("자녀 성별"),
                            SizedBox(
                              width: 30,
                            ),
                            ToggleButtons(
                              direction: Axis.horizontal,
                              onPressed: (int index) {
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
                              constraints: const BoxConstraints(
                                minHeight: 40.0,
                                minWidth: 80.0,
                              ),
                              isSelected: _selectedChildGender,
                              children: gender,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("장애 유형"),
                            SizedBox(
                              width: 30,
                            ),
                            ToggleButtons(
                              direction: Axis.horizontal,
                              onPressed: (int index) {
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
                              constraints: const BoxConstraints(
                                minHeight: 40.0,
                                minWidth: 80.0,
                              ),
                              isSelected: _selectedChildType,
                              children: type,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("장애 정도"),
                            SizedBox(
                              width: 30,
                            ),
                            ToggleButtons(
                              direction: Axis.horizontal,
                              onPressed: (int index) {
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
                              constraints: const BoxConstraints(
                                minHeight: 40.0,
                                minWidth: 80.0,
                              ),
                              isSelected: _selectedChildDegree,
                              children: degree,
                            ),
                          ],
                        ),
                        TextFormField(
                          decoration: InputDecoration(labelText: "소속 복지관/학교"),
                          controller: _belong,
                          validator: (value) {
                            if (value != null) {
                              if (value.split(' ').first != '' &&
                                  value.isNotEmpty) {
                                return null;
                              }
                              return '유효한 소속을 입력하세요';
                            }
                          },
                        ),
                      ])
                    : SizedBox(),
                (participator)
                    ? Column(children: <Widget>[
                        TextFormField(
                          decoration: InputDecoration(labelText: "개인/단체 이름"),
                          controller: _organizationName,
                          validator: (value) {
                            if (value != null) {
                              if (value.split(' ').first != '' &&
                                  value.isNotEmpty) {
                                return null;
                              }
                              return '유효한 개인/단체 이름을 입력하세요';
                            }
                          },
                        ),
                        DropdownButton(
                          value: _dropdownValue,
                          items: purposeType
                              .map((String item) => DropdownMenuItem<String>(
                                    child: Text('$item'),
                                    value: item,
                                  ))
                              .toList(),
                          onChanged: (dynamic newValue) {
                            setState(() {
                              _dropdownValue = newValue;
                            });
                          },
                          elevation: 8,
                        )
                      ])
                    : SizedBox(),
                (someoneElse) ? someoneElseField : SizedBox(),
              ],
            ),
          ))
          // 닉네임
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          (protector)
              ? storeProtectorInfo(
                  _nickname.text,
                  _protectorAge.text,
                  _selectedProtectorGender,
                  _childAge.text,
                  _selectedChildGender,
                  _selectedChildType,
                  _selectedChildDegree,
                  _belong.text)
              : null;
          (participator)
              ? storeParticipatorInfo(
                  _nickname.text, _organizationName.text, _dropdownValue)
              : null;
          (someoneElse)
              ? storeSomeoneElseInfo(_nickname.text, _purpose.text)
              : null;
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => VerifyEmail()));
        },
        backgroundColor: primaryColor,
        child: const Text("완료"),
      ),
    );
  }
}
