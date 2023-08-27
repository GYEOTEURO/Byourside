import 'package:byourside/model/load_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class UserBlockListController extends GetxController {
  
  final User? user = FirebaseAuth.instance.currentUser;
  final LoadData loadData = LoadData();

  List<String> blockedUser = [];

  void initState() async {
    DocumentSnapshot<Map<String, dynamic>> document = await loadData.readUserInfo(uid: user!.uid);
    blockedUser = document.data()!['blockedUser'] == null
            ? []
            : document.data()!['blockedUser'].cast<String>();
  }
}
