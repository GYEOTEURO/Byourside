// ignore_for_file: unused_local_variable

import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:byourside/screen/bottomNavigationBar.dart';
import 'package:byourside/main.dart';
import 'package:flutter/services.dart';

class VerifyEmail extends StatefulWidget {
  const VerifyEmail({super.key});

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
        const Duration(seconds: 3),
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
    // print(canResendEmail);
    if (FirebaseAuth.instance.currentUser != null) {
      await FirebaseAuth.instance.currentUser!.reload();
    }
    if (mounted) {
      setState(() {
        if (FirebaseAuth.instance.currentUser != null) {
          isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
        }
      });
    }

    if (isEmailVerified) timer?.cancel();
  }

  Future sendVerificationEmail() async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();
      if (mounted) setState(() => canResendEmail = false);
      // print("here");
      await Future.delayed(const Duration(seconds: 120));
      if (mounted) setState(() => canResendEmail = true);
    } catch (e) {
      if (mounted) {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                  semanticLabel:
                      "메일함을 확인하세요. 오류가 지속될 경우 문의해주세요. 돌아가려면 하단의 확인 버튼을 눌러주세요.",
                  content: const Text(
                    "메일함을 확인하세요.\n오류가 지속될 경우 문의해주세요.",
                    semanticsLabel: "메일함을 확인하세요. 오류가 지속될 경우 문의해주세요.",
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
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    if (isEmailVerified) {
      return const BottomNavBar(primaryColor: primaryColor);
    } else {
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          title: const Text("이메일 확인",
              semanticsLabel: "이메일 확인",
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
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                const Padding(
                  padding: EdgeInsets.fromLTRB(0, 30, 50, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "4/4 단계",
                        semanticsLabel: "4/4 단계",
                        style: TextStyle(
                            color: primaryColor,
                            fontSize: 20,
                            fontFamily: 'NanumGothic',
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Text(
                          '확인 이메일이 전송되었습니다.\n메일함을 확인하세요.',
                          semanticsLabel: '확인 이메일이 전송되었습니다. 메일함을 확인하세요.',
                          style: TextStyle(
                              fontSize: 24,
                              color: primaryColor,
                              fontFamily: 'NanumGothic',
                              fontWeight: FontWeight.w500),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(height: height * 0.1),
                      const SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Text(
                          '(2분 후 재전송 가능합니다)',
                          semanticsLabel: '(2분 후 재전송 가능합니다)',
                          style: TextStyle(
                              fontSize: 17,
                              color: primaryColor,
                              fontFamily: 'NanumGothic',
                              fontWeight: FontWeight.w500),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(height: height * 0.1),
                      canResendEmail
                          ? SizedBox(
                              width: double.infinity,
                              child: ElevatedButton.icon(
                                  style: ElevatedButton.styleFrom(
                                      minimumSize: const Size.fromHeight(50),
                                      backgroundColor: primaryColor),
                                  icon: const Icon(
                                    Icons.email,
                                    size: 32,
                                    color: Colors.white,
                                    semanticLabel: "메일", //semanticLabel 속성 추가하기
                                  ),
                                  label: const Text(
                                    '이메일 재전송',
                                    semanticsLabel: "이메일 재전송",
                                    style: TextStyle(
                                        fontSize: 24,
                                        fontFamily: 'NanumGothic',
                                        fontWeight: FontWeight.w500),
                                  ),
                                  onPressed: (() async {
                                    HapticFeedback.lightImpact(); // 약한 진동

                                    final user =
                                        FirebaseAuth.instance.currentUser!;
                                    await user.sendEmailVerification();
                                    if (mounted) {
                                      setState(() => canResendEmail = false);
                                    }
                                    // print("ss");
                                    await Future.delayed(
                                        const Duration(seconds: 120));
                                    if (mounted) {
                                      setState(() => canResendEmail = true);
                                    }
                                  })))
                          : SizedBox(
                              height: height * 0.03,
                            ),
                      SizedBox(height: height * 0.03),
                      TextButton(
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size.fromHeight(50),
                          ),
                          child: const Text(
                            '취소',
                            semanticsLabel: '취소',
                            style: TextStyle(
                                fontSize: 24,
                                color: primaryColor,
                                fontFamily: 'NanumGothic',
                                fontWeight: FontWeight.w500),
                          ),
                          onPressed: () {
                            HapticFeedback.lightImpact(); // 약한 진동
                            Navigator.pop(context);
                            // Navigator.of(context)
                            //     .popUntil((route) => route.isFirst);

                            // FirebaseAuth.instance.signOut();
                            // Navigator.of(context)
                            //     .popUntil((route) => route.isFirst);
                          })
                    ],
                  ),
                ),
              ])
            ])),
      );
    }
  }
}
