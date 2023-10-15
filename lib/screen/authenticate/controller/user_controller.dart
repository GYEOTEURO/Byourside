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

  final RxBool userModelReady = false.obs;

  late UserModel userModel;

  @override
  void onInit() async {
    super.onInit();
    DocumentSnapshot<Map<String, dynamic>> document = await loadData.readUserInfo(uid: user!.uid);
    userModel = UserModel.fromDocument(doc: document);
    userModelReady.value = true;
  }

  void addBlockedUser(String blockUid) {
    userModel.blockedUsers!.add(blockUid);
    saveData.addBlock(user!.uid, blockUid);
    update();
  }

  void removeBlockedUser(String blockUid) {
    userModel.blockedUsers!.remove(blockUid);
    saveData.cancelBlock(user!.uid, blockUid);
    update();
  }

}
