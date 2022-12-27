import 'package:byourside/main.dart';
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
  @override
  Widget build(BuildContext context) {
    final linkButton =
        ElevatedButton(onPressed: _launchUrl, child: Text('개인정보처리방침'));

    return Scaffold(
      appBar: AppBar(
        title: Text('Phone Auth'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(children: [
            Container(
              margin: EdgeInsets.only(top: 60),
              child: const Center(
                child: Text(
                  'Phone Authentication',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 40, right: 10, left: 10),
              child: TextField(
                decoration: const InputDecoration(
                  hintText: 'Phone Number',
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
            width: double.infinity,
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: primaryColor,
              ),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => OTPScreen(_controller.text)));
              },
              child: const Text(
                'Agree and Next',
                style: TextStyle(color: primaryColor),
              ),
            ),
          )
        ],
      ),
    );
  }
}
