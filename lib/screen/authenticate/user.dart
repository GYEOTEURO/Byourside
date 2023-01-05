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
    return Scaffold(
        appBar: AppBar(backgroundColor: primaryColor),
        body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const SizedBox(height: 25.0),
                      Material(
                          elevation: 5.0,
                          borderRadius: BorderRadius.circular(30.0),
                          color: Theme.of(context).primaryColor,
                          child: MaterialButton(
                            minWidth: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.fromLTRB(
                                20.0, 15.0, 20.0, 15.0),
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) => protector()),
                              );
                            },
                            child: Text(
                              '장애 아동 보호자',
                              style: TextStyle(
                                  color: Theme.of(context).primaryColorLight),
                              textAlign: TextAlign.center,
                            ),
                          )),
                      const SizedBox(height: 25.0),
                      Material(
                          elevation: 5.0,
                          borderRadius: BorderRadius.circular(30.0),
                          color: Theme.of(context).primaryColor,
                          child: MaterialButton(
                            minWidth: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.fromLTRB(
                                20.0, 15.0, 20.0, 15.0),
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) => participator()),
                              );
                            },
                            child: Text(
                              '관계자',
                              style: TextStyle(
                                  color: Theme.of(context).primaryColorLight),
                              textAlign: TextAlign.center,
                            ),
                          )),
                      const SizedBox(height: 25.0),
                      Material(
                          elevation: 5.0,
                          borderRadius: BorderRadius.circular(30.0),
                          color: Theme.of(context).primaryColor,
                          child: MaterialButton(
                            minWidth: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.fromLTRB(
                                20.0, 15.0, 20.0, 15.0),
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) => someoneElse()),
                              );
                            },
                            child: Text(
                              '그외',
                              style: TextStyle(
                                  color: Theme.of(context).primaryColorLight),
                              textAlign: TextAlign.center,
                            ),
                          )),
                      const SizedBox(height: 15.0),
                    ]),
              ),
            ]));
  }
}
