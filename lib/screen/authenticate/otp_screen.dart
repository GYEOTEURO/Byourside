import 'dart:async';

import 'package:byourside/main.dart';
import 'package:byourside/model/firebase_user.dart';
import 'package:byourside/screen/authenticate/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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
      isPhoneVerified = FirebaseAuth.instance.currentUser!.phoneNumber != null;

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
        fontSize: 20, color: primaryColor, fontWeight: FontWeight.w600),
    decoration: BoxDecoration(
      border: Border.all(color: primaryColor),
      borderRadius: BorderRadius.circular(20),
    ),
  );

  @override
  Widget build(BuildContext context) {
    if (isPhoneVerified) {
      return SetupUser();
    } else {
      final user = Provider.of<FirebaseUser?>(context);
      return Scaffold(
        key: _formKey,
        appBar: AppBar(
          title: Text('OTP 인증'),
          backgroundColor: primaryColor,
        ),
        body: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 40),
              child: Center(
                child: Text(
                  '+82-${widget.phone}로 전송된\n인증번호를 입력하세요.',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 26,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Pinput(
                length: 6,
                defaultPinTheme: defaultPinTheme,
                controller: otpCode,
                pinAnimationType: PinAnimationType.fade,
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
                        FirebaseUser(
                            uid: value.user?.uid, phoneNum: widget.phone);
                      }
                    });
                  } catch (e) {
                    // ScaffoldMessenger.of(context)
                    //     .showSnackBar(SnackBar(content: Text(e.toString())));
                    // FirebaseUser(code: e.toString(), uid: null);
                  }
                  await FirebaseAuth.instance.currentUser!.reload();

                  if (FirebaseAuth.instance.currentUser?.phoneNumber != null) {
                    timer?.cancel();
                  }
                },
              ),
            ),
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(primaryColor)),
              onPressed: () async {
                String pin = otpCode.text.toString();
                try {
                  if (FirebaseAuth.instance.currentUser!.phoneNumber == null) {
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
                  } else if (user?.phoneNum == null || user?.phoneNum == "") {
                    setState(() {
                      FirebaseUser(uid: user?.uid, phoneNum: widget.phone);
                    });
                  } else {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SetupUser()));
                  }

                  if (FirebaseAuth.instance.currentUser?.phoneNumber != null) {
                    timer?.cancel();
                  }
                } catch (e) {
                  if (mounted) {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            content: Text("$e"), //"인증번호가 일치하지 않습니다.\n재시도하세요."),
                          );
                        });
                  }
                }
              },
              child: Text("다음"),
            ),
            canResnedPhone
                ? ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                        minimumSize: Size.fromHeight(50),
                        backgroundColor: primaryColor),
                    icon: Icon(
                      Icons.phone,
                      size: 32,
                      color: Colors.white,
                    ),
                    label: Text(
                      '인증번호 재전송',
                      style: TextStyle(fontSize: 24),
                    ),
                    onPressed: () {
                      verifyPhone();
                    },
                  )
                : SizedBox(
                    height: 16,
                  ),
          ],
        ),
      );
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
                    content: Text('인증 가능한 기간이 지났습니다. 재시도하세요.'),
                  );
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
    print("인증 완료 ${authCredential.smsCode}");
    await (await _auth.currentUser)?.updatePhoneNumber(authCredential);
    setState(() {
      otpCode.text = authCredential.smsCode!;
    });
    // if (authCredential.smsCode != null) {
    //   print("complete");
    // }
  }
}
