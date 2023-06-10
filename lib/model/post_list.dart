import 'package:cloud_firestore/cloud_firestore.dart';

class PostListModel {
  String? id;
  String? nickname;
  String? title;
  Timestamp? datetime;
  List<String>? images;
  List<String>? imgInfos;
  String? category;
  bool? isCompleted;
  List<String>? type;

  PostListModel({this.id, this.nickname, this.title, this.datetime, this.images, this.imgInfos, this.category, this.isCompleted, this.type});

  PostListModel.fromMap(DocumentSnapshot<Map<String, dynamic>> doc, String collectionName)
      : id = doc.id,
        nickname = doc["nickname"],
        title = doc["title"],
        datetime = doc["datetime"],
        // ignore: prefer_null_aware_operators
        images = doc["images"] == null
            ? null : doc["images"].cast<String>(),
        imgInfos = doc["imgInfos"] == null
            ? null : doc["imgInfos"].cast<String>(),
        category = (collectionName == 'ondoPost') ? doc["category"] : null,
        isCompleted = (collectionName == 'nanumPost') ? doc["isCompleted"] : null,
        type = doc["type"] == null
            ? null : doc["type"].cast<String>();
}