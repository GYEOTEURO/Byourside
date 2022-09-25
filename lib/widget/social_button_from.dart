import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../size.dart';


class SocialButtonForm extends StatelessWidget {
  final String social;

  const SocialButtonForm(this.social);

  @override
  Widget build(BuildContext context) {
    return Form(
        child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
                width: 50,
                height: 50,
                child: InkWell(
                  radius: 100,
                  onTap: () {
                    ScaffoldMessenger.of(context).clearSnackBars();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(social),
                        duration: Duration(milliseconds: 1500),
                      ),
                    );
                  },
                  child: Ink.image(
                    fit: BoxFit.cover,
                    image: const NetworkImage(
                        'https://www.kindacode.com/wp-content/uploads/2022/07/bottle.jpeg'),
                  ),
                )),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
                width: 50,
                height: 50,
                child: InkWell(
                  radius: 100,
                  onTap: () {
                    Future<UserCredential> signInWithGoogle() async {
                      // Trigger the authentication flow
                      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

                      // Obtain the auth details from the request
                      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

                      // Create a new credential
                      final credential = GoogleAuthProvider.credential(
                        accessToken: googleAuth?.accessToken,
                        idToken: googleAuth?.idToken,
                      );

                      // Once signed in, return the UserCredential
                      return await FirebaseAuth.instance.signInWithCredential(credential);
                    }
                  },
                  child: Ink.image(
                    fit: BoxFit.cover,
                    image: const NetworkImage(
                        'https://www.kindacode.com/wp-content/uploads/2022/07/bottle.jpeg'),
                  ),
                )),
          ),
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                          width: 50,
                          height: 50,
                          child: InkWell(
                            radius: 100,
                            onTap: () {
                              ScaffoldMessenger.of(context).clearSnackBars();
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(social),
                                  duration: Duration(milliseconds: 1500),
                                ),
                              );
                            },
                            child: Ink.image(
                              fit: BoxFit.cover,
                              image: const NetworkImage(
                                  'https://www.kindacode.com/wp-content/uploads/2022/07/bottle.jpeg'),
                            ),
                          )),
                    )
                  ]))
        ]));
  }
}
