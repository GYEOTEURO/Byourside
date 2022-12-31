import 'package:byourside/main.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ForgotPassword extends StatefulWidget {
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
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor,
          elevation: 0,
          title: Text('비밀번호 변경'),
        ),
        body: Padding(
          padding: EdgeInsets.all(16),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '비밀번호를 재설정할 이메일을 입력하세요.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24, color: primaryColor),
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: emailController,
                  cursorColor: primaryColor,
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                    labelText: '이메일',
                    focusColor: primaryColor,
                  ),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (email) =>
                      email != null && !EmailValidator.validate(email)
                          ? '유효한 이메일을 입력하세요.'
                          : null,
                ),
                SizedBox(height: 20),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size.fromHeight(50),
                      backgroundColor: primaryColor),
                  icon: Icon(Icons.email_outlined),
                  label: Text(
                    '비밀번호 재설정',
                    style: TextStyle(fontSize: 24),
                  ),
                  onPressed: () {
                    verifyEmail();
                  },
                )
              ],
            ),
          ),
        ),
      );

  Future verifyEmail() async {
    // showDialog(
    //     context: context,
    //     builder: (context) => Center(child: CircularProgressIndicator()),
    //     barrierDismissible: false
    // );

    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailController.text.trim());
      // Utils.showSnackBar('Password Reset Email Sent');
      // Navigator.of(context).popUntil((route) => route.isFirst);
      Navigator.of(context).pop();
    } on FirebaseAuthException catch (e) {
      print(e);
      // Utils.showSnackBar(e.message);
      Navigator.of(context).pop();
    }
  }
}
