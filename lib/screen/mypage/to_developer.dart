import 'package:byourside/widget/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class ToDeveloper extends StatefulWidget {
  const ToDeveloper({super.key});

  @override
  State<ToDeveloper> createState() => _ToDeveloperState();
}

class _ToDeveloperState extends State<ToDeveloper> {
  final AuthService _auth = new AuthService();
  late String uid;
  late String displayName;
  User? user;

  TextEditingController _message = TextEditingController();

  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser;
    uid = user!.uid;
    displayName = user!.displayName!;
  }

  void sendMsg2dev(String? userName, String messages) async {
    FirebaseFirestore.instance.collection('msg2dev').add({
      "uid": userName,
      "content": messages,
      "datetime": Timestamp.now(),
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("개발자에게 문의하기"),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
        ),
      ),
      body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SingleChildScrollView(
              padding: EdgeInsets.all(30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20),
                  Text("'곁'이 더 성장할 수 있도록 개발자들에게 소중한 의견을 남겨주세요!",
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 18)),
                  SizedBox(height: 30),
                  TextField(
                      autofocus: true,
                      controller: _message,
                      minLines: 3,
                      maxLines: 8,
                      decoration: InputDecoration(
                        labelText: '문의할 사항을 남겨주세요',
                        hintText: '문의할 사항을 남겨주세요',
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                          borderSide: BorderSide(width: 1),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(
                              width: 1, color: Theme.of(context).primaryColor),
                        ),
                        labelStyle:
                            TextStyle(color: Theme.of(context).primaryColor),
                      )),
                ],
              ))),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        child: const Icon(Icons.navigate_next),
        onPressed: () {
          sendMsg2dev(displayName, _message.text);
          Navigator.pop(context);
        },
      ),
    );
  }
}
