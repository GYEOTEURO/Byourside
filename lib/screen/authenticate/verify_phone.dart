// ignore_for_file: unused_local_variable, unused_element

import 'package:byourside/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:byourside/screen/authenticate/otp_screen.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

GlobalKey<FormState> _formKey_phone = GlobalKey<FormState>();

// change to 개인정보처리방침
final Uri _url = Uri.parse('https://sites.google.com/view/gyeoteuro');

Future<void> _launchUrl() async {
  if (!await launchUrl(_url)) {
    throw 'Could not launch $_url';
  }
}

class VerifyPhone extends StatefulWidget {
  const VerifyPhone({super.key});

  @override
  _VerifyPhoneState createState() => _VerifyPhoneState();
}

class _VerifyPhoneState extends State<VerifyPhone> {
  final TextEditingController _controller = TextEditingController();
  bool doesDocExist = true;

  bool isNumeric(String s) {
    // ignore: unnecessary_null_comparison
    if (s == null) {
      return false;
    }
    return double.tryParse(s) != null;
  }

  Future<bool> checkDocExist(String name) async {
    var collection = FirebaseFirestore.instance.collection('phoneNumList');
    var doc = await collection.doc(name).get();
    return doc.exists;
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    // final linkButton = ElevatedButton(
    //     style: ButtonStyle(
    //         backgroundColor: MaterialStateProperty.all(primaryColor)),
    //     onPressed: () {
    //       HapticFeedback.lightImpact(); // 약한 진동
    //       Navigator.push(context,
    //           MaterialPageRoute(builder: (context) => const PersonalData()));
    //     },
    //     child: Text(
    //       '개인정보처리방침',
    //       semanticsLabel: '개인정보처리방침',
    //       style: TextStyle(fontSize: 17),
    //     ));

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          title: const Text("휴대폰 인증",
              semanticsLabel: "휴대폰 인증",
              style: TextStyle(
                  fontFamily: 'NanumGothic', fontWeight: FontWeight.bold)),
          backgroundColor: Theme.of(context).primaryColor,
          leading: IconButton(
              icon: const Icon(Icons.arrow_back,
                  semanticLabel: "뒤로 가기", color: Colors.white),
              onPressed: () {
                Navigator.pop(context);
              }),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Padding(
                padding: EdgeInsets.fromLTRB(0, 10, 20, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "2/4 단계",
                      semanticsLabel: "2/4 단계",
                      style: TextStyle(
                          color: primaryColor,
                          fontSize: 20,
                          fontFamily: 'NanumGothic',
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
              SizedBox(height: height * 0.02),
              Container(
                child: const Center(
                  child: Text(
                    '휴대폰 번호 입력',
                    semanticsLabel: '휴대폰 번호 입력',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      fontFamily: 'NanumGothic',
                    ),
                  ),
                ),
              ),
              SizedBox(height: height * 0.01),
              Container(
                child: const Center(
                  child: Text(
                    '맨앞 0을 제외하고 10자리를 입력하세요.',
                    semanticsLabel: '맨앞 0을 제외하고 10자리를 입력하세요.',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      fontFamily: 'NanumGothic',
                    ),
                  ),
                ),
              ),
              SizedBox(height: height * 0.01),
              Form(
                  key: _formKey_phone,
                  child: Container(
                    margin: const EdgeInsets.only(top: 40, right: 20, left: 20),
                    child: Semantics(
                        container: true,
                        textField: true,
                        label: '휴대폰 번호를 입력하세요.',
                        hint: '(예: 1012345678)',
                        child: TextFormField(
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Theme.of(context).primaryColor),
                                  borderRadius: BorderRadius.circular(20)),
                              errorBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Color.fromARGB(255, 255, 45, 45)),
                                  borderRadius: BorderRadius.circular(20)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Theme.of(context).primaryColor),
                                  borderRadius: BorderRadius.circular(20)),
                              labelText: "휴대폰 번호를 입력하세요.",
                              hintText: '(예: 1012345678)',
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
                              prefix: const Padding(
                                padding: EdgeInsets.all(5),
                                child: Text(
                                  '+82',
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontFamily: 'NanumGothic',
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                            autofocus: true,
                            maxLength: 10,
                            keyboardType: TextInputType.number,
                            controller: _controller,
                            validator: (value) {
                              if (value != null) {
                                if (value.split(' ').first != '' &&
                                    value.isNotEmpty &&
                                    isNumeric(value)) {
                                  return null;
                                }
                                return '유효한 전화번호를 입력하세요. 숫자만 입력 가능합니다.';
                              }
                              return null;
                            })),
                  )),
              // SizedBox(height: height * 0.01),
              // linkButton,
              SizedBox(height: height * 0.02),
              Container(
                margin: const EdgeInsets.all(20),
                width: double.infinity,
                child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(primaryColor)),
                    onPressed: () async {
                      HapticFeedback.lightImpact(); // 약한 진동
                      if (_formKey_phone.currentState!.validate()) {
                        doesDocExist = await checkDocExist(_controller.text);

                        if (doesDocExist == true) {
                          if (mounted) {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                      semanticLabel:
                                          "이미 가입된 번호입니다. 돌아가려면 하단의 확인 버튼을 눌러주세요.",
                                      content: const Text(
                                        '이미 가입된 번호입니다.',
                                        semanticsLabel: '이미 가입된 번호입니다.',
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
                                              HapticFeedback
                                                  .lightImpact(); // 약한 진동
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
                        } else {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  OTPScreen(_controller.text)));
                        }
                      }
                    },
                    child: const Text(
                      '동의하고 인증',
                      semanticsLabel: '동의하고 인증',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontFamily: 'NanumGothic',
                          fontWeight: FontWeight.w500),
                    )),
              ),
              SizedBox(height: height * 0.02),
            ],
          ),
        ));
  }
}
