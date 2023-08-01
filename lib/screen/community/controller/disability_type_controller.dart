import 'package:byourside/model/load_data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommunityDisabilityTypeController extends GetxController {
  //final User? user = FirebaseAuth.instance.currentUser;
  //final LoadData loadData = LoadData();
  //StreamBuilder
  //loadData.readUserInfo(uid: user!.uid);
  
  String disabilityType = '발달'; //user의 원래값

  void changeDisabilityType(String selectedDisabilityType) {
    disabilityType = selectedDisabilityType;
  }
}
