import 'package:byourside/model/autoInformation_post.dart';
import 'package:byourside/model/comment.dart';
import 'package:byourside/model/community_post.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:byourside/constants/database.dart' as database;

class LoadData {
  LoadData({FirebaseFirestore? firestore})
      : firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore firestore;

  Future<DocumentSnapshot<Map<String, dynamic>>> readUserInfo(
      {required String uid}) async {
    var userDocumentSnapshot =
        await firestore.collection(database.userCollection).doc(uid).get();
    return userDocumentSnapshot;
  }

  Stream<List<CommunityPostModel>> readCommunityPosts(
      {String? category, required String? disabilityType}) {
    if (category == '전체') {
      return firestore
          .collectionGroup(database.communityPostCollectionGroup)
          .where('disabilityType', whereIn: [disabilityType, '전체'])
          .orderBy('createdAt', descending: true)
          .snapshots()
          .map((snapshot) => snapshot.docs
              .map((doc) => CommunityPostModel.fromDocument(doc: doc))
              .toList());
    } else {
      return firestore
          .collection(database.communityCollection)
          .doc(category)
          .collection(database.communityPostCollectionGroup)
          .where('disabilityType', whereIn: [disabilityType, '전체'])
          .orderBy('createdAt', descending: true)
          .snapshots()
          .map((snapshot) => snapshot.docs
              .map((doc) => CommunityPostModel.fromDocument(doc: doc))
              .toList());
    }
  }

  Stream<List<AutoInformationPostModel>> readAutoInformationPosts(
      {String? category,
      String? area,
      String? district,
      required String? disabilityType}) {
    if (category == '전체') {
      return firestore
          .collectionGroup(database.autoInformationPostCollectionGroup)
          .where('region', arrayContainsAny: [area, district, '전체'])
          .where('disability_type', whereIn: [disabilityType, '전체'])
          .orderBy('post_date', descending: true)
          .snapshots()
          .map((snapshot) => snapshot.docs
              .map((doc) => AutoInformationPostModel.fromDocument(doc: doc))
              .toList());
    } else {
      return firestore
          .collection(database.autoInformationCollection)
          .doc(category)
          .collection(database.autoInformationPostCollectionGroup)
          .where('region', arrayContainsAny: [area, district, '전체'])
          .where('disability_type', whereIn: [disabilityType, '전체'])
          .orderBy('post_date', descending: true)
          .snapshots()
          .map((snapshot) => snapshot.docs
              .map((doc) => AutoInformationPostModel.fromDocument(doc: doc))
              .toList());
    }
  }

  Stream<List<CommunityPostModel>> readHotCommunityPosts({required String? disabilityType}) {
      return firestore.collectionGroup(database.communityPostCollectionGroup)
      .where('disabilityType', whereIn: [disabilityType, '전체'])
      .where('likes', isGreaterThan: 1)
      //.orderBy('createdAt', descending: true)
      .limit(2)
      .snapshots()
      .map((snapshot) => snapshot.docs.map((doc) => CommunityPostModel.fromDocument(doc: doc))
      .toList());
    }

  Stream<List<AutoInformationPostModel>> readNewAutoInformationPosts(
      {required String? area,
      required String? district,
      required String? disabilityType}) {
    String? handledDisabilityType =
        (disabilityType == '해당없음') ? '전체' : disabilityType;
    return firestore
        .collectionGroup(database.autoInformationPostCollectionGroup)
        .where('region', arrayContainsAny: [area, district, '전체'])
        .where('disability_type', whereIn: [handledDisabilityType, '전체'])
        .orderBy('post_date', descending: true)
        .limit(5)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => AutoInformationPostModel.fromDocument(doc: doc))
            .toList());
  }

  // Firestore의 특정 문서에 있는 모든 댓글 불러오기
  Stream<List<CommentModel>> readComments(
          {required String collectionName, required String documentID}) =>
      firestore
          .collection(collectionName)
          .doc(documentID)
          .collection(database.commentCollection)
          .orderBy('createdAt', descending: false)
          .snapshots()
          .map((snapshot) => snapshot.docs
              .map((doc) => CommentModel.fromDocument(doc: doc))
              .toList());

  Stream<List<CommunityPostModel>> readCreatePosts({required String uid}) {
    return firestore
        .collectionGroup(database.communityPostCollectionGroup)
        .where('uid', isEqualTo: uid)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => CommunityPostModel.fromDocument(doc: doc))
            .toList());
  }

  Stream<List<CommunityPostModel>> readScrapCommunityPosts(
      {required String uid}) {
    return firestore
        .collectionGroup(database.communityPostCollectionGroup)
        .where('scrapsUser', arrayContains: uid)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => CommunityPostModel.fromDocument(doc: doc))
            .toList());
  }

  Stream<List<AutoInformationPostModel>> readScrapAutoInformationPosts(
      {required String uid}) {
    return firestore
        .collectionGroup(database.autoInformationPostCollectionGroup)
        .where('scrapsUser', arrayContains: uid)
        .orderBy('post_date', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => AutoInformationPostModel.fromDocument(doc: doc))
            .toList());
  }

  // 검색을 위한 쿼리 비교
  Stream<List<CommunityPostModel>> searchCommunityPosts(String? query) {
    return firestore
        .collectionGroup(database.communityPostCollectionGroup)
        .where('keyword', arrayContainsAny: [query])
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => CommunityPostModel.fromDocument(doc: doc))
            .toList());
  }

  Stream<List<AutoInformationPostModel>> searchAutoInformationPosts(
      String? query) {
    return firestore
        .collectionGroup(database.autoInformationPostCollectionGroup)
        .where('keyword', arrayContainsAny: [query])
        .orderBy('post_date', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => AutoInformationPostModel.fromDocument(doc: doc))
            .toList());
  }
}
