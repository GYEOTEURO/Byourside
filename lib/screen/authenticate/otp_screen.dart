import 'package:byourside/main.dart';
import 'package:byourside/model/firebase_user.dart';
import 'package:byourside/screen/authenticate/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
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

  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser? _firebaseUser(User? user) {
    return user != null ? FirebaseUser(uid: user.uid, phoneNum: user.phoneNumber) : null;
  }
  Stream<FirebaseUser?> get user {
    return _auth.authStateChanges().map(_firebaseUser);
  }

  String? _verificationId;

  final defaultPinTheme = PinTheme(
    width: 56,
    height: 56,
    textStyle: TextStyle(fontSize: 20, color: primaryColor, fontWeight: FontWeight.w600),
    decoration: BoxDecoration(
      border: Border.all(color: primaryColor),
      borderRadius: BorderRadius.circular(20),
    ),
  );

  @override
  Widget build(BuildContext context) {
    final user =  Provider.of<FirebaseUser?>(context);
    return Scaffold(
      key: _formKey,
      appBar: AppBar(
        title: Text('OTP Verification'),
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 40),
            child: Center(
              child: Text(
                'Verify +82-${widget.phone}',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
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
                  final PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: _verificationId!, smsCode: pin);
                  await _auth.currentUser?.updatePhoneNumber(credential);
                  await _auth.currentUser?.linkWithCredential(credential);

                  await _auth.signInWithCredential(credential).then((value) async {
                    if (value.user != null) {
                      FirebaseUser(uid: value.user?.uid, phoneNum: widget.phone);
                    }
                  });
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
                  FirebaseUser(code: e.toString(), uid: null);
                }
                await FirebaseAuth.instance.currentUser!.reload();
                (user!.phoneNum != null)?
                await Navigator.push(
                    context,

                    MaterialPageRoute(
                        builder: (context) =>
                        const SetupUser()) ): null;
              },
            ),
          ),
          ElevatedButton(
            onPressed: ()  {
              String pin = otpCode.text.toString();
              try {
                if (user?.phoneNum == null || user?.phoneNum == "") {
                  if (kDebugMode) {
                    print(user?.phoneNum);
                  }
                  final PhoneAuthCredential credential =
                  PhoneAuthProvider.credential(
                      verificationId: _verificationId!, smsCode: pin);
                  _auth.currentUser?.updatePhoneNumber(credential);
                  _auth.currentUser?.linkWithCredential(credential);

                  _auth
                      .signInWithCredential(credential)
                      .then((value) async {
                    if (kDebugMode) {
                      print(value.user);
                    }
                    if (value.user != null) {
                      setState(() {
                        FirebaseUser(
                            uid: value.user?.uid, phoneNum: widget.phone);
                      });
                    }
                  });
                  FirebaseAuth.instance.currentUser!.reload();
                  (user?.phoneNum != null && user?.phoneNum != "" && mounted)?
                  Navigator.push(
                      context,

                      MaterialPageRoute(
                          builder: (context) =>
                          const SetupUser()) ) : null;
                }
                else {
                //   Navigator.of(context).popUntil((route) => route.isFirst);
                // }
                  Navigator.push(
                      context,

                      MaterialPageRoute(
                          builder: (context) =>
                          const SetupUser()) );
                }
              } catch (e) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(e.toString())));
                FirebaseUser(code: e.toString(), uid: null);
              }
            },
            child: Text("next"),
          )
        ],
      ),
    );
  }

  verifyPhone() async {
    await _auth.verifyPhoneNumber(
      phoneNumber: '+82${widget.phone}',
      verificationCompleted: _onVerificationCompleted,
      verificationFailed: (FirebaseAuthException e) {
        // print(e.message);
      },
      codeSent: (String? verificationID, int? resendToken) async {
        setState(() {
          _verificationId = verificationID;
        });
      },
      codeAutoRetrievalTimeout: (String verificationID) {
        // Auto-resolution timed out...
      },
      timeout: const Duration(seconds: 120),
    );
  }

  _onVerificationCompleted(PhoneAuthCredential authCredential) async {
    // print("verification completed ${authCredential.smsCode}");
    await (await _auth.currentUser)?.updatePhoneNumber(authCredential);
    setState(() {
      otpCode.text = authCredential.smsCode!;
    });
  }

  @override
  void initState() {
    super.initState();
    verifyPhone();
  }
}