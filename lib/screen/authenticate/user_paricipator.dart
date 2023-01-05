import 'package:byourside/main.dart';
import 'package:byourside/model/firebase_user.dart';
import 'package:byourside/screen/authenticate/verify_email.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

GlobalKey<FormState> _formKey_participator = GlobalKey<FormState>();

List<String> purposeType = ['홍보', '모집'];
String _dropdownValue = '홍보';

final TextEditingController _nickname = TextEditingController();
final TextEditingController _organizationName = TextEditingController();

class participator extends StatefulWidget {
  const participator({Key? key}) : super(key: key);

  @override
  State<participator> createState() => _participatorState();
}

class _participatorState extends State<participator> {
  bool doesDocExist = true;
  final User? user = FirebaseAuth.instance.currentUser;
  bool participator = false;
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
                content: Text('이미 존재하는 닉네임입니다. 다른 닉네임을 사용하세요.',
                    style: TextStyle(color: Colors.black, fontSize: 17)),
              );
            });
      }
    } else {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text('사용가능한 닉네임입니다.',
                  style: TextStyle(color: Colors.black, fontSize: 17)),
            );
          });
    }
    return doc.exists;
  }

  final nicknameField = Container(
      child: TextFormField(
    decoration: const InputDecoration(
      labelText: "닉네임을 입력하세요",
      hintText: "(예: 홍길동) ",
      hintStyle: TextStyle(color: Colors.grey, fontSize: 17),
      labelStyle: TextStyle(color: primaryColor, fontSize: 17),
    ),
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

  void storeParticipatorInfo(
      String? nickname, String? protectorAge, String? dropdownValue) async {
    // image url 포함해 firestore에 document 저장
    FirebaseFirestore.instance.collection('user').doc(user!.uid).set({
      "nickname": nickname,
      "protectorAge": protectorAge,
      "dropdownValue": dropdownValue,
      "groups": [],
      "profilePic": "",
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
          title: Text("세부 정보 입력"),
          titleTextStyle: TextStyle(fontSize: height * 0.04),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        body: Column(children: [
          Form(
            key: _formKey_participator,
            child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: height * 0.02),
                      nicknameField,
                      SizedBox(height: height * 0.02),
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: "개인/단체 이름",
                          hintText: "(예: 00복지관)",
                          hintStyle:
                              TextStyle(color: Colors.grey, fontSize: 17),
                          labelStyle:
                              TextStyle(color: primaryColor, fontSize: 17),
                        ),
                        controller: _organizationName,
                        validator: (value) {
                          if (value != null) {
                            if (value.split(' ').first != '' &&
                                value.isNotEmpty) {
                              return null;
                            }
                            return '필수 입력란입니다. 개인/단체 이름을 입력하세요';
                          }
                        },
                      ),
                      SizedBox(height: height * 0.02),
                      DropdownButton(
                        value: _dropdownValue,
                        items: purposeType
                            .map((String item) => DropdownMenuItem<String>(
                                  child: Text('$item',
                                      style: TextStyle(fontSize: 20)),
                                  value: item,
                                ))
                            .toList(),
                        onChanged: (dynamic newValue) {
                          setState(() {
                            _dropdownValue = newValue;
                          });
                        },
                        elevation: 8,
                      ),
                    ])),
          )
        ]),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            HapticFeedback.lightImpact(); // 약한 진동
            if (_formKey_participator.currentState!.validate()) {
              doesDocExist = await checkDocExist(_nickname.text);
              if (doesDocExist == false) {
                storeParticipatorInfo(
                    _nickname.text, _organizationName.text, _dropdownValue);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => VerifyEmail()));
              }
            }
          },
          backgroundColor: primaryColor,
          child: const Text("완료", style: TextStyle(fontSize: 17)),
        ));
  }
}