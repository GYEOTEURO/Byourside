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
  List<String>? imgInfos;
  List<String>? type;
  int? likes;
  List<String>? likesPeople;
  List<String>? scrapPeople;
  List<String>? keyword;

  NanumPostModel(
      {this.id,
      this.uid,
      this.title,
      this.nickname,
      this.content,
      this.price,
      this.isCompleted,
      this.datetime,
      this.images,
      this.imgInfos,
      this.type,
      this.likes,
      this.likesPeople,
      this.scrapPeople,
      this.keyword});

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
            ? null
            : doc.data()!["images"].cast<String>(),
        // imgInfos 추가 해야함

        type = doc.data()!["type"] == null
            ? null
            : doc.data()!["type"].cast<String>(),
        likes = doc.data()!["likes"],
        // ignore: prefer_null_aware_operators
        likesPeople = doc.data()!["likesPeople"] == null
            ? null
            : doc.data()!["likesPeople"].cast<String>(),
        // ignore: prefer_null_aware_operators
        scrapPeople = doc.data()!["scrapPeople"] == null
            ? null
            : doc.data()!["scrapPeople"].cast<String>(),
        keyword = doc.data()!["keyword"] == null
            ? null
            : doc.data()!["keyword"].cast<String>();

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
      'type': type,
      'likes': likes,
      'likesPeople': likesPeople,
      'scrapPeople': scrapPeople,
      'keyword': keyword,
    };
  }
}
