import 'package:byourside/screen/authenticate/social_login/social_login.dart';
import 'package:byourside/screen/bottom_nav_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:byourside/model/google_sign_in_api.dart';
import 'package:byourside/screen/authenticate/info/user_type.dart';
import 'package:google_sign_in/google_sign_in.dart';


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
    if (user == null) {
    Get.offAll(() => const SocialLogin());
    } 
    else {
      Get.offAll(() => const BottomNavBar());
    }
  }
  
  void logout() {
    authentication.signOut();
  }

  Future<UserCredential?> loginWithGoogle(BuildContext context) async {
    try {

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
    catch (e) {
      Get.snackbar(
        'Error message',
        'User message',
        backgroundColor: Colors.red,
        snackPosition: SnackPosition.BOTTOM,
        titleText: const Text('Registration is Faild', style: TextStyle(
          color: Colors.white
        ),),
        messageText: Text(e.toString(), style: const TextStyle(
          color: Colors.white
        ),),
      );
    }
    return null;
  }
}