import 'package:byourside/main.dart';
import 'package:byourside/model/login_user.dart';
import 'package:byourside/screen/authenticate/verify_phone.dart';
import 'package:byourside/widget/auth.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

// change to 개인정보처리방침
final Uri _url = Uri.parse('https://flutter.dev');

Future<void> _launchUrl() async {
  if (!await launchUrl(_url)) {
    throw '$_url을 열 수 없습니다.';
  }
}

class Register extends StatefulWidget {
  final Function? toggleView;

  Register({this.toggleView});

  @override
  State<StatefulWidget> createState() {
    return _Register();
  }
}

class _Register extends State<Register> {
  final AuthService _auth = AuthService();

  bool _obscureText = true;
  bool _isRegister = false;
  final _email = TextEditingController();
  final _password = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final loginPhoneButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Theme.of(context).primaryColor,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {
          // const VerifyPhone();
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => VerifyPhone()),
          ); //Navigator.pushNamed(context, "/phone");
        },
        child: Text(
          "휴대폰 인증",
          style: TextStyle(color: Theme.of(context).primaryColorLight),
          textAlign: TextAlign.center,
        ),
      ),
    );

    final emailField = TextFormField(
        controller: _email,
        autofocus: false,
        validator: (value) {
          if (value != null) {
            if (value.contains('@') && value.endsWith('.com')) {
              return null;
            }
            return '유효한 이메일 주소를 입력하세요.';
          }
        },
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            hintText: "이메일",
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
            hintText: "비밀번호",
            suffixIcon: IconButton(
              icon:
                  Icon(_obscureText ? Icons.visibility : Icons.visibility_off),
              onPressed: () {
                setState(() {
                  _obscureText = !_obscureText;
                });
              },
            ),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))));

    final txtButton = TextButton(
        onPressed: () {
          widget.toggleView!();
        },
        child:
            const Text('로그인 페이지로 돌아가기', style: TextStyle(color: primaryColor)));

    final linkButton = ElevatedButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(primaryColor)),
        onPressed: _launchUrl,
        child: Text('개인정보처리방침'));

    final registerButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Theme.of(context).primaryColor,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            dynamic result = await _auth.registerEmailPassword(LoginUser(
              email: _email.text,
              password: _password.text,
            ));
            if (result != null) {
              if (result.uid == null) {
                //null means unsuccessfull authentication
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        content: Text(result.code),
                      );
                    });
              } else {
                _isRegister = true;
              }
            } else {
              showDialog(
                  context: context,
                  builder: (context) {
                    return const AlertDialog(
                      content: Text("재시도 하세요."),
                    );
                  });
            }
          }
        },
        child: Text(
          "동의하고 회원가입",
          style: TextStyle(color: Theme.of(context).primaryColorLight),
          textAlign: TextAlign.center,
        ),
      ),
    );

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('회원가입'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Form(
            autovalidateMode: AutovalidateMode.always,
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const SizedBox(height: 45.0),
                  emailField,
                  const SizedBox(height: 25.0),
                  passwordField,
                  const SizedBox(height: 25.0),
                  txtButton,
                  linkButton,
                  const SizedBox(height: 35.0),
                  registerButton, //(_authProvider.phoneNum==null)?SizedBox():
                  const SizedBox(height: 15.0),
                  (_isRegister == false) ? SizedBox() : loginPhoneButton,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
