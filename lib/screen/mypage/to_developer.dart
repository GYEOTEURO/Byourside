import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ToDeveloper extends StatefulWidget {
  const ToDeveloper({super.key});

  @override
  State<ToDeveloper> createState() => _ToDeveloperState();
}

class _ToDeveloperState extends State<ToDeveloper> {
  late String uid;
  late String displayName;
  User? user;

  final TextEditingController _message = TextEditingController();
  final _formkey = GlobalKey<FormState>();

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
        title: const Text(
          "개발자에게 문의하기",
          semanticsLabel: '개발자에게 문의하기',
          style:
              TextStyle(fontFamily: 'NanumGothic', fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF045558),
        leading: IconButton(
          onPressed: () {
            HapticFeedback.lightImpact(); // 약한 진동
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            semanticLabel: '뒤로가기',
          ),
          color: Colors.white,
        ),
      ),
      body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SingleChildScrollView(
              padding: const EdgeInsets.all(30),
              child: Form(
                  key: _formkey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      const Text("'곁'이 더 성장할 수 있도록 개발자들에게 소중한 의견을 남겨주세요!",
                          semanticsLabel:
                              "'곁'이 더 성장할 수 있도록 개발자들에게 소중한 의견을 남겨주세요!",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                              fontFamily: 'NanumGothic')),
                      const SizedBox(height: 30),
                      Semantics(
                          label: "문의할 사항을 남겨주세요",
                          child: TextFormField(
                              autofocus: true,
                              controller: _message,
                              style: const TextStyle(
                                  fontFamily: 'NanumGothic',
                                  fontWeight: FontWeight.w600),
                              minLines: 3,
                              maxLines: 8,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "문의할 사항은 비어있을 수 없습니다";
                                }
                                return null;
                              },
                              decoration: const InputDecoration(
                                labelText: '문의할 사항을 남겨주세요',
                                hintText:
                                    '문의할 사항을 남겨주세요. 불편한 점과 응원의 메시지 등 자유롭게 작성해주세요.',
                                focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(4)),
                                  borderSide: BorderSide(
                                      width: 2, color: Color(0xFF045558)),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
                                  borderSide: BorderSide(
                                      width: 1, color: Color(0xFF045558)),
                                ),
                                labelStyle: TextStyle(color: Color(0xFF045558)),
                              ))),
                    ],
                  )))),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF045558),
        child: const Icon(
          Icons.navigate_next,
          semanticLabel: '문의 사항 전송 후, 마이 페이지로 이동',
        ),
        onPressed: () {
          HapticFeedback.lightImpact(); // 약한 진동
          if (_formkey.currentState!.validate()) {
            sendMsg2dev(displayName, _message.text);
            Navigator.pop(context);
          }
        },
      ),
    );
  }
}
