import 'package:byourside/model/google_sign_in_api.dart';
import 'package:byourside/screen/authenticate/social_login/google_logged_in_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SocialLogin extends StatelessWidget {
  const SocialLogin({Key?key}) : super(key: key);

  Future<UserCredential?> loginWithGoogle(BuildContext context) async {
    print('lets start');
    GoogleSignInAccount? user = await GoogleSignInApi.login();
    print('?');
    GoogleSignInAuthentication? googleAuth = await user!.authentication;
    var credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken
    );

    UserCredential? userCredential = await FirebaseAuth.instance.signInWithCredential(credential);

    print('로그인 성공 === Google');
    print(userCredential);

    if (context.mounted){
      Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => GoogleLoggedInPage(userCredential: userCredential)
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