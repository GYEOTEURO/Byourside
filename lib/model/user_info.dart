// import 'package:byourside/main.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';

// class UserInfo {
//   final String? uid;

//   UserInfo({this.uid});

//   Future<bool> checkDocExist(String name) async {
//     var collection = FirebaseFirestore.instance.collection('displayNameList');
//     var doc = await collection.doc(name).get();
//     return doc.exists;
//   }

// // if (doc.exists == true) {
// //       if (mounted) {
// //         showDialog(
// //             context: context,
// //             builder: (context) {
// //               return AlertDialog(
// //                 content: Text('이미 존재하는 닉네임입니다. 다른 닉네임을 사용하세요.'),
// //               );
// //             });
// //       }
// //     } else {
// //       showDialog(
// //           context: context,
// //           builder: (context) {
// //             return AlertDialog(
// //               content: Text('사용가능한 닉네임입니다.'),
// //             );
// //           });
// //     }

//   final nicknameField = Container(
//       child: TextFormField(
//     decoration: const InputDecoration(
//       labelText: "닉네임을 입력하세요",
//       hintText: "닉네임을 입력하세요 (예: 홍길동) ",
//       hintStyle: TextStyle(color: Colors.grey),
//       labelStyle: TextStyle(color: primaryColor),
//     ),
//     controller: _nickname,
//     validator: (value) {
//       if (value != null) {
//         if (value.split(' ').first != '' && value.isNotEmpty) {
//           return null;
//         }
//         return '필수 입력란입니다. 닉네임을 입력하세요';
//       }
//     },
//   ));

//   final someoneElseField = Container(
//       child: TextFormField(
//     decoration: const InputDecoration(
//       labelText: "방문 목적",
//       hintText: "방문 목적을 입력하세요. (예: 자녀 장애 초기증상 판별)",
//       hintStyle: TextStyle(color: Colors.grey),
//       labelStyle: TextStyle(color: primaryColor),
//     ),
//     controller: _purpose,
//     validator: (value) {
//       if (value != null) {
//         if (value.split(' ').first != '' && value.isNotEmpty) {
//           return null;
//         }
//         return '필수 입력란입니다. 방문 목적을 입력하세요';
//       }
//     },
//   ));

//   bool isNumeric(String s) {
//     if (s == null) {
//       return false;
//     }
//     return double.tryParse(s) != null;
//   }
// }
