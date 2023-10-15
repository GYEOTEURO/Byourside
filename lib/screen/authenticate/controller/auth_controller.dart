import 'package:byourside/constants/colors.dart' as colors;
import 'package:byourside/constants/text.dart' as text;
import 'package:byourside/screen/authenticate/controller/user_controller.dart';
import 'package:byourside/screen/authenticate/social_login.dart';
import 'package:byourside/screen/bottom_nav_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import 'package:byourside/model/authenticate/google_sign_in_api.dart';
import 'package:byourside/screen/authenticate/setup_user.dart';

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

  _moveToPage(User? user) async {
    if (user == null) {
      Get.offAll(() => const SocialLogin());
    } else {
      print(user);
      bool isUserSetUp = await checkIfUserSetUp(user.uid);
      if (isUserSetUp) {
        Get.put(UserController(), permanent: true);
        await Future.delayed(const Duration(seconds: 2));

        Get.offAll(() => const BottomNavBar());
      } else {
        Get.offAll(() => const SetupUser());
      }
    }
  }

  void handleUserInfoCompletion() async {
    AuthController.instance._moveToPage(FirebaseAuth.instance.currentUser);
  }

  Future<bool> checkIfUserSetUp(String userId) async {
    try {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('userInfo')
          .doc(userId)
          .get();

      if (snapshot.exists) {
        Map<String, dynamic>? userData =
            snapshot.data() as Map<String, dynamic>?;
        if (userData != null && userData.containsKey('nickname')) {
          return true;
        }
      }
      return false;
    } catch (e) {
      if (kDebugMode) {
        print('Error checking user setup: $e');
      }
      return false;
    }
  }

  void logout() {
    authentication.signOut();
  }

  Future<void> deleteUser() async {
    try {
      var googleUser = await GoogleSignInApi.login();
      var user = authentication.currentUser;

      if (user != null && googleUser != null) {
        OAuthCredential? credential;
        var googleAuth = await googleUser.authentication;

        if (user.providerData
            .any((userInfo) => userInfo.providerId == 'google.com')) {
          credential = GoogleAuthProvider.credential(
            accessToken: googleAuth.accessToken,
            idToken: googleAuth.idToken,
          );
        }

        if (credential != null) {
          await user.reauthenticateWithCredential(credential);
        }

        await user.delete();
      }
    } catch (e) {
      _handleError(e);
    }
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

  Future<UserCredential> _signInWithCredential(
      Future<AuthCredential> Function() getCredential) async {
    var credential = await getCredential();
    return FirebaseAuth.instance.signInWithCredential(credential);
  }

  void _handleError(dynamic e) {
    Get.snackbar(
      'Error message',
      'User message',
      backgroundColor: colors.errorColor,
      snackPosition: SnackPosition.BOTTOM,
      titleText: const Text(text.registrationFailedText,
          style: TextStyle(color: Colors.white)),
      messageText:
          Text(e.toString(), style: const TextStyle(color: Colors.white)),
    );
  }
}
