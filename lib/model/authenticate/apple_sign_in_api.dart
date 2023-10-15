import 'dart:convert';
import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:crypto/crypto.dart';

class AppleSignInApi {
  String generateNonce([int length = 32]) {
    var charset =
        '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    var random = Random.secure();
    return List.generate(length, (_) => charset[random.nextInt(charset.length)])
        .join();
  }

  String sha256ofString(String input) {
    var bytes = utf8.encode(input);
    var digest = sha256.convert(bytes);
    return digest.toString();
  }

  Future<UserCredential> login() async {
    var rawNonce = generateNonce();
    var nonce = sha256ofString(rawNonce);

    //앱에서 애플 로그인 창을 호출하고, apple계정의 credential을 가져온다.
    var appleCredential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
      nonce: nonce,
    );

    //그 credential을 넣어서 OAuth를 생성
    var oauthCredential = OAuthProvider('apple.com').credential(
      idToken: appleCredential.identityToken,
      rawNonce: rawNonce,
    );

    //OAuth를 넣어서 firebase유저 생성
    return FirebaseAuth.instance.signInWithCredential(oauthCredential);
  }

  Future logout() async {
    await FirebaseAuth.instance.signOut();
  }
}
