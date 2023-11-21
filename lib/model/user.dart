import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? id;
  int? birthYear;
  String? disabilityType;
  Map<String, String>? location;
  String? area;
  String? district;
  String? nickname;
  String? registrationPurpose;
  String? userType;
  List<String>? blockedUsers;
  Map<String, dynamic>? pushMessage;
  String? deviceToken;
  Timestamp? tokenCreatedAt;

  UserModel({
    this.id,
    required this.birthYear,
    required this.disabilityType,
    required this.location,
    required this.nickname,
    required this.registrationPurpose,
    required this.userType,
    required this.blockedUsers,
    required this.pushMessage,
    DocumentSnapshot<Map<String, dynamic>>? doc,
  }) {
    // Initialize area and district based on location if location is not null
    if (location != null) {
      Map<String, dynamic>? rawLocation = doc!['location'];
      location = castMapOfStringString(rawLocation);
      area = location?['area'];
      district = location?['district'];
    }

    if (pushMessage != null) {
      Map<String, dynamic>? pushMessage = doc!['pushMessage'];
      deviceToken = pushMessage?['deviceToken'].toString();
      tokenCreatedAt = pushMessage?['tokenCreatedAt'];
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
    Map<String, dynamic>? rawLocation = doc['location'];
    location = castMapOfStringString(rawLocation);
    area = location?['area'];
    district = location?['district'];

    pushMessage = doc['pushMessage'];
    deviceToken = pushMessage?['deviceToken'].toString();
    tokenCreatedAt = pushMessage?['tokenCreatedAt'];

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
