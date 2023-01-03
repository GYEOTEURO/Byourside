import 'package:byourside/model/firebase_user.dart';
import 'package:byourside/screen/mypage/freq_question.dart';
import 'package:byourside/screen/mypage/myNanumPost.dart';
import 'package:byourside/screen/mypage/myOndoPost.dart';
import 'package:byourside/screen/mypage/myScrapNanumPost.dart';
import 'package:byourside/screen/mypage/myScrapOndoPost.dart';
import 'package:byourside/screen/mypage/to_developer.dart';
import 'package:byourside/widget/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
    Icon(Icons.groups),
    Icon(Icons.volunteer_activism),
    Icon(Icons.star_border_outlined),
    Icon(Icons.star_border_outlined)
  ];
  final List<Widget> myConnectPage = <Widget>[
    MyOndoPost(),
    MyNanumPost(),
    MyScrapOndoPost(),
    MyScrapNanumPost()
  ];

  final List<String> etcEntires = <String>["자주 묻는 질문", "개발자에게 문의하기", "로그아웃"];
  final List<Icon> etcIcons = <Icon>[
    Icon(Icons.help),
    Icon(Icons.question_answer),
    Icon(Icons.logout)
  ];

  void _logout(context) async {
    FirebaseUser(uid: null, phoneNum: null, displayName: null, code: null);
    await _auth.signOut();
    Navigator.of(context).popUntil((route) => route.isFirst);
  }

  @override
  Widget build(BuildContext context) {
    // final user =  Provider.of<FirebaseUser?>(context);

    final SignOut = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Theme.of(context).primaryColor,
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
          style: TextStyle(color: Theme.of(context).primaryColorLight),
          textAlign: TextAlign.center,
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('마이페이지'),
        backgroundColor: Theme.of(context).primaryColor,
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
                  onPressed: () {},
                  elevation: 2.0,
                  fillColor: Colors.grey,
                  child: Icon(
                    Icons.person,
                    size: 50.0,
                  ),
                  padding: EdgeInsets.all(15.0),
                  shape: CircleBorder(),
                ),
                SizedBox(
                  width: 20,
                ),
                // 나만의 명함 만들기
                Text(displayName,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    )),
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
              style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.w700),
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
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        onPressed: () {
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
              style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.w700),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
                flex: 3,
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
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        onPressed: () async {
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
                                  builder: (context) => const ToDeveloper()),
                            );
                          } else {
                            _logout(context);
                          }
                        },
                      );
                    })),
          ],
        )),
      ),
    );
  }
}
