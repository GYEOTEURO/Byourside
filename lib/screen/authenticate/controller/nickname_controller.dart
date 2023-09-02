
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NicknameController extends GetxController {
  final TextEditingController controller = TextEditingController();
  final RxBool isNicknameChecked = false.obs;
  RxBool nickNameExist = false.obs;


  Future<void> checkNicknameExist(BuildContext context) async {
    var collection = FirebaseFirestore.instance.collection('userInfo');
    var querySnapshot = await collection.where('nickname', isEqualTo: controller.text).get();
    if (querySnapshot.docs.isNotEmpty) {
      nickNameExist.value = true;
    } else {
      nickNameExist.value = false;
    }
  }

}
