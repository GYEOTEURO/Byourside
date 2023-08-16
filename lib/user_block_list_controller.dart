import 'package:byourside/model/load_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserBlockListController extends GetxController {
  
  final User? user = FirebaseAuth.instance.currentUser;
  final LoadData loadData = LoadData();

  List<String>? blockList;

  UserBlockListController(){
    initalizeBlockList();
  }

  initalizeBlockList() async {
    DocumentSnapshot<Map<String, dynamic>> document = await loadData.readUserInfo(uid: user!.uid);
    blockList = document.data()!['blockList'] == null
            ? null
            : document.data()!['blockList'].cast<String>();
  }
}
