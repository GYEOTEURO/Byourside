import 'package:cloud_firestore/cloud_firestore.dart';

class UserForBlockList {
  List<String> blockList;

  UserForBlockList({this.blockList});

  UserForBlockList.fromMap(DocumentSnapshot<Map<String, dynamic>> doc)
      : // ignore: prefer_null_aware_operators
        blockList = doc.data()!["blockList"] == null
        ? null
        : doc.data()!["blockList"].cast<String>();

  Map<String, dynamic> toMap() {
    return {
      'blockList': blockList,
    };
  }
}
