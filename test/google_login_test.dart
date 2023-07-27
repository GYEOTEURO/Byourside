import 'package:flutter_test/flutter_test.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:google_sign_in_mocks/google_sign_in_mocks.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  test('Google Login Test', () async {
    // Mock sign in with Google.
    var googleSignIn = MockGoogleSignIn();
    var signinAccount = await googleSignIn.signIn();
    var googleAuth = await signinAccount!.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Sign in.
    var user = MockUser(
      isAnonymous: false,
      uid: 'someuid',
      email: 'bob@somedomain.com',
      displayName: 'Bob',
    );
    var auth = MockFirebaseAuth(mockUser: user);
    var result = await auth.signInWithCredential(credential);
    var loggedInUser = result.user;
    print(loggedInUser?.displayName);

    // Assertion: Check if the user is successfully logged in.
    expect(loggedInUser?.displayName, 'Bob');
  });
}
