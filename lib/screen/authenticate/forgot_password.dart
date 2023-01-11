// ignore_for_file: library_private_types_in_public_api

import 'package:byourside/main.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});
  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPassword> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        centerTitle: true,
        elevation: 0,
        title: const Text('비밀번호 변경',
            semanticsLabel: "비밀번호 변경",
            style: TextStyle(
                fontFamily: 'NanumGothic', fontWeight: FontWeight.bold)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                '비밀번호를 재설정할 이메일을 입력하세요.',
                semanticsLabel:
                    "비밀번호를 재설정할 이메일을 입력하세요.", //semanticLabel 속성 추가하기

                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 24,
                    color: primaryColor,
                    fontFamily: 'NanumGothic',
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(height: height * 0.01),
              TextFormField(
                controller: emailController,
                autofocus: true,
                cursorColor: primaryColor,
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Theme.of(context).primaryColor),
                      borderRadius: BorderRadius.circular(20)),
                  errorBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.red),
                      borderRadius: BorderRadius.circular(20)),
                  focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Theme.of(context).primaryColor),
                      borderRadius: BorderRadius.circular(20)),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(32.0)),
                  focusColor: primaryColor,
                  contentPadding:
                      const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                  hintText: "(예: abcd@google.com)",
                  labelText: "이메일을 입력하세요. (\".com\"으로 끝나는 메일만 가능합니다)",
                  hintStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 17,
                      fontFamily: 'NanumGothic',
                      fontWeight: FontWeight.w500),
                  labelStyle: TextStyle(
                      color: primaryColor,
                      fontSize: 17,
                      fontFamily: 'NanumGothic',
                      fontWeight: FontWeight.w500),
                ),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (email) =>
                    email != null && !EmailValidator.validate(email)
                        ? '유효한 이메일을 입력하세요.'
                        : null,
              ),
              SizedBox(height: height * 0.01),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                    minimumSize: Size.fromHeight(height * 0.06),
                    backgroundColor: primaryColor),
                icon: const Icon(Icons.email_outlined, semanticLabel: "메일"),
                label: const Text(
                  '비밀번호 재설정',
                  style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'NanumGothic',
                      fontWeight: FontWeight.w500),
                  semanticsLabel: "비밀번호 재설정",
                ),
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    verifyEmail();
                  }
                  HapticFeedback.lightImpact(); // 약한 진동
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Future verifyEmail() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailController.text.trim());
      Navigator.of(context).pop();
    } on FirebaseAuthException catch (e) {
      print(e);
      Navigator.of(context).pop();
    }
  }
}
