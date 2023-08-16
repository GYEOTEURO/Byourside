// import 'package:byourside/main.dart';
// import 'package:byourside/model/firebase_user.dart';
// import 'package:byourside/screen/authenticate/login_screen.dart';
// import 'package:byourside/screen/authenticate/personal_data.dart';
// import 'package:byourside/screen/authenticate/using_policy.dart';
// import 'package:byourside/screen/mypage/my_block_user.dart';
// import 'package:byourside/screen/mypage/my_report.dart';
// import 'package:byourside/screen/mypage/freq_question.dart';
// import 'package:byourside/screen/mypage/my_community_post.dart';
// import 'package:byourside/screen/mypage/my_scrap_community_post.dart';
// import 'package:byourside/screen/mypage/to_developer.dart';
// import 'package:byourside/widget/auth.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

// class Mypage extends StatefulWidget {
//   const Mypage({super.key});

//   @override
//   State<StatefulWidget> createState() {
//     return _Mypage();
//   }
// }

// class _Mypage extends State<Mypage> {
//   final AuthService _auth = AuthService();
//   late String uid;
//   late String displayName;
//   User? user;

//   @override
//   void initState() {
//     super.initState();
//     user = FirebaseAuth.instance.currentUser;
//     uid = user!.uid;
//     // displayName = user!.displayName;
//     displayName = user!.displayName!;
//   }

//   final List<String> myEntires = <String>[
//     "내가 쓴 커뮤니티 글",
//     "커뮤니티 스크랩"
//   ];
//   final List<Icon> myIcons = <Icon>[
//     const Icon(Icons.groups, semanticLabel: '내가 쓴 커뮤니티 글 목록 화면으로 이동'),
//     const Icon(Icons.star_border_outlined,
//         semanticLabel: '스크랩한 커뮤니티 글 목록 화면으로 이동')
//   ];
//   final List<Widget> myConnectPage = <Widget>[
//     const MyCommunityPost(),
//     const MyScrapCommunityPost()
//   ];

//   final List<String> etcEntires = <String>[
//     "자주 묻는 질문",
//     "사용자 신고하기",
//     "사용자 차단하기",
//     "개발자에게 문의하기",
//     "개인정보 처리방침",
//     "서비스 이용약관",
//     "로그아웃",
//     // "탈퇴"
//   ];
//   final List<Icon> etcIcons = <Icon>[
//     const Icon(Icons.help, semanticLabel: '자주 묻는 질문 목록 화면으로 이동'),
//     const Icon(Icons.report_problem, semanticLabel: '사용자 신고 화면으로 이동'),
//     const Icon(Icons.dnd_forwardslash, semanticLabel: '사용자 차단 화면으로 이동'),
//     const Icon(Icons.question_answer, semanticLabel: '개발자에게 문의하기 화면으로 이동'),
//     const Icon(Icons.archive, semanticLabel: '개인정보 처리방침 화면으로 이동'),
//     const Icon(Icons.receipt_long_rounded, semanticLabel: '서비스 이용약관 화면으로 이동'),
//     const Icon(Icons.logout, semanticLabel: '로그아웃'),
//   ];

//   void _logout(context) async {
//     FirebaseUser(uid: null, phoneNum: null, displayName: null, code: null);
//     await _auth.signOut();
//     setState(() {});
//     Navigator.of(context).popUntil((route) => route.isFirst);
//     Navigator.of(context).push(MaterialPageRoute(
//       builder: (context) => const LoginScreen(
//         primaryColor: primaryColor,
//       ),
//     ));
//     // Navigator.pushNamed(context, '/login');
//   }

//   @override
//   Widget build(BuildContext context) {
//     final SignOut = Material(
//       elevation: 5.0,
//       borderRadius: BorderRadius.circular(30.0),
//       color: const Color(0xFF045558),
//       child: MaterialButton(
//         minWidth: MediaQuery.of(context).size.width,
//         padding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
//         onPressed: () async {
//           FirebaseUser(
//               uid: null, phoneNum: null, displayName: null, code: null);
//           await _auth.signOut();
//           setState(() {});
//           Navigator.of(context).popUntil((route) => route.isFirst);
//           Navigator.of(context).push(MaterialPageRoute(
//             builder: (context) => const LoginScreen(
//               primaryColor: primaryColor,
//             ),
//           ));
//           // Navigator.pushNamed(context, '/login');
//         },
//         child: const Text(
//           "Log out",
//           style: TextStyle(color: Color(0xFF045558)),
//           textAlign: TextAlign.center,
//         ),
//       ),
//     );

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           '마이페이지',
//           style:
//               TextStyle(fontFamily: 'NanumGothic', fontWeight: FontWeight.w600),
//           semanticsLabel: '마이페이지(나의 정보 화면)',
//         ),
//         centerTitle: true,
//         automaticallyImplyLeading: false,
//         backgroundColor: const Color(0xFF045558),
//       ),
//       body: Container(
//         padding: const EdgeInsets.all(30),
//         child: Center(
//             child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               children: [
//                 const RawMaterialButton(
//                   onPressed: null,
//                   elevation: 2.0,
//                   fillColor: Colors.grey,
//                   padding: EdgeInsets.all(15.0),
//                   shape: CircleBorder(),
//                   child: Icon(
//                     Icons.person,
//                     size: 50.0,
//                     semanticLabel: '사용자의 기본 프로필 사진',
//                   ),
//                 ),
//                 const SizedBox(
//                   width: 20,
//                 ),
//                 // 나만의 명함 만들기
//                 Text(displayName,
//                     overflow: TextOverflow.ellipsis,
//                     semanticsLabel: '사용자 닉네임: $displayName',
//                     textAlign: TextAlign.left,
//                     style: const TextStyle(
//                         fontSize: 25,
//                         fontWeight: FontWeight.w700,
//                         color: Colors.black,
//                         fontFamily: 'NanumGothic')),
//               ],
//             ),
//             const SizedBox(
//               height: 20,
//             ),
//             const Divider(thickness: 1, height: 1, color: Colors.black26),
//             const SizedBox(
//               height: 30,
//             ),
//             // 이름 입력
//             const Text(
//               "나의 활동",
//               semanticsLabel: '나의 활동',
//               style: TextStyle(
//                   fontSize: 18,
//                   color: Colors.black,
//                   fontWeight: FontWeight.w700,
//                   fontFamily: 'NanumGothic'),
//             ),
//             const SizedBox(
//               height: 10,
//             ),
//             Expanded(
//                 flex: 5,
//                 child: ListView.builder(
//                     // physics: const NeverScrollableScrollPhysics(),
//                     // padding: const EdgeInsets.only(top: 10, bottom: 10),
//                     itemCount: myEntires.length,
//                     itemBuilder: (BuildContext context, index) {
//                       return TextButton.icon(
//                         style: TextButton.styleFrom(
//                             foregroundColor: Colors.black,
//                             alignment: Alignment.centerLeft),
//                         icon: myIcons[index],
//                         label: Text(
//                           myEntires[index],
//                           semanticsLabel: myEntires[index],
//                           style: const TextStyle(
//                               fontWeight: FontWeight.w600,
//                               fontFamily: 'NanumGothic'),
//                         ),
//                         onPressed: () {
//                           HapticFeedback.lightImpact(); // 약한 진동
//                           Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (context) => myConnectPage[index]));
//                         },
//                       );
//                     })),
//             const Divider(thickness: 1, height: 1, color: Colors.black26),
//             const SizedBox(
//               height: 15,
//             ),
//             const Text(
//               "기타",
//               semanticsLabel: '기타',
//               style: TextStyle(
//                   fontSize: 18,
//                   color: Colors.black,
//                   fontWeight: FontWeight.w700,
//                   fontFamily: 'NanumGothic'),
//             ),
//             const SizedBox(
//               height: 10,
//             ),
//             Expanded(
//                 flex: 8,
//                 child: ListView.builder(
//                     // physics: const NeverScrollableScrollPhysics(),
//                     // padding: const EdgeInsets.only(top: 10, bottom: 10),
//                     itemCount: etcEntires.length,
//                     itemBuilder: (BuildContext context, index) {
//                       return TextButton.icon(
//                         style: TextButton.styleFrom(
//                             foregroundColor: Colors.black,
//                             alignment: Alignment.centerLeft),
//                         icon: etcIcons[index],
//                         label: Text(
//                           etcEntires[index],
//                           semanticsLabel: etcEntires[index],
//                           style: const TextStyle(
//                               fontWeight: FontWeight.w600,
//                               fontFamily: 'NanumGothic'),
//                         ),
//                         onPressed: () async {
//                           HapticFeedback.lightImpact(); // 약한 진동
//                           // 가독성 면에서 switch 문으로 변경하기!!!!
//                           if (index == 0) {
//                             await Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (context) => const FreqQuestion()),
//                             );
//                           } else if (index == 1) {
//                             await Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (context) => const MyReport()),
//                             );
//                           } else if (index == 2) {
//                             await Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (context) => const MyBlock()),
//                             );
//                           } else if (index == 3) {
//                             await Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (context) => const ToDeveloper()),
//                             );
//                           } else if (index == 4) {
//                             await Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (context) => const PersonalData()),
//                             );
//                           } else if (index == 5) {
//                             await Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (context) => const UsingPolicy()),
//                             );
//                           } else {
//                             _logout(context);
//                           }
//                           //  else {
//                           //   popUpDialog(context);
//                           // }
//                         },
//                       );
//                     })),
//           ],
//         )),
//       ),
//     );
//   }
// }
