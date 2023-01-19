// import 'package:byourside/main.dart';
// import 'package:byourside/model/firebase_user.dart';
// import 'package:byourside/widget/auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter/widgets.dart';

// class Withdrawal extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() {
//     return _Withdrawal();
//   }
// }

// class _Withdrawal extends State<Withdrawal> {
//   final AuthService _auth = new AuthService();

//   void _withdrawal(context, password) async {
//     FirebaseUser(uid: null, phoneNum: null, displayName: null, code: null);
//     await _auth.withdrawalAccount(password);
//     Navigator.of(context).popUntil((route) => route.isFirst);
//   }

//   @override
//   Widget build(BuildContext context) {
//     String password = "";
//     final _password = TextEditingController();

//     return Scaffold(
//         resizeToAvoidBottomInset: false,
//         appBar: AppBar(
//           centerTitle: true,
//           title: const Text('탈퇴',
//               semanticsLabel: "탈퇴",
//               style: TextStyle(
//                   fontFamily: 'NanumGothic', fontWeight: FontWeight.bold)),
//           backgroundColor: Theme.of(context).primaryColor,
//         ),
//         body: Column(
//           children: [
//             Text(
//               "탈퇴 버튼입니다. 탈퇴 후 동일한 번호로 재가입이 불가능합니다. 탈퇴를 원하시면 비밀번호를 입력하세요.",
//               semanticsLabel:
//                   "탈퇴 버튼입니다. 탈퇴 후 동일한 번호로 재가입이 불가능합니다. 탈퇴를 원하시면 비밀번호를 입력하세요.",
//               style: TextStyle(
//                   color: Colors.black,
//                   fontSize: 17,
//                   fontFamily: 'NanumGothic',
//                   fontWeight: FontWeight.w600),
//             ),
//             Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Text(
//                   "비밀번호를 입력하세요.\n동일한 번호로 재가입이 불가능합니다.",
//                   semanticsLabel: "비밀번호를 입력하세요. 동일한 번호로 재가입이 불가능합니다.",
//                   textAlign: TextAlign.left,
//                   style: const TextStyle(
//                       color: Colors.black,
//                       fontSize: 15,
//                       fontFamily: 'NanumGothic',
//                       fontWeight: FontWeight.w600),
//                 ),
//                 SizedBox(
//                   height: MediaQuery.of(context).size.height * 0.02,
//                 ),
//                 TextFormField(
//                   controller: _password,
//                   autofocus: true,
//                   style: const TextStyle(
//                       color: Colors.black,
//                       fontSize: 17,
//                       fontFamily: 'NanumGothic',
//                       fontWeight: FontWeight.w600),
//                   decoration: InputDecoration(
//                       enabledBorder: OutlineInputBorder(
//                           borderSide:
//                               BorderSide(color: Theme.of(context).primaryColor),
//                           borderRadius: BorderRadius.circular(20)),
//                       errorBorder: OutlineInputBorder(
//                           borderSide: const BorderSide(color:                   Color.fromARGB(255, 255, 45, 45)),
//                           borderRadius: BorderRadius.circular(20)),
//                       focusedBorder: OutlineInputBorder(
//                           borderSide:
//                               BorderSide(color: Theme.of(context).primaryColor),
//                           borderRadius: BorderRadius.circular(20))),
//                 ),
//               ],
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 HapticFeedback.lightImpact(); // 약한 진동
//                 Navigator.of(context).pop();
//               },
//               style: ElevatedButton.styleFrom(backgroundColor: primaryColor),
//               child: const Text(
//                 "취소",
//                 semanticsLabel: "취소",
//                 style: TextStyle(
//                     fontSize: 17,
//                     fontFamily: 'NanumGothic',
//                     fontWeight: FontWeight.w500),
//               ),
//             ),
//             ElevatedButton(
//               onPressed: () async {
//                 String check1 =
//                     await _auth.checkCredential(_password.text, context);
//                 if (check1 == "e")
//                   print('비밀번호가 일치하지 않습니다.');
//                 else {
//                   '${check1}';

//                   _withdrawal(context, password);
//                 }
//               },
//               style: ElevatedButton.styleFrom(backgroundColor: primaryColor),
//               child: const Text(
//                 "완료",
//                 semanticsLabel: "완료",
//                 style: TextStyle(
//                     fontSize: 17,
//                     fontFamily: 'NanumGothic',
//                     fontWeight: FontWeight.w500),
//               ),
//             )
//           ],
//         ));
//   }
// }
