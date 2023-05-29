// ignore_for_file: unused_element

import 'package:byourside/main.dart';
import 'package:byourside/model/login_user.dart';
import 'package:byourside/screen/authenticate/personal_data.dart';
import 'package:byourside/screen/authenticate/using_policy.dart';
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

  const Register({super.key, this.toggleView});

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
      color: primaryColor,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {
          HapticFeedback.lightImpact(); // 약한 진동
          // const VerifyPhone();
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const VerifyPhone()),
          ); //Navigator.pushNamed(context, "/phone");
        },
        child: const Text(
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

    final emailField = Semantics(
        container: true,
        textField: true,
        label: '이메일', //이메일을 입력하세요. (\".com\"으로 끝나는 메일만 가능합니다)
        hint: '(예: abcd@google.com)',
        child: TextFormField(
            controller: _email,
            autofocus: true,
            validator: (value) {
              if (value != null) {
                if (value.contains('@') && value.endsWith('.com')) {
                  return null;
                }
                return '유효한 이메일 주소를 입력하세요.';
              }
              return null;
            },
            decoration: InputDecoration(
              hintText: "(예: abcd@google.com)",
              labelText: "이메일", //이메일을 입력하세요. (\".com\"으로 끝나는 메일만 가능합니다)
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
                  borderSide: const BorderSide(color: primaryColor),
                  borderRadius: BorderRadius.circular(20)),
              errorBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: Color.fromARGB(255, 255, 45, 45)),
                  borderRadius: BorderRadius.circular(20)),
              focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: primaryColor),
                  borderRadius: BorderRadius.circular(20)),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
            )));

    final passwordField = Semantics(
        container: true,
        textField: true,
        label: '비밀번호', //비밀번호를 입력하세요. (8자리 이상이어야 합니다)
        hint: '(예: 12345678)',
        child: TextFormField(
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
              hintText: "(예: 12345678)",
              labelText: "비밀번호", //비밀번호를 입력하세요. (8자리 이상이어야 합니다),
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
                  semanticLabel: "비밀번호 보기",
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

    final linkbuttonPersonal = ElevatedButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(primaryColor)),
        onPressed: () {
          // _launchUrl;
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const PersonalData()));
        },
        child: const Text(
          '개인정보처리방침',
          semanticsLabel: '개인정보처리방침',
          style: TextStyle(
              color: Colors.white,
              fontSize: 17,
              fontFamily: 'NanumGothic',
              fontWeight: FontWeight.w500),
        ));

    const age = Text(
      '만 15세 이상입니다.',
      semanticsLabel: '만 15세 이상입니다.',
      style: TextStyle(
          color: Colors.black,
          fontSize: 17,
          fontFamily: 'NanumGothic',
          fontWeight: FontWeight.w500),
    );

    final linkbuttonUsing = ElevatedButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(primaryColor)),
        onPressed: () {
          // _launchUrl;
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const UsingPolicy()));
        },
        child: const Text(
          '이용 약관',
          semanticsLabel: '이용 약관',
          style: TextStyle(
              color: Colors.white,
              fontSize: 17,
              fontFamily: 'NanumGothic',
              fontWeight: FontWeight.w500),
        ));

    final registerButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(20.0),
      color: primaryColor,
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
                          semanticLabel:
                              "이미 가입되었습니다. 약관 동의가 필요합니다. 휴대폰 인증을 진행하세요. 오류가 지속될 경우 문의해주세요. 돌아가려면 하단의 확인 버튼을 눌러주세요.",
                          content: const Text(
                            "이미 가입되었습니다.\n약관 동의가 필요합니다.\n휴대폰 인증을 진행하세요.\n오류가 지속될 경우 문의해주세요.",
                            semanticsLabel:
                                "이미 가입되었습니다.\n약관 동의가 필요합니다.\n휴대폰 인증을 진행하세요.\n오류가 지속될 경우 문의해주세요.",
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
              } else {
                _isRegister = true;
              }
            } else {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                        semanticLabel: "재시도하세요. 돌아가려면 하단의 확인 버튼을 눌러주세요.",
                        content: const Text(
                          "재시도 하세요.",
                          semanticsLabel: "재시도 하세요.",
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
          title: const Text('회원가입',
              semanticsLabel: '회원가입',
              style: TextStyle(
                  fontFamily: 'NanumGothic', fontWeight: FontWeight.bold)),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Padding(
                padding: EdgeInsets.fromLTRB(0, 10, 20, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "1/4 단계",
                      semanticsLabel: "1/4 단계",
                      style: TextStyle(
                          color: primaryColor,
                          fontSize: 20,
                          fontFamily: 'NanumGothic',
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
              Form(
                autovalidateMode: AutovalidateMode.always,
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Text(
                        "이메일을 입력하세요.",
                        semanticsLabel: "이메일을 입력하세요.",
                        style: TextStyle(
                            color: primaryColor,
                            fontSize: 17,
                            fontFamily: 'NanumGothic',
                            fontWeight: FontWeight.w600),
                      ),
                      const Text(
                        "'.com'으로 끝나는 메일만 가능합니다.",
                        semanticsLabel: "'.com'으로 끝나는 메일만 가능합니다.",
                        style: TextStyle(
                            color: primaryColor,
                            fontSize: 14,
                            fontFamily: 'NanumGothic',
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: height * 0.02),
                      emailField,
                      SizedBox(height: height * 0.02),
                      const Text(
                        "비밀번호를 입력하세요.",
                        semanticsLabel: "비밀번호를 입력하세요.",
                        style: TextStyle(
                            color: primaryColor,
                            fontSize: 17,
                            fontFamily: 'NanumGothic',
                            fontWeight: FontWeight.w600),
                      ),
                      const Text(
                        "8자리 이상이어야 합니다.",
                        semanticsLabel: "8자리 이상이어야 합니다.",
                        style: TextStyle(
                            color: primaryColor,
                            fontSize: 14,
                            fontFamily: 'NanumGothic',
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: height * 0.02),
                      passwordField,
                      txtButton,
                      SizedBox(height: height * 0.01),
                      Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                linkbuttonPersonal,
                                SizedBox(
                                  width: width * 0.05,
                                ),
                                const Text("동의",
                                    semanticsLabel: "동의",
                                    style: TextStyle(
                                        fontFamily: 'NanumGothic',
                                        fontWeight: FontWeight.w500)),
                                Checkbox(
                                  value: _personal,
                                  onChanged: (value) {
                                    setState(() {
                                      _personal = value!;
                                    });
                                  },
                                  activeColor: primaryColor,
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                linkbuttonUsing,
                                SizedBox(
                                  width: width * 0.05,
                                ),
                                const Text("동의",
                                    semanticsLabel: "동의",
                                    style: TextStyle(
                                        fontFamily: 'NanumGothic',
                                        fontWeight: FontWeight.w500)),
                                Checkbox(
                                  value: _using,
                                  onChanged: (value) {
                                    setState(() {
                                      _using = value!;
                                    });
                                  },
                                  activeColor: primaryColor,
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                age,
                                SizedBox(
                                  width: width * 0.05,
                                ),
                                const Text("동의",
                                    semanticsLabel: "동의",
                                    style: TextStyle(
                                        fontFamily: 'NanumGothic',
                                        fontWeight: FontWeight.w500)),
                                Checkbox(
                                  value: _policy,
                                  onChanged: (value) {
                                    setState(() {
                                      _policy = value!;
                                    });
                                  },
                                  activeColor: primaryColor,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: height * 0.03),
                      (_policy == false ||
                              _personal == false ||
                              _using == false)
                          ? const Text("약관에 모두 동의하셔야 가입할 수 있습니다.",
                              semanticsLabel: "약관에 모두 동의하셔야 가입할 수 있습니다.",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: 'NanumGothic',
                                  fontWeight: FontWeight.w500))
                          : registerButton,
                      SizedBox(height: height * 0.03),
                      (_isRegister == false ||
                              _policy == false ||
                              _personal == false ||
                              _using == false)
                          ? const Text("이후 휴대전화 인증이 가능합니다.",
                              semanticsLabel: "이후 휴대전화 인증이 가능합니다.",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: 'NanumGothic',
                                  fontWeight: FontWeight.w500))
                          : loginPhoneButton, //Text("$_policy, $_isRegister"), //
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
