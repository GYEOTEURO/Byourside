import 'package:firebase_auth/firebase_auth.dart';
import 'firebase_user.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  FirebaseUser? _firebaseUser(User? user) {
    return user != null
        ? FirebaseUser(
            uid: user.uid,
            phoneNum: user.phoneNumber,
            displayName: user.displayName)
        : null;
  }

  Stream<FirebaseUser?> get user {
    return _auth.authStateChanges().map(_firebaseUser);
  
  }

  // Future signInCredential(LoginUser _login) async {
  //   try {
  //     await FirebaseAuth.instance
  //         .signInWithCredential(PhoneAuthProvider.credential(
  //         verificationId: _login.email!, smsCode: _login.password!))
  //         .then((value) async {
  //             return value;
  //     });
  //   } on FirebaseAuthException catch (e) {
  //       return FirebaseUser(uid: null, code: e.code);
  //   }
  // }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      return null;
    }
  }

  // // Firebase로부터 회원 탈퇴
  // Future withdrawalAccount(password) async {
  //   try {
  //     AuthCredential credential = await EmailAuthProvider.credential(
  //         email: _auth.currentUser!.email!, password: password);
  //     await _auth.currentUser!.reauthenticateWithCredential(credential);
  //     return _auth.currentUser!.delete();
  //   } catch (e) {
  //     return null;
  //   }
  // }
}
