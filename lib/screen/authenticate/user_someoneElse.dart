import 'package:byourside/main.dart';
import 'package:byourside/model/firebase_user.dart';
import 'package:byourside/screen/authenticate/verify_email.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

GlobalKey<FormState> _formKey_someoneELse = GlobalKey<FormState>();

final TextEditingController _nickname = TextEditingController();
final TextEditingController _purpose = TextEditingController();

class someoneElse extends StatefulWidget {
  const someoneElse({Key? key}) : super(key: key);

  @override
  State<someoneElse> createState() => _someoneElseState();
}

class _someoneElseState extends State<someoneElse> {
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
                content: Text('이미 존재하는 닉네임입니다. 다른 닉네임을 사용하세요.'),
              );
            });
      }
    } else {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text('사용가능한 닉네임입니다.'),
            );
          });
    }
    return doc.exists;
  }

  final someoneElseField = Container(
      child: TextFormField(
    decoration: const InputDecoration(
      labelText: "방문 목적",
      hintText: "방문 목적을 입력하세요. (예: 자녀 장애 초기증상 판별)",
      hintStyle: TextStyle(color: Colors.grey),
      labelStyle: TextStyle(color: primaryColor),
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
  ));

  final nicknameField = Container(
      child: TextFormField(
    decoration: const InputDecoration(
      labelText: "닉네임을 입력하세요",
      hintText: "닉네임을 입력하세요 (예: 홍길동) ",
      hintStyle: TextStyle(color: Colors.grey),
      labelStyle: TextStyle(color: primaryColor),
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

  void storeSomeoneElseInfo(String? nickname, String? purpose) async {
    // image url 포함해 firestore에 document 저장
    FirebaseFirestore.instance.collection('user').doc(user!.uid).set({
      "nickname": nickname,
      "purpose": purpose,
      "groups": [],
      "profilePic": "",
    });
    FirebaseFirestore.instance
        .collection('displayNameList')
        .doc('$nickname')
        .set({'current': true});
    await user?.updateDisplayName(nickname);
    print(user);
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
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          title: Text("그외 정보 입력 페이지"),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        body: Column(children: [
          Form(
            key: _formKey_someoneELse,
            child: Padding(
                padding: const EdgeInsets.all(40.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 20.0),
                      nicknameField,
                      const SizedBox(height: 20.0),
                      someoneElseField
                    ])),
          )
        ]),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            if (_formKey_someoneELse.currentState!.validate() &&
                _purpose.text != null &&
                _purpose.text != '') {
              doesDocExist = await checkDocExist(_nickname.text);
              if (doesDocExist == false) {
                storeSomeoneElseInfo(_nickname.text, _purpose.text);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => VerifyEmail()));
              }
            }
          },
          backgroundColor: primaryColor,
          child: const Text("완료"),
        ));
  }
}
