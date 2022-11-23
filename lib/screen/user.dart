import 'package:byourside/main.dart';
import 'package:byourside/model/firebase_user.dart';
import 'package:byourside/screen/bottomNavigationBar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:byourside/main.dart';

class SetupUser extends StatefulWidget {
  const SetupUser({Key? key}) : super(key: key);

  @override
  State<SetupUser> createState() => _SetupUserState();
}

class _SetupUserState extends State<SetupUser> {
  bool isUserDataStored = false;

  final User? user = FirebaseAuth.instance.currentUser;
  final TextEditingController _nickname = TextEditingController();
  int count = 0;

  @override
  void initState() {
    super.initState();

    Future<bool> isUserDataStored = checkStored();
  }

  Future<bool> checkStored() async{
    return await checkIfDocExists(user!.uid);
  }

  Future<bool> checkIfDocExists(String docId) async {
      var collectionRef = FirebaseFirestore.instance.collection('user');

      var doc = await collectionRef.doc(docId).get();
      return doc.exists;
  }

  void storeUserInfo(String? nickname) async {
    // image url 포함해 firestore에 document 저장
    FirebaseFirestore.instance.collection('user').doc(user!.uid).set
      ({
      "nickname": nickname,
    });
    await user?.updateDisplayName(nickname);
    print(user);
    if (user != null) {
      FirebaseUser(uid: user?.uid, displayName: nickname);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: primaryColor),
      body: SingleChildScrollView(
        child: Column(
            children: [
              // 닉네임
              Container(
                  child: TextFormField(
                    decoration: InputDecoration(labelText: "닉네임을 입력하세요"),
                    controller: _nickname,
                  )),
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