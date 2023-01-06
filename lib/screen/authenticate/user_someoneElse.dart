import 'package:byourside/main.dart';
import 'package:byourside/model/firebase_user.dart';
import 'package:byourside/screen/authenticate/verify_email.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
                content: Text('이미 존재하는 닉네임입니다. 다른 닉네임을 사용하세요.',
                    semanticsLabel: '이미 존재하는 닉네임입니다. 다른 닉네임을 사용하세요.',
                    style: TextStyle(color: Colors.black)),
              );
            });
      }
    } else {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text('사용가능한 닉네임입니다.',
                  semanticsLabel: '사용가능한 닉네임입니다.',
                  style: TextStyle(color: Colors.black)),
            );
          });
    }
    return doc.exists;
  }

  final someoneElseField = Container(
      child: TextFormField(
    decoration: InputDecoration(
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: primaryColor),
          borderRadius: BorderRadius.circular(20)),
      errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red),
          borderRadius: BorderRadius.circular(20)),
      focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: primaryColor),
          borderRadius: BorderRadius.circular(20)),
      labelText: "방문 목적",
      hintText: "(예: 자녀 장애 초기증상 판별)",
      hintStyle: TextStyle(color: Colors.grey, fontSize: 17),
      labelStyle: TextStyle(color: primaryColor, fontSize: 17),
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
    decoration: InputDecoration(
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: primaryColor),
          borderRadius: BorderRadius.circular(20)),
      errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red),
          borderRadius: BorderRadius.circular(20)),
      focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: primaryColor),
          borderRadius: BorderRadius.circular(20)),
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
          title: Text(
            "세부 정보 입력",
            semanticsLabel: "세부 정보 입력",
          ),
          titleTextStyle: TextStyle(fontSize: height * 0.03),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(children: [
            Form(
              key: _formKey_someoneELse,
              child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: height * 0.03),
                        nicknameField,
                        SizedBox(height: height * 0.03),
                        someoneElseField
                      ])),
            )
          ]),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            HapticFeedback.lightImpact(); // 약한 진동
            if (_formKey_someoneELse.currentState!.validate() &&
                _purpose.text != null &&
                _purpose.text != '') {
              doesDocExist = await checkDocExist(_nickname.text);
              if (doesDocExist == false) {
                storeSomeoneElseInfo(_nickname.text, _purpose.text);
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
            style: TextStyle(fontSize: 17),
          ),
        ));
  }
}
