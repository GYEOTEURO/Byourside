import 'package:byourside/model/load_data.dart';
import 'package:byourside/model/save_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class UserBlockListController extends GetxController {
  
  final User? user = FirebaseAuth.instance.currentUser;
  final LoadData loadData = LoadData();
  final SaveData saveData = SaveData();

  List<String> blockedUser = [];
  List<String> initalBlockedUser = [];

  void initState() async {
    DocumentSnapshot<Map<String, dynamic>> document = await loadData.readUserInfo(uid: user!.uid);
    blockedUser = document.data()!['blockedUser'] == null
            ? []
            : document.data()!['blockedUser'].cast<String>();
    initalBlockedUser = blockedUser;
    print('*************시작: $blockedUser');
  }

  @override
  void onClose() {
    if(initalBlockedUser != blockedUser) {
      saveData.changeBlock(user!.uid, blockedUser);
      print('*************종료: $blockedUser');
    }
    super.onClose();
  }

  void addBlockedUser(String uid) {
    blockedUser.add(uid);
    print('*************추가: $blockedUser');
  }

  void removeBlockedUser(String uid) {
    blockedUser.remove(uid);
    print('*************삭제: $blockedUser');
  }

}
