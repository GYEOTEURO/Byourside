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
    final linkButton = ElevatedButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(primaryColor)),
        onPressed: () {
          HapticFeedback.lightImpact(); // 약한 진동
          _launchUrl;
        },
        child: Text(
          '개인정보처리방침',
          style: TextStyle(fontSize: 17),
        ));

    return Scaffold(
      appBar: AppBar(
        title: Text(
          '휴대폰 인증',
          style: TextStyle(fontSize: 17),
        ),
        backgroundColor: primaryColor,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(padding: const EdgeInsets.all(20)),
          Column(children: [
            Container(
              child: const Center(
                child: Text(
                  '휴대폰 번호 입력',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
                ),
              ),
            ),
            Form(
                key: _formKey_phone,
                child: Container(
                  margin: EdgeInsets.only(top: 40, right: 20, left: 20),
                  child: TextFormField(
                      decoration: const InputDecoration(
                        labelText: "휴대폰 번호를 입력하세요. (맨앞 0을 제외하고 10자리 입력)",
                        hintText: '(예: 1012345678)',
                        hintStyle: TextStyle(color: Colors.grey, fontSize: 17),
                        labelStyle:
                            TextStyle(color: primaryColor, fontSize: 20),
                        prefix: Padding(
                          padding: EdgeInsets.all(5),
                          child: Text(
                            '+82',
                            style: TextStyle(fontSize: 17),
                          ),
                        ),
                      ),
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
                      }),
                ))
          ]),
          linkButton,
          Container(
            margin: EdgeInsets.all(20),
            // width: double.infinity,
            child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(primaryColor)),
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
                                content: Text('이미 가입된 번호입니다.',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 17)),
                              );
                            });
                      }
                    } else {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => OTPScreen(_controller.text)));
                    }
                  }
                },
                child: Text('동의하고 인증',
                    style: TextStyle(color: Colors.white, fontSize: 17))),
          ),
        ],
      ),
    );
  }
}
