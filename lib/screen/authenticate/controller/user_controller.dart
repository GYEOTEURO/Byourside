import 'package:byourside/model/load_data.dart';
import 'package:byourside/model/save_data.dart';
import 'package:byourside/model/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
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
    _checkTokenValidate(userModel.pushMessage?['deviceToken'], userModel.pushMessage?['tokenCreatedAt']);
    userModelReady.value = true;
  }

  void _checkTokenValidate(String deviceToken, Timestamp tokenCreatedAt) {
    DateTime tokenCreatedAtDate = tokenCreatedAt.toDate();
    DateTime currentDate = DateTime.now();
    bool isMoreThan60Days = currentDate.difference(tokenCreatedAtDate).inDays > 60;

    if(isMoreThan60Days){
      _updateToken();
    }
  }

  void _updateToken() async {
    String? newDeviceToken = await FirebaseMessaging.instance.getToken();
    Timestamp newCreatedAt = Timestamp.now();

    userModel.pushMessage?['deviceToken'] = newDeviceToken;
    userModel.pushMessage?['tokenCreatedAt'] = newCreatedAt;
      
    Map<String, dynamic>? newToken = {
      'deviceToken': newDeviceToken,
      'tokenCreatedAt': newCreatedAt
    };
    saveData.updatePushMessageInfo(user!.uid, newToken);

    print('*****************새 토큰 업데이트됨');
  }

  void addBlockedUser(String blockUid) {
    if(!userModel.blockedUsers!.contains(blockUid)){
      userModel.blockedUsers!.add(blockUid);
      saveData.addBlock(user!.uid, blockUid);
      update();
    }
  }

  void removeBlockedUser(String blockUid) {
    userModel.blockedUsers!.remove(blockUid);
    saveData.cancelBlock(user!.uid, blockUid);
    update();
  }

}
