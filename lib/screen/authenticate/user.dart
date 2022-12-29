import 'package:byourside/main.dart';
import 'package:byourside/model/firebase_user.dart';
import 'package:byourside/screen/authenticate/verify_email.dart';
import 'package:byourside/screen/bottomNavigationBar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:byourside/main.dart';

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

    // Future<bool> isUserDataStored = checkStored();
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
    });
    await user?.updateDisplayName(nickname);
    print(user);
    if (user != null) {
      FirebaseUser(uid: user?.uid, displayName: nickname);
    }
  }

  void storeParticipatorInfo(
      String? nickname, String? protectorAge, String? dropdownValue) async {
    // image url 포함해 firestore에 document 저장
    FirebaseFirestore.instance.collection('user').doc(user!.uid).set({
      "nickname": nickname,
      "protectorAge": protectorAge,
      "dropdownValue": dropdownValue
    });
    await user?.updateDisplayName(nickname);
    print(user);
    if (user != null) {
      FirebaseUser(uid: user?.uid, displayName: nickname);
    }
  }

  void storeSomeoneElseInfo(String? nickname, String? purpose) async {
    // image url 포함해 firestore에 document 저장
    FirebaseFirestore.instance
        .collection('user')
        .doc(user!.uid)
        .set({"nickname": nickname, "purpose": purpose});
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
  ));

  // final protectorField = Column(children: <Widget>[
  //   TextFormField(
  //     decoration: InputDecoration(labelText: "put protector age"),
  //     controller: _protectorAge,
  //   ),
  //   // Text('Protector gender'),
  //   const SizedBox(height: 5),
  //   Row(
  //     mainAxisAlignment: MainAxisAlignment.center,
  //     children: [
  //       Text("select protector gender"),
  //       SizedBox(width: 30,),
  //       ToggleButtons(
  //         direction: Axis.horizontal,
  //         onPressed: (int index) {
  //           _selectedProtectorGender[index] = true;
  //           _selectedProtectorGender[(1 - index).abs()] = false;
  //         },
  //         borderRadius: const BorderRadius.all(Radius.circular(8)),
  //         selectedBorderColor: primaryColor,
  //         selectedColor: Colors.white,
  //         fillColor: primaryColor,
  //         color: primaryColor,
  //         constraints: const BoxConstraints(
  //           minHeight: 40.0,
  //           minWidth: 80.0,
  //         ),
  //         isSelected: _selectedProtectorGender,
  //         children: gender,
  //       )
  //     ],
  //   ),
  //   TextFormField(
  //     decoration: InputDecoration(labelText: "put child age"),
  //     controller: _childAge,
  //   ),
  //   // Text('Child gender'),
  //   const SizedBox(height: 5),
  //   Row(
  //     mainAxisAlignment: MainAxisAlignment.center,
  //     children: [
  //       Text("select child gender"),
  //       SizedBox(width: 30,),
  //       ToggleButtons(
  //         direction: Axis.horizontal,
  //         onPressed: (int index) {
  //           _selectedChildGender[index] = true;
  //           _selectedChildGender[(1 - index).abs()] = false;
  //         },
  //         borderRadius: const BorderRadius.all(Radius.circular(8)),
  //         selectedBorderColor: primaryColor,
  //         selectedColor: Colors.white,
  //         fillColor: primaryColor,
  //         color: primaryColor,
  //         constraints: const BoxConstraints(
  //           minHeight: 40.0,
  //           minWidth: 80.0,
  //         ),
  //         isSelected: _selectedChildGender,
  //         children: gender,
  //       ),
  //     ],
  //   ),
  //   Row(
  //     mainAxisAlignment: MainAxisAlignment.center,
  //     children: [
  //       Text("select child type"),
  //       SizedBox(width: 30,),
  //       ToggleButtons(
  //         direction: Axis.horizontal,
  //         onPressed: (int index) {
  //           _selectedChildType[index] = true;
  //           _selectedChildType[(1 - index).abs()] = false;
  //         },
  //         borderRadius: const BorderRadius.all(Radius.circular(8)),
  //         selectedBorderColor: primaryColor,
  //         selectedColor: Colors.white,
  //         fillColor: primaryColor,
  //         color: primaryColor,
  //         constraints: const BoxConstraints(
  //           minHeight: 40.0,
  //           minWidth: 80.0,
  //         ),
  //         isSelected: _selectedChildType,
  //         children: type,
  //       ),
  //     ],
  //   ),
  //   Row(
  //     mainAxisAlignment: MainAxisAlignment.center,
  //     children: [
  //       Text("select child degree"),
  //       SizedBox(width: 30,),
  //       ToggleButtons(
  //         direction: Axis.horizontal,
  //         onPressed: (int index) {
  //           _selectedChildDegree[index] = true;
  //           _selectedChildDegree[(1 - index).abs()] = false;
  //         },
  //         borderRadius: const BorderRadius.all(Radius.circular(8)),
  //         selectedBorderColor: primaryColor,
  //         selectedColor: Colors.white,
  //         fillColor: primaryColor,
  //         color: primaryColor,
  //         constraints: const BoxConstraints(
  //           minHeight: 40.0,
  //           minWidth: 80.0,
  //         ),
  //         isSelected: _selectedChildDegree,
  //         children: degree,
  //       ),
  //     ],
  //   ),
  //   TextFormField(
  //     decoration: InputDecoration(labelText: "belong"),
  //     controller: _belong,
  //   ),
  // ]);

  final someoneElseField = Container(
      child: TextFormField(
    decoration: InputDecoration(labelText: "visit purpose"),
    controller: _purpose,
  ));

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
                  title: Text('child protector'),
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
                  title: Text('participator'),
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
                  title: Text('someoneElse'),
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
                          decoration:
                              InputDecoration(labelText: "put protector age"),
                          controller: _protectorAge,
                        ),
                        // Text('Protector gender'),
                        const SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("select protector gender"),
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
                          decoration:
                              InputDecoration(labelText: "put child age"),
                          controller: _childAge,
                        ),
                        // Text('Child gender'),
                        const SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("select child gender"),
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
                            Text("select child type"),
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
                            Text("select child degree"),
                            SizedBox(
                              width: 30,
                            ),
                            ToggleButtons(
                              direction: Axis.horizontal,
                              onPressed: (int index) {
                                setState(() {
                                  _selectedChildDegree[index] = true;
                                  _selectedChildDegree[(1 - index).abs()] = false;
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
                          decoration: InputDecoration(labelText: "belong"),
                          controller: _belong,
                        ),
                      ])
                    : SizedBox(),
                (participator)
                    ? Column(children: <Widget>[
                        TextFormField(
                          decoration:
                              InputDecoration(labelText: "organization name"),
                          controller: _organizationName,
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
              context,

              MaterialPageRoute(
                  builder: (context) => VerifyEmail()) );
          //Navigator.of(context).popUntil((_) => count++ >= 3);
        },
        backgroundColor: primaryColor,
        child: const Text("완료"),
      ),
    );
  }
}
