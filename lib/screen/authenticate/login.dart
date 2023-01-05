import 'package:byourside/main.dart';
import 'package:byourside/model/login_user.dart';
import 'package:byourside/screen/authenticate/forgot_password.dart';
import 'package:byourside/widget/auth.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Login extends StatefulWidget {
  final Function? toggleView;
  const Login({super.key, this.toggleView});

  @override
  State<StatefulWidget> createState() {
    return _Login();
  }
}

class _Login extends State<Login> {
  bool _obscureText = true;

  final _email = TextEditingController();
  final _password = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final emailField = TextFormField(
        controller: _email,
        autofocus: false,
        validator: (value) => value != null && !EmailValidator.validate(value)
            ? '유효한 이메일을 입력하세요.'
            : null,
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            hintText: "(예: abcd@google.com)",
            labelText: "이메일을 입력하세요. (\".com\"으로 끝나는 메일만 가능합니다)",
            hintStyle: TextStyle(color: Colors.grey, fontSize: 17),
            labelStyle: TextStyle(color: primaryColor, fontSize: 17),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))));

    final passwordField = TextFormField(
        obscureText: _obscureText,
        controller: _password,
        autofocus: false,
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return '필수 입력란';
          }
          if (value.trim().length < 8) {
            return '비밀번호는 8자 이상으로 구성해야합니다.';
          }
          // Return null if the entered password is valid
          return null;
        },
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            hintText: "(예: 12345678)",
            labelText: "비밀번호를 입력하세요. (8자리 이상이어야 합니다)",
            hintStyle: TextStyle(color: Colors.grey, fontSize: 17),
            labelStyle: TextStyle(color: primaryColor, fontSize: 17),
            suffixIcon: IconButton(
              icon: Icon(
                _obscureText ? Icons.visibility : Icons.visibility_off,
                semanticLabel: "비밀번호 보기",
              ),
              onPressed: () {
                setState(() {
                  _obscureText = !_obscureText;
                });
              },
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(32.0),
            )));

    final registerButton = TextButton(
        onPressed: () {
          widget.toggleView!();
        },
        child: const Text('회원가입',
            style: TextStyle(color: primaryColor, fontSize: 17)));

    final forgotPassword = TextButton(
        onPressed: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => ForgotPassword(),
            )),
        child: const Text('비밀번호 찾기',
            style: TextStyle(color: primaryColor, fontSize: 17)));

    final loginEmailPasswordButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Theme.of(context).primaryColor,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () async {
          HapticFeedback.lightImpact(); // 약한 진동
          if (_formKey.currentState!.validate()) {
            dynamic result = await _auth.signInEmailPassword(
                LoginUser(email: _email.text, password: _password.text));
            if (result.uid == null) {
              //null means unsuccessfull authentication
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      content: Text("재시도하세요. 오류 : ${result.code}",
                          style: TextStyle(color: Colors.black, fontSize: 17)),
                    );
                  });
            }
          }
        },
        child: Text(
          "로그인",
          style: TextStyle(
              color: Theme.of(context).primaryColorLight, fontSize: 17),
          textAlign: TextAlign.center,
        ),
      ),
    );

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        titleTextStyle: TextStyle(fontSize: height * 0.04),
        title: const Text('로그인'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: height * 0.03),
                  emailField,
                  SizedBox(height: height * 0.04),
                  passwordField,
                  SizedBox(height: height * 0.01),
                  registerButton,
                  SizedBox(height: height * 0.003),
                  forgotPassword,
                  SizedBox(height: height * 0.03),
                  loginEmailPasswordButton,
                  SizedBox(height: height * 0.02),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
