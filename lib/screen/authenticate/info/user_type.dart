import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:byourside/main.dart';

class SetupUser extends StatefulWidget {
  const SetupUser({Key? key}) : super(key: key);

  @override
  _SetupUserState createState() => _SetupUserState();
}

class _SetupUserState extends State<SetupUser> {
  String selectedOption = '';

  PreferredSizeWidget buildAppBar(BuildContext context) {
    return AppBar(
      centerTitle: true,
      elevation: 0,
      title: const Text(
        '프로필을 완성해주세요',
        semanticsLabel: '프로필을 완성해주세요',
        style: TextStyle(
          fontFamily: 'NanumGothic',
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: primaryColor,
    );
  }

  Widget buildButton(BuildContext context, String text) {
    return Expanded(
      child: Material(
        elevation: 5.0,
        borderRadius: BorderRadius.circular(20.0),
        color: Theme.of(context).primaryColor,
        child: MaterialButton(
          padding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          onPressed: () {
            HapticFeedback.lightImpact(); // 약한 진동
            setState(() {
              selectedOption = text;
            });
          },
          child: Text(
            text,
            semanticsLabel: text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontFamily: 'NanumGothic',
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      buildButton(context, '장애 아동 보호자'),
                      buildButton(context, '장애인'),
                      buildButton(context, '종사자'),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Selected option: $selectedOption',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
