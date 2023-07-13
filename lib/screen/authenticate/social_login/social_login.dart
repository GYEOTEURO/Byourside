import 'package:byourside/model/google_sign_in_api.dart';
import 'package:byourside/screen/authenticate/info/user_type.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SocialLogin extends StatelessWidget {
  const SocialLogin({Key?key}) : super(key: key);

  Future<UserCredential?> loginWithGoogle(BuildContext context) async {

    GoogleSignInAccount? user = await GoogleSignInApi.login();

    GoogleSignInAuthentication? googleAuth = await user!.authentication;
    var credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken
    );

    UserCredential? userCredential = await FirebaseAuth.instance.signInWithCredential(credential);

    if (context.mounted){
      Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => const SetupUser()//GoogleLoggedInPage(userCredential: userCredential)
      ));
    
    }
    

    return userCredential;
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SNS LOGIN'),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 200,
            ),
            TextButton(
              onPressed: () => throw Exception(),
              child: const Text('Throw Test Exception'),
            ),
            SizedBox(
              width: 180.0,
              height: 48.0,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black, backgroundColor: Colors.white, side: const BorderSide(
                    width: 5.0,
                    color: Colors.red,
                  ),
                  minimumSize: const Size(double.infinity, 50),
                ),
                icon: const FaIcon(
                  FontAwesomeIcons.google,
                  color: Colors.red,
                ),
                label: const Text('Google 로그인'),
                onPressed: () async {
                  await loginWithGoogle(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }


}