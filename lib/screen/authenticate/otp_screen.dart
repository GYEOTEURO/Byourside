import 'package:byourside/main.dart';
import 'package:byourside/model/auth_provider.dart';
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

  final AuthService _auth = AuthService();
  late AuthProvider _authProvider;

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
                  await FirebaseAuth.instance
                      .signInWithCredential(PhoneAuthProvider.credential(
                      verificationId: _authProvider.verificationId!, smsCode: pin))
                      .then((value) async {
                    if (value.user != null) {
                      _authProvider.changeAuthOk(true);
                      if (kDebugMode) {
                        print(_authProvider.authOk);
                      }
                      await FirebaseAuth.instance.currentUser!.delete();
                      if (_authProvider.authOk) {
                        Navigator.of(context).pop();
                      }
                    }
                  });
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));

                }
              },
            ),
          )
        ],
      ),
    );
  }

  verifyPhone() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '+82${widget.phone}',
        verificationCompleted: _onVerificationCompleted,
        verificationFailed: (FirebaseAuthException e) {
          print(e.message);
          setState(() {
            _authProvider.changeIsLoading(false);
          });
        },
        codeSent: (String? verificationID, int? resendToken) {
          setState(() {
            _authProvider.setVerificationId(verificationID!);
            _authProvider.changeIsLoading(false);
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
    User? user = FirebaseAuth.instance.currentUser;
    setState(() {
      otpCode.text = authCredential.smsCode!;
    });
     if (authCredential.smsCode != null) {
      try {
        UserCredential credential =
        await user!.linkWithCredential(authCredential);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'provider-already-linked') {
          await FirebaseAuth.instance.signInWithCredential(authCredential);
        }
      }
      // setState(() {
      //   _auth.isLoading = false;
      //   // _auth.signOut();
      // });
    }
    _authProvider.changeAuthOk(true);
    //await FirebaseAuth.instance.currentUser!.delete();
  }

  @override
  void initState() {
    super.initState();
    verifyPhone();
  }
}