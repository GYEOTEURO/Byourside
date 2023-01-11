import 'package:byourside/main.dart';
import 'package:byourside/model/login_user.dart';
import 'package:byourside/screen/authenticate/personal_data.dart';
import 'package:byourside/screen/authenticate/verify_phone.dart';
import 'package:byourside/widget/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

// change to 개인정보처리방침
final Uri _url = Uri.parse('https://sites.google.com/view/gyeoteuro');

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
  bool _personal = false;
  bool _using = false;
  bool _policy = false;
  bool _obscureText = true;
  bool _isRegister = false;
  final _email = TextEditingController();
  final _password = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final loginPhoneButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(20.0),
      color: Theme.of(context).primaryColor,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {
          HapticFeedback.lightImpact(); // 약한 진동
          // const VerifyPhone();
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => VerifyPhone()),
          ); //Navigator.pushNamed(context, "/phone");
        },
        child: Text(
          "휴대폰 인증",
          semanticsLabel: "휴대폰 인증",
          style: TextStyle(
              color: Colors.white,
              fontSize: 17,
              fontFamily: 'NanumGothic',
              fontWeight: FontWeight.w500),
          textAlign: TextAlign.center,
        ),
      ),
    );

    final emailField = TextFormField(
        controller: _email,
        autofocus: true,
        validator: (value) {
          if (value != null) {
            if (value.contains('@') && value.endsWith('.com')) {
              return null;
            }
            return '유효한 이메일 주소를 입력하세요.';
          }
        },
        style: const TextStyle(
            color: Colors.black,
            fontSize: 17,
            fontFamily: 'NanumGothic',
            fontWeight: FontWeight.w500),
        decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Theme.of(context).primaryColor),
                borderRadius: BorderRadius.circular(20)),
            errorBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.red),
                borderRadius: BorderRadius.circular(20)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Theme.of(context).primaryColor),
                borderRadius: BorderRadius.circular(20)),
            contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            hintText: "(예: abcd@google.com)",
            labelText: "이메일을 입력하세요. (\".com\"으로 끝나야 합니다.)",
            hintStyle: TextStyle(
                color: Colors.grey,
                fontSize: 20,
                fontFamily: 'NanumGothic',
                fontWeight: FontWeight.w500),
            labelStyle: TextStyle(
                color: primaryColor,
                fontSize: 20,
                fontFamily: 'NanumGothic',
                fontWeight: FontWeight.w500),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(20.0))));

    final passwordField = TextFormField(
        obscureText: _obscureText,
        controller: _password,
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
        style: const TextStyle(
            color: Colors.black,
            fontSize: 17,
            fontFamily: 'NanumGothic',
            fontWeight: FontWeight.w500),
        decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Theme.of(context).primaryColor),
                borderRadius: BorderRadius.circular(20)),
            errorBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.red),
                borderRadius: BorderRadius.circular(20)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Theme.of(context).primaryColor),
                borderRadius: BorderRadius.circular(20)),
            contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            hintText: "(예: 12345678)",
            labelText: "비밀번호를 입력하세요. (8자리 이상이어야 합니다)",
            hintStyle: TextStyle(
                color: Colors.grey,
                fontSize: 20,
                fontFamily: 'NanumGothic',
                fontWeight: FontWeight.w500),
            labelStyle: TextStyle(
                color: primaryColor,
                fontSize: 20,
                fontFamily: 'NanumGothic',
                fontWeight: FontWeight.w500),
            suffixIcon: IconButton(
              icon: Icon(
                _obscureText ? Icons.visibility : Icons.visibility_off,
                semanticLabel: "비밀번호 보기",
              ),
              onPressed: () {
                HapticFeedback.lightImpact(); // 약한 진동
                setState(() {
                  _obscureText = !_obscureText;
                });
              },
            ),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(20.0))));

    final txtButton = TextButton(
        onPressed: () {
          HapticFeedback.lightImpact(); // 약한 진동
          FirebaseAuth.instance.currentUser?.delete();
          widget.toggleView!();
        },
        child: const Text(
          '로그인 페이지로 돌아가기',
          semanticsLabel: "로그인 페이지로 돌아가기",
          style: TextStyle(
              color: primaryColor,
              fontSize: 17,
              fontFamily: 'NanumGothic',
              fontWeight: FontWeight.w500),
        ));

    final linkButton = ElevatedButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(primaryColor)),
        onPressed: () {
          // _launchUrl;
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const PersonalData()));
        },
        child: Text(
          '개인정보처리방침',
          semanticsLabel: '개인정보처리방침',
          style: TextStyle(
              color: Colors.white,
              fontSize: 17,
              fontFamily: 'NanumGothic',
              fontWeight: FontWeight.w500),
        ));

    final registerButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(20.0),
      color: Theme.of(context).primaryColor,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () async {
          HapticFeedback.lightImpact(); // 약한 진동
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
                        content: Text(
                          result.code,
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'NanumGothic',
                              fontWeight: FontWeight.w500),
                        ),
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
                      content: Text(
                        "재시도 하세요.",
                        semanticsLabel: "재시도 하세요.",
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'NanumGothic',
                            fontWeight: FontWeight.w500),
                      ),
                    );
                  });
            }
          }
        },
        child: Text(
          "동의하고 회원가입",
          semanticsLabel: "동의하고 회원가입",
          style: TextStyle(
              color: Colors.white,
              fontSize: 17,
              fontFamily: 'NanumGothic',
              fontWeight: FontWeight.w500),
          textAlign: TextAlign.center,
        ),
      ),
    );

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          '회원가입',
          semanticsLabel: '회원가입',
        ),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Form(
            autovalidateMode: AutovalidateMode.always,
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
                  txtButton,
                  SizedBox(height: height * 0.003),
                  Row(
                    children: [
                      linkButton,
                      Checkbox(
                        value: _personal,
                        onChanged: (value) {
                          setState(() {
                            _personal = value!;
                          });
                        },
                      ),
                      // SizedBox(
                      //   height: height * 0.01,
                      // ),
                      // Switch(
                      //   value: _personal,
                      //   onChanged: (value) {
                      //     setState(() {
                      //       _personal = value!;
                      //     });
                      //   },
                      // )
                    ],
                  ),
                  SizedBox(height: height * 0.02),
                  registerButton,
                  SizedBox(height: height * 0.02),
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
