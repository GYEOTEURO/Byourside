import 'package:cloud_firestore/cloud_firestore.dart';

class CommunityPostModel {
  String? id;
  final String uid;
  final String nickname;
  final String title;
  final String content;
  final Timestamp createdAt;
  final String disabilityType;
  List<String>? images;
  List<String>? imgInfos;
  final int likes;
  
  CommunityPostModel({
      this.id,
      required this.uid,
      required this.nickname,
      required this.title,
      required this.content,
      required this.createdAt,
      required this.disabilityType,
      this.images,
      this.imgInfos,
      required this.likes
  });

  // List<> 형태면 doc.data()!["images"] == null ? null : doc.data()!["images"].cast<String>(),
  // 이외는 uid = doc.data()!["uid"],
  //factory CommunityPostModel
  CommunityPostModel.fromDocument({required DocumentSnapshot<Map<String, dynamic>> doc}) //변환한다는 의미를 살린 이름 짓기
      : id = doc.id,
        uid = doc.data()!['uid'],
        nickname = doc.data()!['nickname'],
        title = doc.data()!['title'],
        content = doc.data()!['content'],
        createdAt = doc.data()!['createdAt'],
        disabilityType = doc.data()!['disabilityType'],
        images = doc.data()!['images'] == null
            ? null
            : doc.data()!['images'].cast<String>(),
        imgInfos = doc.data()!['imgInfos'] == null
            ? null
            : doc.data()!['imgInfos'].cast<String>(),
        likes = doc.data()!['likes'];

  Map<String, dynamic> convertToDocument() { // 저장의 의미
    return {
      'uid': uid,
      'nickname': nickname,
      'title': title,
      'content': content,
      'createdAt': createdAt,
      'disabilityType': disabilityType,
      'images': images,
      'imgInfos': imgInfos,
      'likes': likes,
    };
  }
}

// factory constructor : 해당 클래스를 상속하는 자식 클래스의 인스턴스도 반환할 수 있다