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
  String? uid;
  String? displayName;
  User? user;

  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser;
    uid = user!.uid;
    // displayName = user!.displayName;
    displayName = "안지원";
  }

  final List<String> myEntires = <String>["내가 쓴 마음온도 글", "내가 쓴 마음 나눔 글", "스크랩"];
  final List<Icon> myIcons = <Icon>[
    Icon(Icons.groups),
    Icon(Icons.volunteer_activism),
    Icon(Icons.star_border_outlined)
  ];

  final List<String> etcEntires = <String>["자주 묻는 질문", "개발자에게 문의하기", "로그아웃"];
  final List<Icon> etcIcons = <Icon>[
    Icon(Icons.help),
    Icon(Icons.question_answer),
    Icon(Icons.logout)
  ];

  @override
  Widget build(BuildContext context) {
    final SignOut = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Theme.of(context).primaryColor,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () async {
          await _auth.signOut();
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
                Text(displayName!,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    )),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Divider(thickness: 1, height: 1, color: Colors.black26),
            SizedBox(
              height: 30,
            ),
            // 이름 입력
            Text(
              "나의 활동",
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.w700),
            ),
            SizedBox(
              height: 20,
            ),
            ListView.builder(
                padding: const EdgeInsets.all(10),
                itemCount: myEntires.length,
                itemBuilder: (BuildContext context, index) {
                  return TextButton.icon(
                    icon: myIcons[index],
                    label: Text(myEntires[index]),
                    onPressed: () {},
                  );
                }),
          ],
        )),
      ),
    );
  }
}
