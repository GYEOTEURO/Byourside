import 'package:cloud_firestore/cloud_firestore.dart';

class AutoInformationPostModel {
  String? id;
  final String title;
  final String content;
  final Timestamp createdAt;
  final Timestamp date;
  final String category;
  final String disabilityType;
  final String site;
  List<String> region;
  final String originalLink;
  final String contentLink;
  List<String> images;
  final int scraps;
  List<String> scrapsUser;
  List<String> keyword;

  AutoInformationPostModel(
      {this.id,
      required this.title,
      required this.content,
      required this.createdAt,
      required this.date,
      required this.category,
      required this.disabilityType,
      required this.site,
      required this.region,
      required this.originalLink,
      required this.contentLink,
      required this.images,
      required this.scraps,
      required this.scrapsUser,
      required this.keyword});

  AutoInformationPostModel.fromDocument(
      {required DocumentSnapshot<Map<String, dynamic>> doc})
      : id = doc.id,
        title = doc.data()!['title'],
        content = doc.data()!['summary'],
        createdAt = doc.data()!['post_date'],
        date = doc.data()!['date'],
        category = doc.data()!['category'],
        disabilityType = doc.data()!['disability_type'],
        site = doc.data()!['site'],
        originalLink = doc.data()!['original_link'],
        contentLink = doc.data()!['content_link'],
        images = doc.data()!['image'] == null
            ? []
            : doc.data()!['image'].cast<String>(),
        region = doc.data()!['region'] == null
            ? []
            : doc.data()!['region'].cast<String>(),
        scraps = doc.data()!['scraps'],
        scrapsUser = doc.data()!['scrapsUser'] == null
            ? []
            : doc.data()!['scrapsUser'].cast<String>(),
        keyword = doc.data()!['keyword'] == null
            ? []
            : doc.data()!['keyword'].cast<String>();
}
