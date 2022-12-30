import 'package:cloud_firestore/cloud_firestore.dart';

class OndoPostModel {
  String? id;
  String? uid;
  String? title;
  String? nickname;
  String? content;
  Timestamp? datetime;
  List<String>? images;

  OndoPostModel({this.id, this.uid, this.title, this.nickname, this.content, this.datetime, this.images});

  OndoPostModel.fromMap(DocumentSnapshot<Map<String, dynamic>> doc)
      : id = doc.id,
        uid = doc.data()!["uid"],
        title = doc.data()!["title"],
        nickname = doc.data()!["nickname"],
        content = doc.data()!["content"],
        datetime = doc.data()!["datetime"],
        // ignore: prefer_null_aware_operators
        images = doc.data()!["images"] == null
            ? null : doc.data()!["images"].cast<String>();
            
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'title': title,
      'nickname': nickname,
      'content': content,
      'datetime': datetime,
      'images': images,
    };
  }
}