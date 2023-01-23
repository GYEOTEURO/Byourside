import 'package:byourside/main.dart';
import 'package:byourside/model/firebase_user.dart';
import 'package:byourside/screen/authenticate/personal_data.dart';
import 'package:byourside/screen/authenticate/using_policy.dart';
import 'package:byourside/screen/mypage/myBlock.dart';
import 'package:byourside/screen/mypage/myDeclaration.dart';
import 'package:byourside/screen/mypage/freq_question.dart';
import 'package:byourside/screen/mypage/myNanumPost.dart';
import 'package:byourside/screen/mypage/myOndoPost.dart';
import 'package:byourside/screen/mypage/myScrapNanumPost.dart';
import 'package:byourside/screen/mypage/myScrapOndoPost.dart';
import 'package:byourside/screen/mypage/to_developer.dart';
import 'package:byourside/widget/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Mypage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _Mypage();
  }
}

class _Mypage extends State<Mypage> {
  final AuthService _auth = new AuthService();
  late String uid;
  late String displayName;
  User? user;

  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser;
    uid = user!.uid;
    // displayName = user!.displayName;
    displayName = user!.displayName!;
  }

  final List<String> myEntires = <String>[
    "내가 쓴 마음온도 글",
    "내가 쓴 마음나눔 글",
    "마음온도 스크랩",
    "마음나눔 스크랩"
  ];
  final List<Icon> myIcons = <Icon>[
    Icon(Icons.groups, semanticLabel: '내가 쓴 마음온도 글 목록 화면으로 이동'),
    Icon(Icons.volunteer_activism, semanticLabel: '내가 쓴 마음나눔 글 목록 화면으로 이동'),
    Icon(Icons.star_border_outlined, semanticLabel: '스크랩한 마음온도 글 목록 화면으로 이동'),
    Icon(Icons.star_border_outlined, semanticLabel: '스크랩한 마음나눔 글 목록 화면으로 이동')
  ];
  final List<Widget> myConnectPage = <Widget>[
    MyOndoPost(),
    MyNanumPost(),
    MyScrapOndoPost(),
    MyScrapNanumPost()
  ];

  final List<String> etcEntires = <String>[
    "자주 묻는 질문",
    "사용자 신고하기",
    "사용자 차단하기",
    "개발자에게 문의하기",
    "개인정보 처리방침",
    "서비스 이용약관",
    "로그아웃",
    // "탈퇴"
  ];
  final List<Icon> etcIcons = <Icon>[
    Icon(Icons.help, semanticLabel: '자주 묻는 질문 목록 화면으로 이동'),
    Icon(Icons.report_problem, semanticLabel: '사용자 신고 화면으로 이동'),
    Icon(Icons.dnd_forwardslash, semanticLabel: '사용자 차단 화면으로 이동'),
    Icon(Icons.question_answer, semanticLabel: '개발자에게 문의하기 화면으로 이동'),
    Icon(Icons.archive, semanticLabel: '개인정보 처리방침 화면으로 이동'),
    Icon(Icons.receipt_long_rounded, semanticLabel: '서비스 이용약관 화면으로 이동'),
    Icon(Icons.logout, semanticLabel: '로그아웃'),
    // Icon(
    //   Icons.outbox,
    //   semanticLabel: '탈퇴',
    // )
  ];

  void _logout(context) async {
    FirebaseUser(uid: null, phoneNum: null, displayName: null, code: null);
    await _auth.signOut();
    Navigator.of(context).popUntil((route) => route.isFirst);
  }

  // void _withdrawal(context, password) async {
  //   FirebaseUser(uid: null, phoneNum: null, displayName: null, code: null);
  //   await _auth.withdrawalAccount(password);
  //   Navigator.of(context).popUntil((route) => route.isFirst);
  // }

  @override
  Widget build(BuildContext context) {
    // final user =  Provider.of<FirebaseUser?>(context);
    String password = "";

    // void popUpDialog(BuildContext context) {
    //   showDialog(
    //       barrierDismissible: false,
    //       context: context,
    //       builder: (context) {
    //         return StatefulBuilder(builder: ((context, setState) {
    //           return AlertDialog(
    //             semanticLabel:
    //                 "탈퇴 버튼입니다. 탈퇴 후 동일한 번호로 재가입이 불가능합니다. 탈퇴를 원하시면 비밀번호를 입력하세요.",
    //             title: const Text(
    //               "탈퇴",
    //               semanticsLabel: "탈퇴",
    //               textAlign: TextAlign.left,
    //               style: const TextStyle(
    //                   color: Colors.black,
    //                   fontSize: 17,
    //                   fontFamily: 'NanumGothic',
    //                   fontWeight: FontWeight.w600),
    //             ),
    //             content: Column(
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
    //                 TextField(
    //                   autofocus: true,
    //                   onChanged: (val) {
    //                     if (mounted) {
    //                       setState(() {
    //                         password = val;
    //                       });
    //                     }
    //                   },
    //                   style: const TextStyle(
    //                       color: Colors.black,
    //                       fontSize: 17,
    //                       fontFamily: 'NanumGothic',
    //                       fontWeight: FontWeight.w600),
    //                   decoration: InputDecoration(
    //                       enabledBorder: OutlineInputBorder(
    //                           borderSide: BorderSide(
    //                               color: Theme.of(context).primaryColor),
    //                           borderRadius: BorderRadius.circular(20)),
    //                       errorBorder: OutlineInputBorder(
    //                           borderSide: const BorderSide(color:                   Color.fromARGB(255, 255, 45, 45)),
    //                           borderRadius: BorderRadius.circular(20)),
    //                       focusedBorder: OutlineInputBorder(
    //                           borderSide: BorderSide(
    //                               color: Theme.of(context).primaryColor),
    //                           borderRadius: BorderRadius.circular(20))),
    //                 ),
    //               ],
    //             ),
    //             actions: [
    //               ElevatedButton(
    //                 onPressed: () {
    //                   HapticFeedback.lightImpact(); // 약한 진동
    //                   Navigator.of(context).pop();
    //                 },
    //                 style:
    //                     ElevatedButton.styleFrom(backgroundColor: primaryColor),
    //                 child: const Text(
    //                   "취소",
    //                   semanticsLabel: "취소",
    //                   style: TextStyle(
    //                       fontSize: 17,
    //                       fontFamily: 'NanumGothic',
    //                       fontWeight: FontWeight.w500),
    //                 ),
    //               ),
    //               ElevatedButton(
    //                 onPressed: () async {
    //                   _withdrawal(context, password);
    //                   // Navigator.of(context).popUntil((route) => route.isFirst);
    //                 },
    //                 style:
    //                     ElevatedButton.styleFrom(backgroundColor: primaryColor),
    //                 child: const Text(
    //                   "완료",
    //                   semanticsLabel: "완료",
    //                   style: TextStyle(
    //                       fontSize: 17,
    //                       fontFamily: 'NanumGothic',
    //                       fontWeight: FontWeight.w500),
    //                 ),
    //               )
    //             ],
    //           );
    //         }));
    //       });
    // }

    final SignOut = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xFF045558),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () async {
          FirebaseUser(
              uid: null, phoneNum: null, displayName: null, code: null);
          await _auth.signOut();
          Navigator.of(context).popUntil((route) => route.isFirst);
        },
        child: Text(
          "Log out",
          style: TextStyle(color: Color(0xFF045558)),
          textAlign: TextAlign.center,
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '마이페이지',
          style:
              TextStyle(fontFamily: 'NanumGothic', fontWeight: FontWeight.w600),
          semanticsLabel: '마이페이지(나의 정보 화면)',
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xFF045558),
      ),
      body: Container(
        padding: const EdgeInsets.all(30),
        child: Center(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                RawMaterialButton(
                  onPressed: null,
                  elevation: 2.0,
                  fillColor: Colors.grey,
                  child: Icon(
                    Icons.person,
                    size: 50.0,
                    semanticLabel: '사용자의 기본 프로필 사진',
                  ),
                  padding: EdgeInsets.all(15.0),
                  shape: CircleBorder(),
                ),
                SizedBox(
                  width: 20,
                ),
                // 나만의 명함 만들기
                Text(displayName,
                    overflow: TextOverflow.ellipsis,
                    semanticsLabel: '사용자 닉네임: ${displayName}',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                        fontFamily: 'NanumGothic')),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Divider(thickness: 1, height: 1, color: Colors.black26),
            SizedBox(
              height: 30,
            ),
            // 이름 입력
            Text(
              "나의 활동",
              semanticsLabel: '나의 활동',
              style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'NanumGothic'),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
                flex: 5,
                child: ListView.builder(
                    // physics: const NeverScrollableScrollPhysics(),
                    // padding: const EdgeInsets.only(top: 10, bottom: 10),
                    itemCount: myEntires.length,
                    itemBuilder: (BuildContext context, index) {
                      return TextButton.icon(
                        style: TextButton.styleFrom(
                            foregroundColor: Colors.black,
                            alignment: Alignment.centerLeft),
                        icon: myIcons[index],
                        label: Text(
                          myEntires[index],
                          semanticsLabel: myEntires[index],
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontFamily: 'NanumGothic'),
                        ),
                        onPressed: () {
                          HapticFeedback.lightImpact(); // 약한 진동
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => myConnectPage[index]));
                        },
                      );
                    })),
            Divider(thickness: 1, height: 1, color: Colors.black26),
            SizedBox(
              height: 15,
            ),
            Text(
              "기타",
              semanticsLabel: '기타',
              style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'NanumGothic'),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
                flex: 8,
                child: ListView.builder(
                    // physics: const NeverScrollableScrollPhysics(),
                    // padding: const EdgeInsets.only(top: 10, bottom: 10),
                    itemCount: etcEntires.length,
                    itemBuilder: (BuildContext context, index) {
                      return TextButton.icon(
                        style: TextButton.styleFrom(
                            foregroundColor: Colors.black,
                            alignment: Alignment.centerLeft),
                        icon: etcIcons[index],
                        label: Text(
                          etcEntires[index],
                          semanticsLabel: etcEntires[index],
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontFamily: 'NanumGothic'),
                        ),
                        onPressed: () async {
                          HapticFeedback.lightImpact(); // 약한 진동
                          if (index == 0) {
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const FreqQuestion()),
                            );
                          } else if (index == 1) {
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MyDeclaration()),
                            );
                          } else if (index == 2) {
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MyBlock()),
                            );
                          } else if (index == 3) {
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const ToDeveloper()),
                            );
                          } else if (index == 4) {
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PersonalData()),
                            );
                          } else if (index == 5) {
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const UsingPolicy()),
                            );
                          } else {
                            _logout(context);
                          }
                          //  else {
                          //   popUpDialog(context);
                          // }
                        },
                      );
                    })),
          ],
        )),
      ),
    );
  }
}
