import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:byourside/screen/bottomNavigationBar.dart';
import 'package:byourside/main.dart';

class VerifyEmail extends StatefulWidget {
  @override
  _VerifyEmailState createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {
  bool isEmailVerified = false;
  bool canResendEmail = false;
  Timer? timer;

  @override
  void initState() {
    super.initState();

    // user needs to be created before
    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;

    if (!isEmailVerified) {
      sendVerificationEmail();

      timer = Timer.periodic(
        Duration(seconds: 3),
        (_) => checkEmailVerified(),
      );
    }
  }

  @override
  void dispose() {
    timer?.cancel();

    super.dispose();
  }

  Future checkEmailVerified() async {
    // call after email verification
    if (await FirebaseAuth.instance.currentUser != null) {
      await FirebaseAuth.instance.currentUser!.reload();
    }
    setState(() {
      if (FirebaseAuth.instance.currentUser != null) {
        isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
      }
    });

    if (isEmailVerified) timer?.cancel();
  }

  Future sendVerificationEmail() async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();
      if (user != null) {
        setState(() => canResendEmail = false);
        await Future.delayed(Duration(seconds: 60));
        setState(() => canResendEmail = true);
      }
    } catch (e) {
      if (mounted) {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: Text(e.toString()),
              );
            });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    print(isEmailVerified);
    if (isEmailVerified) {
      return BottomNavBar(primaryColor: primaryColor);
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text('이메일 확인'),
          backgroundColor: primaryColor,
        ),
        body: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '확인 이메일이 전송되었습니다. 메일함을 확인하세요',
                style: TextStyle(fontSize: 20, color: primaryColor),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 24),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size.fromHeight(50),
                ),
                icon: Icon(Icons.email, size: 32),
                label: Text(
                  '이메일 재전송',
                  style: TextStyle(fontSize: 24),
                ),
                onPressed: canResendEmail ? sendVerificationEmail : null,
              ),
              SizedBox(height: 8),
              TextButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size.fromHeight(50),
                  ),
                  child: Text(
                    '취소',
                    style: TextStyle(fontSize: 24, color: primaryColor),
                  ),
                  onPressed: () {
                    Navigator.of(context).popUntil((route) => route.isFirst);

                    FirebaseAuth.instance.signOut();
                    Navigator.of(context).popUntil((route) => route.isFirst);
                  })
            ],
          ),
        ),
      );
    }
  }
}
