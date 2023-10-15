
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SaveUserData {
  static Future<void> saveUserInfo({
    required int birthYear,
    String? selectedType,
    Map<String, String>? location,
    String? nickname,
    String? registrationPurpose,
    String? userType,
    String? deviceToken
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
        'deviceToken': deviceToken,
      });
    }
  }
}