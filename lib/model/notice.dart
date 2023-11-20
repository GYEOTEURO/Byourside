import 'package:cloud_firestore/cloud_firestore.dart';

class NoticeModel {
  String? id;
  final String title;
  final String content;
  final Timestamp createdAt;

  NoticeModel({
    this.id, 
    required this.title, 
    required this.content, 
    required this.createdAt
  });

  NoticeModel.fromDocument({required DocumentSnapshot<Map<String, dynamic>> doc})
      : id = doc.id,
        title = doc['title'],
        content = doc['content'],
        createdAt = doc['createdAt'];

  Map<String, dynamic> convertToDocument() {
    return {
      'title': title,
      'content': content,
      'createdAt': createdAt,
    };
  }
}