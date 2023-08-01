import 'package:cloud_firestore/cloud_firestore.dart';

class CommentModel {
  String? id;
  final String uid;
  final String nickname;
  final String content;
  final Timestamp createdAt;

  CommentModel({
    this.id, 
    required this.uid, 
    required this.nickname, 
    required this.content, 
    required this.createdAt
  });

  CommentModel.fromDocument({required DocumentSnapshot<Map<String, dynamic>> doc})
      : id = doc.id,
        uid = doc['uid'],
        nickname = doc['nickname'],
        content = doc['content'],
        createdAt = doc['createdAt'];

  Map<String, dynamic> convertToDocument() {
    return {
      'uid': uid,
      'nickname': nickname,
      'content': content,
      'createdAt': createdAt,
    };
  }
}