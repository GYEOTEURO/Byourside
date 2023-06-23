import 'package:byourside/main.dart';
import 'package:byourside/screen/authenticate/info/user_paricipator.dart';
import 'package:byourside/screen/authenticate/info/user_protector.dart';
import 'package:byourside/screen/authenticate/info/user_self.dart';
import 'package:byourside/screen/authenticate/info/user_someone_else.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SetupUser extends StatefulWidget {
  const SetupUser({Key? key}) : super(key: key);

  @override
  State<SetupUser> createState() => _SetupUserState();
}

// TODO: auth에 등록된 사용자랑 매치할 방법 없음. 정보 같이 저장해라
class _SetupUserState extends State<SetupUser> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            elevation: 0,
            title: const Text('유형 선택',
                semanticsLabel: '유형 선택',
                style: TextStyle(
                    fontFamily: 'NanumGothic', fontWeight: FontWeight.bold)),
            backgroundColor: primaryColor),
        body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              const Padding(
                                padding: EdgeInsets.fromLTRB(0, 10, 20, 0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      '3/4 단계',
                                      semanticsLabel: '3/4 단계',
                                      style: TextStyle(
                                          color: primaryColor,
                                          fontSize: 20,
                                          fontFamily: 'NanumGothic',
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: height * 0.04,
                                width: width * 0.8,
                              ),
                              Center(
                                child: Material(
                                    elevation: 5.0,
                                    borderRadius: BorderRadius.circular(20.0),
                                    color: primaryColor,
                                    child: MaterialButton(
                                      minWidth:
                                          MediaQuery.of(context).size.width *
                                              0.9,
                                      padding: const EdgeInsets.fromLTRB(
                                          20.0, 15.0, 20.0, 15.0),
                                      onPressed: () {
                                        HapticFeedback.lightImpact();
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const Protector()),
                                        );
                                      },
                                      child: const Text(
                                        '장애 아동 보호자',
                                        semanticsLabel: '장애 아동 보호자',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontFamily: 'NanumGothic',
                                            fontWeight: FontWeight.w500),
                                        textAlign: TextAlign.center,
                                      ),
                                    )),
                              ),
                              SizedBox(height: height * 0.04),
                              Material(
                                  elevation: 5.0,
                                  borderRadius: BorderRadius.circular(20.0),
                                  color: Theme.of(context).primaryColor,
                                  child: MaterialButton(
                                    minWidth:
                                        MediaQuery.of(context).size.width * 0.9,
                                    padding: const EdgeInsets.fromLTRB(
                                        20.0, 15.0, 20.0, 15.0),
                                    onPressed: () {
                                      HapticFeedback.lightImpact(); // 약한 진동
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const Participator()),
                                      );
                                    },
                                    child: const Text(
                                      '관계자',
                                      semanticsLabel: '관계자',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontFamily: 'NanumGothic',
                                          fontWeight: FontWeight.w500),
                                      textAlign: TextAlign.center,
                                    ),
                                  )),
                              SizedBox(height: height * 0.04),
                              Material(
                                  elevation: 5.0,
                                  borderRadius: BorderRadius.circular(20.0),
                                  color: Theme.of(context).primaryColor,
                                  child: MaterialButton(
                                    minWidth:
                                        MediaQuery.of(context).size.width * 0.9,
                                    padding: const EdgeInsets.fromLTRB(
                                        20.0, 15.0, 20.0, 15.0),
                                    onPressed: () {
                                      HapticFeedback.lightImpact(); // 약한 진동
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) => const Self()),
                                      );
                                    },
                                    child: const Text(
                                      '장애인 당사자',
                                      semanticsLabel: '장애인 당사자',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontFamily: 'NanumGothic',
                                          fontWeight: FontWeight.w500),
                                      textAlign: TextAlign.center,
                                    ),
                                  )),
                              SizedBox(height: height * 0.04),
                              Material(
                                  elevation: 5.0,
                                  borderRadius: BorderRadius.circular(20.0),
                                  color: Theme.of(context).primaryColor,
                                  child: MaterialButton(
                                    minWidth:
                                        MediaQuery.of(context).size.width * 0.9,
                                    padding: const EdgeInsets.fromLTRB(
                                        20.0, 15.0, 20.0, 15.0),
                                    onPressed: () {
                                      HapticFeedback.lightImpact(); // 약한 진동
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const SomeoneElse()),
                                      );
                                    },
                                    child: const Text(
                                      '그 외',
                                      semanticsLabel: '그 외',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontFamily: 'NanumGothic',
                                          fontWeight: FontWeight.w500),
                                      textAlign: TextAlign.center,
                                    ),
                                  )),
                              const SizedBox(height: 15.0),
                            ]),
                      )),
                ])));
  }
}
