import 'package:flutter/material.dart';
import '../main.dart';
import '../size.dart';
import 'custom_text_form_field.dart';
import 'package:firebase_auth/firebase_auth.dart';


class CustomForm extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _CustomFormState();
  }
}

class _CustomFormState extends State<CustomForm> {

  final _formKey = GlobalKey<FormState>(); // 1. 글로벌 key

  late CustomTextFormField _customTextFormField;
  late bool _authenticated;

  _CustomFormState() {
    _customTextFormField = new CustomTextFormField(onSubmit, '');
    _authenticated = false;
  }
  onSubmit() {
    if(_customTextFormField.email == 'email' && _customTextFormField.password == 'password') {
      _setAuthenticated(true);
    }
  }

  void _setAuthenticated(bool auth) {
    setState(() {
      if (auth == true) {

      }
      else {

      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      // 2. 글로벌 key를 Form 태그에 연결하여 해당 key로 Form의 상태를 관리할 수 있다.
      key: _formKey,
      child: Column(
        children: [
          CustomTextFormField(onSubmit, "Email"),
          SizedBox(height: medium_gap),
          CustomTextFormField(onSubmit, "Password"),
          SizedBox(height: large_gap),
          Container(
            width: double.infinity,
            height: 55.0,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(primary: primaryColor, onPrimary: Colors.white,),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Navigator.pushNamed(context, "/home");
                  }
                },
                child: Text("로그인")),
          ),
          SizedBox(height: medium_gap),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextButton(
                style: TextButton.styleFrom(primary: primaryColor),
                onPressed: () {},
                child: Text("자동로그인"),
              ),
              TextButton(
                style: TextButton.styleFrom(primary: primaryColor),
                onPressed: () {},
                child: Text("회원가입"),
              ),
              TextButton(
                style: TextButton.styleFrom(primary: primaryColor),
                onPressed: () {},
                child: Text("아이디/비밀번호 찾기"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
