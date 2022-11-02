import 'package:byourside/screen/login_screen.dart';
import 'package:flutter/material.dart';
import '../size.dart';

class CustomTextFormField extends StatelessWidget {
  final String text;

  const CustomTextFormField(this.onSubmit, this.text);
  final VoidCallback onSubmit;

  static final TextEditingController _email = new TextEditingController();
  static final TextEditingController _pass = new TextEditingController();

  String get email => _email.text;
  String get password => _pass.text;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(text),
        SizedBox(height: small_gap),
        TextFormField(
          validator: (value) => value!.isEmpty
              ? "Please enter some text"
              : null, // 1. 값이 없으면 Please enter some text 경고 화면 표시
          obscureText:
              // 2. 해당 TextFormField가 비밀번호 입력 양식이면 **** 처리 해주기
              text == "Password" ? true : false,
          decoration: InputDecoration(
            hintText: "Enter $text",
            enabledBorder: OutlineInputBorder(
            ),
          ),
          controller: text == "Password" ? _email : _pass,
        ),
      ],
    );
  }
}
