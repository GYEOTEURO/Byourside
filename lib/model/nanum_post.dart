import 'package:cloud_firestore/cloud_firestore.dart';

class NanumPostModel {
  String? id;
  String? uid;
  String? title;
  String? nickname;
  String? content;
  String? price;
  bool? isCompleted;
  Timestamp? datetime;
  List<String>? images;

  NanumPostModel({this.id, this.uid, this.title, this.nickname, this.content, this.price, this.isCompleted, this.datetime, this.images});

  NanumPostModel.fromMap(DocumentSnapshot<Map<String, dynamic>> doc)
      : id = doc.id,
        uid = doc.data()!["uid"],
        title = doc.data()!["title"],
        nickname = doc.data()!["nickname"],
        content = doc.data()!["content"],
        price = doc.data()!["price"],
        isCompleted = doc.data()!["isCompleted"],
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
      'price': price,
      'isCompleted': isCompleted,
      'datetime': datetime,
      'images': images,
    };
  }
}