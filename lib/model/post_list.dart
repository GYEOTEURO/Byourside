import 'package:cloud_firestore/cloud_firestore.dart';

// ignore: empty_constructor_bodies, empty_constructor_bodies
class PostListModel {
  String? id;
  String? nickname;
  String? title;
  Timestamp? datetime;
  List<String>? images;
  String? category;
  bool? isCompleted;

  PostListModel({this.id, this.nickname, this.title, this.datetime, this.images, this.category, this.isCompleted});

  PostListModel.fromMap(DocumentSnapshot<Map<String, dynamic>> doc, String collection)
      : id = doc.id,
        nickname = doc["nickname"],
        title = doc["title"],
        datetime = doc["datetime"],
        // ignore: prefer_null_aware_operators
        images = doc["images"] == null
            ? null : doc["images"].cast<String>(),
        category = (collection == 'ondoPost') ? doc["category"] : null,
        isCompleted = (collection == 'nanumPost') ? doc["isCompleted"] : null;
}