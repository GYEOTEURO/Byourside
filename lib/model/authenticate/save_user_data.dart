import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class StoreUserData {
  static Future<void> storeUserInfo({
    String? birthYear,
    String? selectedType,
    List<Map>? location,
    String? nickname,
    String? registrationPurpose,
    String? userType,
  }) async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      await FirebaseFirestore.instance.collection('userInfo').doc(user.uid).set({
        'birthYear': birthYear,
        'blockedUsers': [],
        'disabilityType': selectedType,
        'location': location,
        'nickname': nickname,
        'registrationPurpose': registrationPurpose,
        'userType': userType,
      });
    }
  }
}