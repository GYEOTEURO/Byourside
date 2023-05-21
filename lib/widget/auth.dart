import 'package:firebase_auth/firebase_auth.dart';
import '../model/login_user.dart';
import '../model/firebase_user.dart';

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

  Future signInEmailPassword(LoginUser login) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: login.email.toString(),
              password: login.password.toString());
      User? user = userCredential.user;
      return _firebaseUser(user);
    } on FirebaseAuthException catch (e) {
      return FirebaseUser(code: e.code, uid: null);
    }
  }

  Future registerEmailPassword(LoginUser login) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: login.email.toString(),
        password: login.password.toString(),
      );
      User? user = userCredential.user;

      // PhoneAuthCredential? credential = AuthProvider().phoneAuthCredential;
      // await user!.updatePhoneNumber(credential!);

      return _firebaseUser(user);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return FirebaseUser(
            uid: null, code: 'The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        return FirebaseUser(
            uid: null, code: 'The account already exists for that email.');
      }
      // return FirebaseUser(code: e.code, uid: null);
    } catch (e) {
      return FirebaseUser(code: e.toString(), uid: null);
    }
  }

  // Future resetPassword(LoginUser _login) async {
  //   try {
  //     await _auth.sendPasswordResetEmail(email: _login.email.toString());
  //   } on FirebaseAuthException catch (e) {
  //     return FirebaseUser(uid: null, code: e.code);
  //   }
  // }

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

  // Future isVerified() async {
  //   try {
  //     if (verificationId != null) {
  //       authOk = true;
  //     }
  //     else {
  //       authOk = false;
  //     }
  //   } catch (e) {
  //     authOk = false;
  //   }
  // }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      return null;
    }
  }

  // Future<bool> checkAccount(password) async {
  //   try {
  //     AuthCredential credential = await EmailAuthProvider.credential(
  //         email: _auth.currentUser!.email!, password: password);
  //     await _auth.currentUser!.reauthenticateWithCredential(credential);
  //     return true;
  //   } catch (e) {
  //     return false;
  //   }
  // }

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
