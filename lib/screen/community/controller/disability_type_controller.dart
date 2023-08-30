import 'package:byourside/model/load_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommunityDisabilityTypeController extends GetxController {
  
  // final User? user = FirebaseAuth.instance.currentUser;
  // final LoadData loadData = LoadData();

  // late String disabilityType;

  // CommunityDisabilityTypeController(){
  //   initalizeDisabilityType();
  // }

  // initalizeDisabilityType() async {
  //   DocumentSnapshot<Map<String, dynamic>> document = await loadData.readUserInfo(uid: user!.uid);
  //   disabilityType = document.data()!['disabilityType'];
  // }
  
  String disabilityType = '발달'; //user의 원래값

  void changeDisabilityType(String selectedDisabilityType) {
    disabilityType = selectedDisabilityType;
  }
}
