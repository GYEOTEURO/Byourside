import 'package:byourside/main.dart';
import 'package:byourside/model/field_validator.dart';
import 'package:byourside/model/login_user.dart';
import 'package:byourside/screen/authenticate/native_login/forgot_password.dart';
import 'package:byourside/model/auth.dart';
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
    var emailField = Semantics(
        container: true,
        textField: true,
        label: '이메일', //이메일을 입력하세요. (\".com\"으로 끝나는 메일만 가능합니다)
        hint: '(예: abcd@google.com)',
        child: TextFormField(
            controller: _email,
            autofocus: true,
              validator: FieldValidator.validateEmail, // Email validation remains the same
            decoration: InputDecoration(
              floatingLabelStyle: const TextStyle(
                  color: primaryColor,
                  fontSize: 22,
                  fontFamily: 'NanumGothic',
                  fontWeight: FontWeight.w500),
              errorStyle: const TextStyle(
                  color: Color.fromARGB(255, 255, 45, 45),
                  fontSize: 17,
                  fontFamily: 'NanumGothic',
                  fontWeight: FontWeight.w500),
              contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
              hintText: '(예: abcd@google.com)',
              labelText: '이메일', //이메일을 입력하세요. (\".com\"으로 끝나는 메일만 가능합니다)
              hintStyle: const TextStyle(
                  color: Colors.grey,
                  fontSize: 17,
                  fontFamily: 'NanumGothic',
                  fontWeight: FontWeight.w500),
              labelStyle: const TextStyle(
                  color: primaryColor,
                  fontSize: 17,
                  fontFamily: 'NanumGothic',
                  fontWeight: FontWeight.w500),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Theme.of(context).primaryColor),
                  borderRadius: BorderRadius.circular(20)),
              errorBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: Color.fromARGB(255, 255, 45, 45)),
                  borderRadius: BorderRadius.circular(20)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Theme.of(context).primaryColor),
                  borderRadius: BorderRadius.circular(20)),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
            )));

    var passwordField = Semantics(
        container: true,
        textField: true,
        label: '비밀번호', //비밀번호를 입력하세요. (8자리 이상이어야 합니다)
        hint: '(예: 12345678)',
        child: TextFormField(
            obscureText: _obscureText,
            controller: _password,
            validator: FieldValidator.validatePassword,
            decoration: InputDecoration(
              floatingLabelStyle: const TextStyle(
                  color: primaryColor,
                  fontSize: 22,
                  fontFamily: 'NanumGothic',
                  fontWeight: FontWeight.w500),
              errorStyle: const TextStyle(
                  color: Color.fromARGB(255, 255, 45, 45),
                  fontSize: 17,
                  fontFamily: 'NanumGothic',
                  fontWeight: FontWeight.w500),
              contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
              hintText: '(예: 12345678)',
              labelText: '비밀번호', //비밀번호를 입력하세요. (8자리 이상이어야 합니다),
              hintStyle: const TextStyle(
                  color: Colors.grey,
                  fontSize: 17,
                  fontFamily: 'NanumGothic',
                  fontWeight: FontWeight.w500),
              labelStyle: const TextStyle(
                  color: primaryColor,
                  fontSize: 17,
                  fontFamily: 'NanumGothic',
                  fontWeight: FontWeight.w500),
              suffixIcon: IconButton(
                icon: Icon(
                  _obscureText ? Icons.visibility : Icons.visibility_off,
                  semanticLabel: _obscureText ? '활성화됨. 비밀번호 보기' : '비활성화됨. 비밀번호 보기',
                  color: primaryColor,
                ),
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
              ),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Theme.of(context).primaryColor),
                  borderRadius: BorderRadius.circular(20)),
              errorBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: Color.fromARGB(255, 255, 45, 45)),
                  borderRadius: BorderRadius.circular(20)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Theme.of(context).primaryColor),
                  borderRadius: BorderRadius.circular(20)),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
            )));

    var registerButton = TextButton(
        onPressed: () {
          widget.toggleView!();
        },
        child: const Text(
          '회원가입',
          semanticsLabel: '회원가입',
          style: TextStyle(
              color: primaryColor,
              fontSize: 17,
              fontFamily: 'NanumGothic',
              fontWeight: FontWeight.w500),
        ));

    var forgotPassword = TextButton(
        onPressed: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const ForgotPassword(),
            )),
        child: const Text(
          '비밀번호 찾기',
          semanticsLabel: '비밀번호 찾기',
          style: TextStyle(
              color: primaryColor,
              fontSize: 17,
              fontFamily: 'NanumGothic',
              fontWeight: FontWeight.w500),
        ));

    var loginEmailPasswordButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(20.0),
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
              if (!mounted) return;
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                        semanticLabel:
                            '아이디 또는 비밀번호가 일치하지 않습니다. 돌아가려면 하단의 확인 버튼을 눌러주세요.',
                        content: const Text(
                          '아이디 또는 비밀번호가 일치하지 않습니다.',
                          semanticsLabel: '아이디 또는 비밀번호가 일치하지 않습니다.',
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'NanumGothic',
                              fontWeight: FontWeight.w500),
                        ),
                        actions: [
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: primaryColor,
                              ),
                              onPressed: () {
                                HapticFeedback.lightImpact(); // 약한 진동
                                Navigator.pop(context);
                              },
                              child: const Text('확인',
                                  semanticsLabel: '확인',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: 'NanumGothic',
                                    fontWeight: FontWeight.w600,
                                  )))
                        ]);
                  });
            }
          }
        },
        child: const Text(
          '로그인',
          semanticsLabel: '로그인',
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
        title: const Text('로그인',
            semanticsLabel: '로그인',
            style: TextStyle(
                fontFamily: 'NanumGothic', fontWeight: FontWeight.bold)),
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
                  const Text(
                    '이메일을 입력하세요.',
                    semanticsLabel: '이메일을 입력하세요.',
                    style: TextStyle(
                        color: primaryColor,
                        fontSize: 22,
                        fontFamily: 'NanumGothic',
                        fontWeight: FontWeight.w600),
                  ),
                  const Text(
                    "'.com'으로 끝나는 메일만 가능합니다.",
                    semanticsLabel: "'.com'으로 끝나는 메일만 가능합니다.",
                    style: TextStyle(
                        color: primaryColor,
                        fontSize: 17,
                        fontFamily: 'NanumGothic',
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: height * 0.03),
                  emailField,
                  SizedBox(height: height * 0.04),
                  const Text(
                    '비밀번호를 입력하세요.',
                    semanticsLabel: '비밀번호를 입력하세요.',
                    style: TextStyle(
                        color: primaryColor,
                        fontSize: 22,
                        fontFamily: 'NanumGothic',
                        fontWeight: FontWeight.w600),
                  ),
                  const Text(
                    '8자리 이상이어야 합니다.',
                    semanticsLabel: '8자리 이상이어야 합니다.',
                    style: TextStyle(
                        color: primaryColor,
                        fontSize: 17,
                        fontFamily: 'NanumGothic',
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: height * 0.03),
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
