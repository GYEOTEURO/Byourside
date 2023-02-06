import 'dart:async';

import 'package:byourside/main.dart';
import 'package:byourside/model/firebase_user.dart';
import 'package:byourside/screen/authenticate/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

class OTPScreen extends StatefulWidget {
  final String phone;

  OTPScreen(this.phone);

  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final GlobalKey<ScaffoldState> _formKey = GlobalKey<ScaffoldState>();
  final TextEditingController otpCode = TextEditingController();
  bool isPhoneVerified = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Timer? timer;
  bool canResnedPhone = false;
  @override
  void initState() {
    super.initState();

    if (FirebaseAuth.instance.currentUser != null) {
      isPhoneVerified = FirebaseAuth.instance.currentUser!.phoneNumber !=
              null &&
          FirebaseAuth.instance.currentUser!.phoneNumber?.split(' ')[0] != '';
      // print("___________________________________________");
      // print(
      //     FirebaseAuth.instance.currentUser!.phoneNumber?.split(' ')[0] != '');
      // print("hjihi: $isPhoneVerified");
      // print("shsh");
      if (!isPhoneVerified) {
        verifyPhone();

        timer = Timer.periodic(
          Duration(seconds: 3),
          (_) => checkPhoneVerified(),
        );
      }
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void storePhoneNum(String? num) async {
    FirebaseFirestore.instance.collection('phoneNumList').doc('$num').set({
      "current": true,
    });
  }

  Future checkPhoneVerified() async {
    if (FirebaseAuth.instance.currentUser != null) {
      await FirebaseAuth.instance.currentUser!.reload();
      setState(() {
        isPhoneVerified =
            FirebaseAuth.instance.currentUser!.phoneNumber != null;
      });
    }
    if (isPhoneVerified) {
      timer?.cancel();
    }
  }

  FirebaseUser? _firebaseUser(User? user) {
    return user != null
        ? FirebaseUser(uid: user.uid, phoneNum: user.phoneNumber)
        : null;
  }

  Stream<FirebaseUser?> get user {
    return _auth.authStateChanges().map(_firebaseUser);
  }

  String? _verificationId;

  final defaultPinTheme = PinTheme(
    width: 56,
    height: 56,
    textStyle: TextStyle(
        fontSize: 20,
        color: primaryColor,
        fontFamily: 'NanumGothic',
        fontWeight: FontWeight.w500),
    decoration: BoxDecoration(
      border: Border.all(color: primaryColor),
      borderRadius: BorderRadius.circular(20),
    ),
  );

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    if (isPhoneVerified) {
      return SetupUser();
    } else {
      String phone1 = widget.phone.substring(0, 2);
      String phone2 = widget.phone.substring(2, 6);
      String phone3 = widget.phone.substring(
        6,
      );
      final user = Provider.of<FirebaseUser?>(context);
      return Scaffold(
          key: _formKey,
          appBar: AppBar(
            centerTitle: true,
            title: Text('OTP 인증',
                semanticsLabel: 'OTP 인증',
                style: TextStyle(
                    fontFamily: 'NanumGothic', fontWeight: FontWeight.bold)),
            backgroundColor: primaryColor,
            leading: IconButton(
                icon: Icon(Icons.arrow_back,
                    semanticLabel: "뒤로 가기", color: Colors.white),
                onPressed: () {
                  Navigator.pop(context);
                }),
          ),
          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 10, 20, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "2/4",
                        semanticsLabel: "2/4",
                        style: TextStyle(
                            color: primaryColor,
                            fontSize: 20,
                            fontFamily: 'NanumGothic',
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20),
                  child: Center(
                      child: Column(children: [
                    Text(
                      '0${phone1} ${phone2} ${phone3}로 전송된\n인증번호를 입력하세요.',
                      semanticsLabel:
                          "0${phone1} ${phone2} ${phone3}로 전송된\n인증번호를 입력하세요.",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        fontFamily: 'NanumGothic',
                      ),
                    ),
                    SizedBox(height: height * 0.05),
                    SingleChildScrollView(
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
                    SizedBox(height: height * 0.05),
                  ])),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Pinput(
                    length: 6,
                    autofocus: true,
                    defaultPinTheme: defaultPinTheme,
                    controller: otpCode,
                    pinAnimationType: PinAnimationType.fade,
                    keyboardType: TextInputType.number,
                    onSubmitted: (pin) async {
                      try {
                        final PhoneAuthCredential credential =
                            PhoneAuthProvider.credential(
                                verificationId: _verificationId!, smsCode: pin);
                        await _auth.currentUser?.updatePhoneNumber(credential);
                        storePhoneNum(widget.phone);
                        await _auth
                            .signInWithCredential(credential)
                            .then((value) async {
                          if (value.user != null) {
                            setState(() {
                              FirebaseUser(
                                  uid: value.user?.uid, phoneNum: widget.phone);
                            });
                            await FirebaseAuth.instance.currentUser!.reload();
                          }
                        });
                        await FirebaseAuth.instance.currentUser!.reload();

                        if (user?.phoneNum == null || user?.phoneNum == "") {
                          setState(() {
                            FirebaseUser(
                                uid: user?.uid, phoneNum: widget.phone);
                          });
                        }
                        if (await FirebaseAuth
                                    .instance.currentUser?.phoneNumber !=
                                null &&
                            !(user?.phoneNum == null || user?.phoneNum == "")) {
                          timer?.cancel();
                          Navigator.pop(context);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SetupUser()));
                        }
                      } catch (e) {
                        if (mounted) {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                    semanticLabel:
                                        "인증번호가 일치하지 않습니다. 재시도하세요. 돌아가려면 하단의 확인 버튼을 눌러주세요.",
                                    content: Text(
                                      "인증번호가 일치하지 않습니다.\n재시도하세요.",
                                      semanticsLabel:
                                          "인증번호가 일치하지 않습니다.\n재시도하세요.",
                                      style: const TextStyle(
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
                                          child: Text('확인',
                                              semanticsLabel: '확인',
                                              style: const TextStyle(
                                                fontSize: 14,
                                                fontFamily: 'NanumGothic',
                                                fontWeight: FontWeight.w600,
                                              )))
                                    ]);
                              });
                        }
                      }
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    margin: EdgeInsets.all(20),
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(primaryColor),
                      ),
                      onPressed: () async {
                        HapticFeedback.lightImpact(); // 약한 진동
                        String pin = otpCode.text.toString();
                        try {
                          if (FirebaseAuth.instance.currentUser!.phoneNumber ==
                              null) {
                            final PhoneAuthCredential credential =
                                PhoneAuthProvider.credential(
                                    verificationId: _verificationId!,
                                    smsCode: pin);
                            await _auth.currentUser
                                ?.updatePhoneNumber(credential);
                            storePhoneNum(widget.phone);
                            await _auth
                                .signInWithCredential(credential)
                                .then((value) async {
                              if (value.user != null) {
                                setState(() {
                                  FirebaseUser(
                                      uid: value.user?.uid,
                                      phoneNum: widget.phone);
                                });
                                await FirebaseAuth.instance.currentUser!
                                    .reload();
                              }
                            });
                            await FirebaseAuth.instance.currentUser!.reload();
                          }
                          if (user?.phoneNum == null || user?.phoneNum == "") {
                            setState(() {
                              FirebaseUser(
                                  uid: user?.uid, phoneNum: widget.phone);
                            });
                          }
                          if (await FirebaseAuth
                                      .instance.currentUser?.phoneNumber !=
                                  null &&
                              !(user?.phoneNum == null ||
                                  user?.phoneNum == "")) {
                            timer?.cancel();
                            Navigator.pop(context);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const SetupUser()));
                          }
                        } catch (e) {
                          if (mounted) {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                      semanticLabel:
                                          "인증번호가 일치하지 않습니다. 재시도하세요. 돌아가려면 하단의 확인 버튼을 눌러주세요.",
                                      content: Text(
                                        "인증번호가 일치하지 않습니다.\n재시도하세요.",
                                        semanticsLabel:
                                            "인증번호가 일치하지 않습니다.\n재시도하세요.",
                                        style: const TextStyle(
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
                                            child: Text('확인',
                                                semanticsLabel: '확인',
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                  fontFamily: 'NanumGothic',
                                                  fontWeight: FontWeight.w600,
                                                )))
                                      ]);
                                });
                          }
                        }
                      },
                      child: Text(
                        "다음",
                        semanticsLabel: "다음",
                        style: TextStyle(
                            fontSize: 17,
                            fontFamily: 'NanumGothic',
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: height * 0.04),
                canResnedPhone
                    ? Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                              minimumSize: Size.fromHeight(height * 0.06),
                              backgroundColor: primaryColor),
                          icon: Icon(
                            Icons.phone,
                            size: height * 0.02,
                            color: Colors.white,
                            semanticLabel: "전화",
                          ),
                          label: Text(
                            '인증번호 재전송',
                            semanticsLabel: '인증번호 재전송',
                            style: TextStyle(
                                fontSize: 20,
                                fontFamily: 'NanumGothic',
                                fontWeight: FontWeight.w500),
                          ),
                          onPressed: () {
                            HapticFeedback.lightImpact(); // 약한 진동
                            verifyPhone();
                          },
                        ))
                    : SizedBox(
                        height: height * 0.01,
                        width: width * 0.01,
                      ),
              ],
            ),
          ));
    }
  }

  verifyPhone() async {
    if (await FirebaseAuth.instance.currentUser != null) {
      await FirebaseAuth.instance.currentUser!.reload();
    }
    if (FirebaseAuth.instance.currentUser?.phoneNumber != null) {
      timer?.cancel();
    }
    await _auth.verifyPhoneNumber(
      phoneNumber: '+82${widget.phone}',
      verificationCompleted: _onVerificationCompleted,
      verificationFailed: (FirebaseAuthException e) {
        // print(e.message);
      },
      codeSent: (String? verificationID, int? resendToken) async {
        setState(() {
          _verificationId = verificationID;
          canResnedPhone = false;
        });
        await Future.delayed(Duration(seconds: 120));
        if (this.mounted) {
          setState(() {
            canResnedPhone = true;
          });
        }
      },
      codeAutoRetrievalTimeout: (String verificationID) {
        if (FirebaseAuth.instance.currentUser?.phoneNumber == null) {
          if (mounted) {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                      semanticLabel:
                          "인증 가능한 기간이 지났습니다. 재시도하세요. 돌아가려면 하단의 확인 버튼을 눌러주세요.",
                      content: Text(
                        '인증 가능한 기간이 지났습니다. 재시도하세요.',
                        semanticsLabel: '인증 가능한 기간이 지났습니다. 재시도하세요.',
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
                            child: Text('확인',
                                semanticsLabel: '확인',
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontFamily: 'NanumGothic',
                                  fontWeight: FontWeight.w600,
                                )))
                      ]);
                });
          }
        } else {
          timer?.cancel();
        }
      },
      timeout: const Duration(seconds: 120),
    );
  }

  _onVerificationCompleted(PhoneAuthCredential authCredential) async {
    // try {
    //   await (await _auth.currentUser)?.updatePhoneNumber(authCredential);
    //   setState(() {
    //     otpCode.text = authCredential.smsCode!;
    //     FirebaseUser(phoneNum: widget.phone);
    //   });
    //   storePhoneNum(widget.phone);
    //   if (await FirebaseAuth.instance.currentUser?.phoneNumber != null) {
    //     timer?.cancel();

    //     Navigator.pop(context);
    //     Navigator.push(context,
    //         MaterialPageRoute(builder: (context) => const SetupUser()));
    //   }
    // } catch (e) {
    //   print(e);
    // }
  }
}
