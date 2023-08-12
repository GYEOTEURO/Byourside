import 'package:byourside/screen/authenticate/social_login/social_login.dart';
import 'package:byourside/screen/bottom_nav_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import 'package:byourside/model/google_sign_in_api.dart';
import 'package:byourside/screen/authenticate/info/user_type.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();

  late Rx<User?> _user;
  FirebaseAuth authentication = FirebaseAuth.instance;

  @override
  void onReady() {
    super.onReady();
    _user = Rx<User?>(authentication.currentUser);
    _user.bindStream(authentication.userChanges());

    ever(_user, _moveToPage);
  }

  _moveToPage(User? user) {
    print(user);
    if (user == null) {
      Get.offAll(() => const SocialLogin());
    } else {
      Get.offAll(() => const BottomNavBar());
    }
  }

  void logout() {
    authentication.signOut();
  }

  Future<UserCredential?> loginWithGoogle(BuildContext context) async {
    try {
      UserCredential? userCredential = await _signInWithCredential(() async {
        var user = await GoogleSignInApi.login();
        var googleAuth = await user!.authentication;
        
        return GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
      });

      if (context.mounted) {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => const SetupUser(),
        ));
      }
      
      return userCredential;
    } catch (e) {
      _handleError(e);
    }
    return null;
  }

  Future<UserCredential> signInWithApple() async {
    try {
      return await _signInWithCredential(() async {
        var appleCredential = await SignInWithApple.getAppleIDCredential(
          scopes: [
            AppleIDAuthorizationScopes.email,
            AppleIDAuthorizationScopes.fullName,
          ],
        );

        return OAuthProvider('apple.com').credential(
          idToken: appleCredential.identityToken,
          accessToken: appleCredential.authorizationCode,
        );
      });
    } catch (e) {
      _handleError(e);
      rethrow;
    }
  }

  Future<UserCredential> _signInWithCredential(Future<AuthCredential> Function() getCredential) async {
    var credential = await getCredential();
    return FirebaseAuth.instance.signInWithCredential(credential);
  }

  void _handleError(dynamic e) {
    Get.snackbar(
      'Error message',
      'User message',
      backgroundColor: Colors.red,
      snackPosition: SnackPosition.BOTTOM,
      titleText: const Text('Registration is Failed', style: TextStyle(color: Colors.white)),
      messageText: Text(e.toString(), style: const TextStyle(color: Colors.white)),
    );
  }
}
