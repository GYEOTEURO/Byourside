import 'package:byourside/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:byourside/screen/authenticate/otp_screen.dart';
import 'package:url_launcher/url_launcher.dart';

// change to 개인정보처리방침
final Uri _url = Uri.parse('https://flutter.dev');

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
        onPressed: _launchUrl,
        child: Text('개인정보처리방침'));

    return Scaffold(
      appBar: AppBar(
        title: Text('휴대폰 인증'),
        backgroundColor: primaryColor,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(children: [
            Container(
              margin: EdgeInsets.only(top: 60),
              child: const Center(
                child: Text(
                  '휴대폰 번호 입력',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 40, right: 10, left: 10),
              child: TextField(
                decoration: const InputDecoration(
                  hintText: '휴대폰 번호',
                  prefix: Padding(
                    padding: EdgeInsets.all(4),
                    child: Text('+82'),
                  ),
                ),
                maxLength: 10,
                keyboardType: TextInputType.number,
                controller: _controller,
              ),
            )
          ]),
          linkButton,
          Container(
            margin: EdgeInsets.all(10),
            // width: double.infinity,
            child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(primaryColor)),
                onPressed: () async {
                  doesDocExist = await checkDocExist(_controller.text);
                  if (doesDocExist == true) {
                    if (mounted) {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              content: Text('이미 가입된 번호입니다.'),
                            );
                          });
                    }
                  } else {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => OTPScreen(_controller.text)));
                  }
                },
                child: Text('동의하고 인증', style: TextStyle(color: Colors.white))),
          ),
        ],
      ),
    );
  }
}
