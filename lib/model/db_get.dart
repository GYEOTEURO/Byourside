import 'package:byourside/model/comment.dart';
import 'package:byourside/model/nanum_post.dart';
import 'package:byourside/model/ondo_post.dart';
import 'package:byourside/model/post_list.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DBGet {
  // Firestore의 collection에 있는 모든 데이터 불러오기
  static Stream<List<PostListModel>> readAllCollection(
      {required String collection, List<String>? type}) {
    if (type == null || type.isEmpty) {
      return FirebaseFirestore.instance
          .collection(collection)
          .orderBy('datetime', descending: true)
          .snapshots()
          .map((snapshot) => snapshot.docs
              .map((doc) => PostListModel.fromMap(doc, collection))
              .toList());
    } else {
      return FirebaseFirestore.instance
          .collection(collection)
          .where("type", arrayContainsAny: type)
          .orderBy('datetime', descending: true)
          .snapshots()
          .map((snapshot) => snapshot.docs
              .map((doc) => PostListModel.fromMap(doc, collection))
              .toList());
    }
  }

  // Firestore의 마음나눔 collection에 있는 거래중인 데이터 불러오기 (거래 완료 제외)
  static Stream<List<PostListModel>> readIsCompletedCollection(
      {required String collection, List<String>? type}) {
    if (type == null || type.isEmpty) {
      return FirebaseFirestore.instance
          .collection(collection)
          .where("isCompleted", isEqualTo: false)
          .orderBy('datetime', descending: true)
          .snapshots()
          .map((snapshot) => snapshot.docs
              .map((doc) => PostListModel.fromMap(doc, collection))
              .toList());
    } else {
      return FirebaseFirestore.instance
          .collection(collection)
          .where("type", arrayContainsAny: type)
          .where("isCompleted", isEqualTo: false)
          .orderBy('datetime', descending: true)
          .snapshots()
          .map((snapshot) => snapshot.docs
              .map((doc) => PostListModel.fromMap(doc, collection))
              .toList());
    }
  }

  // 검색을 위한 쿼리 비교
  static Stream<List<PostListModel>> readSearchDocs(String query,
          {required String collection}) =>
      FirebaseFirestore.instance
          .collection(collection)
          .where("keyword", arrayContainsAny: [query])
          .orderBy('datetime', descending: true)
          .snapshots()
          .map((snapshot) => snapshot.docs
              .map((doc) => PostListModel.fromMap(doc, collection))
              .toList());

  // Firestore의 ondo collection에 있는 특정 카테고리 데이터 불러오기 (자유/정보의 세부 카테고리)
  static Stream<List<PostListModel>> readCategoryCollection(
      {required String collection,
      required String category,
      List<String>? type}) {
    if (type == null || type.isEmpty) {
      return FirebaseFirestore.instance
          .collection(collection)
          .where("category", isEqualTo: category)
          .orderBy('datetime', descending: true)
          .snapshots()
          .map((snapshot) => snapshot.docs
              .map((doc) => PostListModel.fromMap(doc, collection))
              .toList());
    } else {
      return FirebaseFirestore.instance
          .collection(collection)
          .where("category", isEqualTo: category)
          .where("type", arrayContainsAny: type)
          .orderBy('datetime', descending: true)
          .snapshots()
          .map((snapshot) => snapshot.docs
              .map((doc) => PostListModel.fromMap(doc, collection))
              .toList());
    }
  }

  // Firestore의 ondo collection에 있는 정보에 속하는 카테고리 데이터 모두 불러오기("전체 정보" 카테고리 가져오기)
  static Stream<List<PostListModel>> readAllInfoCollection(
      {required String collection, List<String>? type}) {
    if (type == null || type.isEmpty || type.length > 1) {
      return FirebaseFirestore.instance
          .collection(collection)
          .where("category", whereIn: [
            "복지/혜택",
            "교육/세미나",
            "병원/센터 후기",
            "법률/제도",
            "초기 증상 발견/생활 속 Tip"
          ])
          .orderBy('datetime', descending: true)
          .snapshots()
          .map((snapshot) => snapshot.docs
              .map((doc) => PostListModel.fromMap(doc, collection))
              .toList());
    } else {
      return FirebaseFirestore.instance
          .collection(collection)
          .where("category", whereIn: [
            "복지/혜택",
            "교육/세미나",
            "병원/센터 후기",
            "법률/제도",
            "초기 증상 발견/생활 속 Tip"
          ])
          .where("type", isEqualTo: type)
          .orderBy('datetime', descending: true)
          .snapshots()
          .map((snapshot) => snapshot.docs
              .map((doc) => PostListModel.fromMap(doc, collection))
              .toList());
    }
  }

  // Firestore의 마음온도 collection 내 특정 문서 불러오기
  static Stream<OndoPostModel> readOndoDocument(
          {required String collection, required String documentID}) =>
      FirebaseFirestore.instance
          .collection(collection)
          .doc(documentID)
          .snapshots()
          .map((snapshot) => OndoPostModel.fromMap(snapshot));

  // Firestore의 마음나눔 collection 내 특정 문서 불러오기
  static Stream<NanumPostModel> readNanumDocument(
          {required String collection, required String documentID}) =>
      FirebaseFirestore.instance
          .collection(collection)
          .doc(documentID)
          .snapshots()
          .map((snapshot) => NanumPostModel.fromMap(snapshot));

  // Firestore의 특정 문서에 있는 모든 댓글 불러오기
  static Stream<List<CommentModel>> readComment(
          {required String collection, required String documentID}) =>
      FirebaseFirestore.instance
          .collection(collection)
          .doc(documentID)
          .collection('comment')
          .orderBy('datetime', descending: false)
          .snapshots()
          .map((snapshot) =>
              snapshot.docs.map((doc) => CommentModel.fromMap(doc)).toList());

  // 작성한 글 보기
  static Stream<List<PostListModel>> readCreatePost(
          {required String collection, required String uid}) =>
      FirebaseFirestore.instance
          .collection(collection)
          .where("uid", isEqualTo: uid)
          .orderBy('datetime', descending: true)
          .snapshots()
          .map((snapshot) => snapshot.docs
              .map((doc) => PostListModel.fromMap(doc, collection))
              .toList());

  // 스크랩한 글 보기
  static Stream<List<PostListModel>> readScrapPost(
          {required String collection, required String uid}) =>
      FirebaseFirestore.instance
          .collection(collection)
          .where("scrapPeople", arrayContains: uid)
          .orderBy('datetime', descending: true)
          .snapshots()
          .map((snapshot) => snapshot.docs
              .map((doc) => PostListModel.fromMap(doc, collection))
              .toList());
}
