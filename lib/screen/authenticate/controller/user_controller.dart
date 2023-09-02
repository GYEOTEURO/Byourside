import 'package:byourside/model/load_data.dart';
import 'package:byourside/model/save_data.dart';
import 'package:byourside/model/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  
  final User? user = FirebaseAuth.instance.currentUser;
  final LoadData loadData = LoadData();
  final SaveData saveData = SaveData();

  late UserModel userModel;

  void initState() async {
    DocumentSnapshot<Map<String, dynamic>> document = await loadData.readUserInfo(uid: user!.uid);
    userModel = UserModel.fromDocument(doc: document);
    print('*************장애유형: ${userModel.disabilityType}');
    print('*************닉넴: ${userModel.nickname}');
    print('*************블락드유저: ${userModel.blockedUsers}');
    print('*************area: ${userModel.area}');
     print('*************district: ${userModel.district}');
  }

  UserController() {
    initState();
  }

  void addBlockedUser(String blockUid) {
    userModel.blockedUsers!.add(blockUid);
    saveData.addBlock(user!.uid, blockUid);
    print('*************추가: ${userModel.blockedUsers}');
    update();
  }

  void removeBlockedUser(String blockUid) {
    userModel.blockedUsers!.remove(blockUid);
    saveData.cancelBlock(user!.uid, blockUid);
    print('*************삭제: ${userModel.blockedUsers}');
    update();
  }

}
