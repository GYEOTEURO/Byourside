import 'package:cloud_firestore/cloud_firestore.dart';

class CommentModel {
  String? id;
  String? uid;
  String? nickname;
  String? content;
  Timestamp? datetime;

  CommentModel({this.id, this.uid, this.nickname, this.content, this.datetime});

  CommentModel.fromMap(DocumentSnapshot<Map<String, dynamic>> doc)
      : id = doc.id,
        uid = doc["uid"],
        nickname = doc["nickname"],
        content = doc["content"],
        datetime = doc["datetime"];

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'nickname': nickname,
      'content': content,
      'datetime': datetime,
    };
  }
}