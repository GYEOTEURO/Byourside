import 'package:byourside/main.dart';
import 'package:byourside/model/auth_provider.dart';
import 'package:byourside/model/firebase_user.dart';
import 'package:byourside/screen/authenticate/login.dart';
import 'package:byourside/widget/auth.dart';
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

  late AuthProvider _authProvider;
  int count = 0;

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
    _authProvider = Provider.of<AuthProvider>(context, listen: true);

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
                  final PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: _authProvider.verificationId!, smsCode: pin);
                  await _auth.currentUser?.updatePhoneNumber(credential);
                  await _auth.currentUser?.linkWithCredential(credential);

                  await _auth.signInWithCredential(credential).then((value) async {
                    if (value.user != null) {
                      FirebaseUser(uid: value.user?.uid, phoneNum: widget.phone);
                      // _authProvider.changeAuthOk(true);
                      await _authProvider.setPhoneNum(widget.phone);
                      if (kDebugMode) {
                        print("otp");
                      }
                      // if (_authProvider.authOk) {
                      //   Navigator.of(context).popUntil((_) => count++ >= 2);
                      // }
                    }
                  });
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
                  FirebaseUser(code: e.toString(), uid: null);
                }
                await FirebaseAuth.instance.currentUser!.reload();
                Navigator.of(context).popUntil((_) => count++ >= 2);

              },
            ),
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
          print(e.message);
          setState(() {
            // _authProvider.changeIsLoading(false);
          });
        },
        codeSent: (String? verificationID, int? resendToken) async {
          setState(() {
            _authProvider.setVerificationId(verificationID!);
            // _authProvider.changeIsLoading(false);
            print(_authProvider.verificationId);
          });
        },
        codeAutoRetrievalTimeout: (String verificationID) {
          // Auto-resolution timed out...
        },
        timeout: Duration(seconds: 60),
    );
  }

  _onVerificationCompleted(PhoneAuthCredential authCredential) async {
    print("verification completed ${authCredential.smsCode}");
    // User? user = _auth.currentUser;
    await (await _auth.currentUser)?.updatePhoneNumber(authCredential);
    setState(() {
      otpCode.text = authCredential.smsCode!;
    });
     if (authCredential.smsCode != null) {
       print("complete");
      try {
        // _authProvider.setPhoneCredential(authCredential);
        // UserCredential credential = await user!.linkWithCredential(authCredential);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'provider-already-linked') {
          await _auth.signInWithCredential(authCredential);
        }
      }
    }
  }

  @override
  void initState() {
    super.initState();
    verifyPhone();
  }
}