import 'package:byourside/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPassword> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      backgroundColor: primaryColor,
      elevation: 0,
      title: Text('Reset Password'),
    ),
    body: Padding(
      padding: EdgeInsets.all(16),
      child: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'receive an email to\nreset your password',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: emailController,
              cursorColor: Colors.white,
              textInputAction: TextInputAction.done,
              decoration: InputDecoration(labelText: 'Email'),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              // validator: (email) =>
              // email != null && !EmailValidator.validate(email)
              //   ? 'Enter a valid email'
              //   : null,
            ),
            SizedBox(height: 20),
            ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                    minimumSize: Size.fromHeight(50),
                ),
                icon: Icon(Icons.email_outlined),
                label: Text(
                  'Reset Password',
                  style: TextStyle(fontSize: 24),
                ),
                onPressed: () {
                  verifyEmail();
                },
            )
          ],
        ),
      ),
    ),
  );

  Future verifyEmail() async {
    // showDialog(
    //     context: context,
    //     builder: (context) => Center(child: CircularProgressIndicator()),
    //     barrierDismissible: false
    // );

    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailController.text.trim());
      // Utils.showSnackBar('Password Reset Email Sent');
      // Navigator.of(context).popUntil((route) => route.isFirst);
      Navigator.of(context).pop();

    } on FirebaseAuthException catch (e) {
      print(e);
      // Utils.showSnackBar(e.message);
      Navigator.of(context).pop();
    }

  }
}