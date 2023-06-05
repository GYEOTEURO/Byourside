import 'package:cloud_firestore/cloud_firestore.dart';

class OndoPostModel {
  String? id;
  String? uid;
  String? title;
  String? nickname;
  String? content;
  Timestamp? datetime;
  List<String>? images;
  List<String>? imgInfos;
  String? category;
  List<String>? type;
  int? likes;
  List<String>? likesPeople;
  List<String>? scrapPeople;
  List<String>? keyword;

  OndoPostModel(
      {this.id,
      this.uid,
      this.title,
      this.nickname,
      this.content,
      this.datetime,
      this.images,
      this.imgInfos,
      this.category,
      this.type,
      this.likes,
      this.likesPeople,
      this.scrapPeople,
      this.keyword});

  // List<> 형태면 doc.data()!["images"] == null ? null : doc.data()!["images"].cast<String>(),
  // 이외는 uid = doc.data()!["uid"],
  OndoPostModel.fromMap(DocumentSnapshot<Map<String, dynamic>> doc) //변환한다는 의미를 살린 이름 짓기
      : id = doc.id,
        uid = doc.data()!["uid"],
        title = doc.data()!["title"],
        nickname = doc.data()!["nickname"],
        content = doc.data()!["content"],
        datetime = doc.data()!["datetime"],
        // ignore: prefer_null_aware_operators
        images = doc.data()!["images"] == null
            ? null
            : doc.data()!["images"].cast<String>(),
        imgInfos = doc.data()!["imgInfos"] == null
            ? null
            : doc.data()!["imgInfos"].cast<String>(),
        category = doc.data()!["category"],
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

  Map<String, dynamic> toMap() { // 저장의 의미
    return {
      'uid': uid,
      'title': title,
      'nickname': nickname,
      'content': content,
      'datetime': datetime,
      'images': images,
      'imgInfos': imgInfos,
      'category': category,
      'type': type,
      'likes': likes,
      'likesPeople': likesPeople,
      'scrapPeople': scrapPeople,
      'keyword': keyword,
    };
  }
}
