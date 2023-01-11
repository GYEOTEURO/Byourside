// ignore_for_file: deprecated_member_use

import 'package:byourside/main.dart';
import 'package:byourside/model/firebase_user.dart';
import 'package:byourside/screen/authenticate/user_paricipator.dart';
import 'package:byourside/screen/authenticate/user_protector.dart';
import 'package:byourside/screen/authenticate/user_someoneElse.dart';
import 'package:byourside/screen/authenticate/verify_email.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';

class SetupUser extends StatefulWidget {
  const SetupUser({Key? key}) : super(key: key);

  @override
  State<SetupUser> createState() => _SetupUserState();
}

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
            title: Text("유형 선택",
                semanticsLabel: "유형 선택",
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
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              SizedBox(
                                height: height * 0.04,
                                width: width * 0.8,
                              ),
                              Center(
                                child: Material(
                                    elevation: 5.0,
                                    borderRadius: BorderRadius.circular(20.0),
                                    color: Theme.of(context).primaryColor,
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
                                                  protector()),
                                        );
                                      },
                                      child: Text(
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
                                                participator()),
                                      );
                                    },
                                    child: Text(
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
                                            builder: (context) =>
                                                someoneElse()),
                                      );
                                    },
                                    child: Text(
                                      '그외',
                                      semanticsLabel: '그외',
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
