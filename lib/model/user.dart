import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? id;
  String? birthYear;
  String? disabilityType;
  Map<String, String>? location;
  String? area;
  String? district;
  String? nickname;
  String? registrationPurpose;
  String? userType;
  List<String>? blockedUsers;

  UserModel({
    this.id,
    required this.birthYear, 
    required this.disabilityType, 
    required this.location,
    required this.nickname, 
    required this.registrationPurpose, 
    required this.userType,
    required this.blockedUsers,
    DocumentSnapshot<Map<String, dynamic>>? doc,
  }) {
    // Initialize area and district based on location if location is not null
    if (location != null) {
      final Map<String, dynamic>? rawLocation = doc!['location'];
      location = castMapOfStringString(rawLocation);
      area = location?['area'];
      district = location?['district'];
    }
  }

  UserModel.fromDocument({required DocumentSnapshot<Map<String, dynamic>> doc})
      : id = doc.id,
        birthYear = doc['birthYear'],
        disabilityType = doc['disabilityType'],
        nickname = doc['nickname'],
        registrationPurpose = doc['registrationPurpose'],
        userType = doc['userType'],
        blockedUsers = doc.data()!['blockedUsers'] == null
            ? []
            : doc.data()!['blockedUsers'].cast<String>() {
        final Map<String, dynamic>? rawLocation = doc['location'];
        location = castMapOfStringString(rawLocation);
        area = location?['area'];
        district = location?['district'];
  }

  // Helper function to cast Map<String, dynamic> to Map<String, String>
  Map<String, String>? castMapOfStringString(Map<String, dynamic>? input) {
    if (input == null) {
      return null;
    }
    
    Map<String, String> result = {};
    input.forEach((key, value) {
      if (value is String) {
        result[key] = value;
      }
    });
    return result.isNotEmpty ? result : null;
  }
}
