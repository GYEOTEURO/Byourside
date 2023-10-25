import 'package:cloud_firestore/cloud_firestore.dart';

class CommunityPostModel {
  String? id;
  final String uid;
  final String nickname;
  final String title;
  final String content;
  final Timestamp createdAt;
  final String category;
  final String disabilityType;
  List<String> images;
  List<String> imgInfos;
  final int likes;
  List<String> likesUser;
  final int scraps;
  List<String> scrapsUser;
  List<String> keyword;
  
  CommunityPostModel({
      this.id,
      required this.uid,
      required this.nickname,
      required this.title,
      required this.content,
      required this.createdAt,
      required this.category,
      required this.disabilityType,
      required this.images,
      required this.imgInfos,
      required this.likes,
      required this.scraps,
      required this.likesUser,
      required this.scrapsUser,
      required this.keyword
  });

  CommunityPostModel.fromDocument({required DocumentSnapshot<Map<String, dynamic>> doc})
      : id = doc.id,
        uid = doc.data()!['uid'],
        nickname = doc.data()!['nickname'],
        title = doc.data()!['title'],
        content = doc.data()!['content'],
        createdAt = doc.data()!['createdAt'],
        category = doc.data()!['category'],
        disabilityType = doc.data()!['disabilityType'],
        images = doc.data()!['images'] == null
            ? null
            : doc.data()!['images'].cast<String>(),
        imgInfos = doc.data()!['imgInfos'] == null
            ? null
            : doc.data()!['imgInfos'].cast<String>(),
        likes = doc.data()!['likes'],
        likesUser = doc.data()!['likesUser'] == null
            ? null
            : doc.data()!['likesUser'].cast<String>(),
        scraps = doc.data()!['scraps'],
        scrapsUser = doc.data()!['scrapsUser'] == null
            ? null
            : doc.data()!['scrapsUser'].cast<String>(),
        keyword = doc.data()!['keyword'] == null
            ? null
            : doc.data()!['keyword'].cast<String>();
        

  Map<String, dynamic> convertToDocument() {
    return {
      'uid': uid,
      'nickname': nickname,
      'title': title,
      'content': content,
      'createdAt': createdAt,
      'category': category,
      'disabilityType': disabilityType,
      'images': images,
      'imgInfos': imgInfos,
      'likes': likes,
      'likesUser': likesUser,
      'scraps': scraps,
      'scrapsUser': scrapsUser,
      'keyword' : keyword
    };
  }
}