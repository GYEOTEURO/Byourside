import 'package:cloud_firestore/cloud_firestore.dart';

class PostListModel {
  String? id;
  String? nickname;
  String? title;
  Timestamp? datetime;
  List<String>? images;


  PostListModel({this.id, this.nickname, this.title, this.datetime, this.images});

  PostListModel.fromMap(DocumentSnapshot<Map<String, dynamic>> doc)
      : id = doc.id,
        nickname = doc["nickname"],
        title = doc["title"],
        datetime = doc["datetime"],
        // ignore: prefer_null_aware_operators
        images = doc["images"] == null
            ? null : doc["images"].cast<String>();
}