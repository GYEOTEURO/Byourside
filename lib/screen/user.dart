import 'package:byourside/main.dart';
import 'package:byourside/model/firebase_user.dart';
import 'package:byourside/screen/bottomNavigationBar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:byourside/main.dart';

enum Select { protector, participator, someoneElse }
const List<Widget> gender = <Widget>[
  Text('man'),
  Text('woman')
];

final List<bool> _selectedProtectorGender = <bool>[false, false];
final List<bool> _selectedChildGender = <bool>[false, false];

final TextEditingController _nickname = TextEditingController();
final TextEditingController _protectorAge = TextEditingController();
final TextEditingController _kidAge = TextEditingController();
final TextEditingController _participatorName = TextEditingController();
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

  void storeUserInfo(String? nickname) async {
    // image url 포함해 firestore에 document 저장
    FirebaseFirestore.instance.collection('user').doc(user!.uid).set({
      "nickname": nickname,
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
  ));

  final protectorField = Column(
      children: <Widget>[
        TextFormField(
          decoration: InputDecoration(labelText: "put protector age"),
          controller: _protectorAge,
        ),
        // Text('Protector gender'),
        const SizedBox(height: 5),
        ToggleButtons(
          direction: Axis.horizontal,
          onPressed: (int index) {
            _selectedProtectorGender[index] = true;
          },
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          selectedBorderColor: primaryColor,
          selectedColor: Colors.white,
          fillColor: primaryColor,
          color: Colors.white,
          constraints: const BoxConstraints(
            minHeight: 40.0,
            minWidth: 80.0,
          ),
          isSelected: _selectedProtectorGender,
          children: gender,
        ),
        TextFormField(
          decoration: InputDecoration(labelText: "put child age"),
          controller: _kidAge,
        ),
        // Text('Child gender'),
        const SizedBox(height: 5),
        ToggleButtons(
          direction: Axis.horizontal,
          onPressed: (int index) {
            _selectedChildGender[index] = true;
          },
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          selectedBorderColor: primaryColor,
          selectedColor: Colors.white,
          fillColor: primaryColor,
          color: Colors.white,
          constraints: const BoxConstraints(
            minHeight: 40.0,
            minWidth: 80.0,
          ),
          isSelected: _selectedChildGender,
          children: gender,
        ),
      ]
  );

  final participatorField = Container(
      child: TextFormField(
        decoration: InputDecoration(labelText: "닉네임을 입력하세요"),
        controller: _nickname,
      ));

  final someoneElseField = Container(
      child: TextFormField(
        decoration: InputDecoration(labelText: "닉네임을 입력하세요"),
        controller: _nickname,
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
                  (protector)?protectorField:SizedBox(),
                  (participator)?participatorField:SizedBox(),
                  (someoneElse)?someoneElseField:SizedBox(),

                ],
              ),
            )
          )
          // 닉네임
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          storeUserInfo(_nickname.text);
          Navigator.of(context).popUntil((_) => count++ >= 3);
        },
        backgroundColor: primaryColor,
        child: const Text("완료"),
      ),
    );
  }
}
