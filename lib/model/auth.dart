
import 'package:firebase_auth/firebase_auth.dart';
import 'package:byourside/model/firebase_user.dart';

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

    Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      return null;
    }
  }
}
// // https://kyungsnim.net/130
// import 'package:byourside/model/login_user.dart';
// import 'package:byourside/screen/authenticate/info/user_type.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/widgets.dart';
// import 'package:get/get.dart';
// import 'package:google_sign_in/google_sign_in.dart';

// final GoogleSignIn googleSignIn = GoogleSignIn();
// final userReference = FirebaseFirestore.instance.collection('users');
// final DateTime timestamp = DateTime.now();

// User currentUser;

// googleSignIn.onCurrentUserChanged.listen((gSignInAccount) {
//   controlSignIn(gSignInAccount);
// }, onError: (gError) {
//   print('Error Message : ' + gError);
// });

// GoogleSignIn.signInSilently();

// controlSignIn(GoogleSignInAccount signInAccount) async {
//   if (signInAccount != null) {
//     await saveUserInfoFirestore();
//     setState(() {
//       isSignedIn = true;
//     });
//   } else {
//     setState(() {
//       isSignedIn = false;
//     });
//   }
// }

// saveUserInfoToFirestore() async {
//   var gCurrentUser = googleSignIn.currentUser;
//   DocumentSnapshot documentSnapshot = await userReference.doc(gCurrentUser.id).get();

//   if (!documentSnapshot.exists) {
//     var username = Get.offAll(() => const SetupUser());

//     userReference.doc(gCurrentUser.id).set({
//       'id' : gCurrentUser.id,
//       'profileName' : gCurrentUser.displayName,
//       'userName' : username,
//       'email' : gCurrentUser.email,
//       'timestamp' : timestamp
//     });
    
//     documentSnapshot = await userReference.doc(gCurrentUser.id).get();
//   }

//   currentUser = User.fromDocument(documentSnapshot);
  
// }

// void dispose() {
//   PageController.dispose();
//   super.dispose();
// }

// loginUser() {
//   googleSignIn.signOut();
// }

