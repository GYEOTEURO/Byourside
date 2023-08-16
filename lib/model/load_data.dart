import 'package:byourside/model/comment.dart';
import 'package:byourside/model/community_post.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LoadData{
  LoadData({FirebaseFirestore? firestore}) : firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore firestore;

  Future<DocumentSnapshot<Map<String, dynamic>>> readUserInfo({required String uid}) async {
      var userDocumentSnapshot = await firestore.collection('user').doc(uid).get();
      return userDocumentSnapshot;
  }

  Stream<List<CommunityPostModel>> readCommunityPosts({String? category, required String disabilityType}) {
    if(category == '전체') {
      return firestore.collectionGroup('posts')
      .where('disabilityType', whereIn: [disabilityType, '전체'])
      .orderBy('createdAt', descending: true)
      .snapshots()
      .map((snapshot) => snapshot.docs.map((doc) => CommunityPostModel.fromDocument(doc: doc))
      .toList());
    }
    else{
      return firestore.collection('community')
      .doc(category)
      .collection('posts')
      .where('disabilityType', whereIn: [disabilityType, '전체'])
      .orderBy('createdAt', descending: true)
      .snapshots()
      .map((snapshot) => snapshot.docs.map((doc) => CommunityPostModel.fromDocument(doc: doc))
      .toList());
    }
}

  // Firestore의 특정 문서에 있는 모든 댓글 불러오기
  Stream<List<CommentModel>> readComments(
          {required String collectionName, required String documentID}) =>
          firestore
          .collection(collectionName)
          .doc(documentID)
          .collection('comments')
          .orderBy('createdAt', descending: false)
          .snapshots()
          .map((snapshot) =>
              snapshot.docs.map((doc) => CommentModel.fromDocument(doc: doc)).toList());

  readScrapPost({required String collectionName, required String uid}) {}

  // // 검색을 위한 쿼리 비교
  // Stream<List<CommunityPostModel>> readSearchDocs(String query,
  //         {required String collectionName}) =>
  //         firestore
  //         .collection(collectionName)
  //         .where('keyword', arrayContainsAny: [query])
  //         .orderBy('datetime', descending: true)
  //         .snapshots()
  //         .map((snapshot) => snapshot.docs
  //             .map((doc) => CommunityPostModel.fromMap(doc))
  //             .toList());

  //
  // // 작성한 글 보기
  // Stream<List<CommunityPostModel>> readCreatePost(
  //         {required String collectionName, required String uid}) =>
  //         firestore
  //         .collection(collectionName)
  //         .where('uid', isEqualTo: uid)
  //         .orderBy('datetime', descending: true)
  //         .snapshots()
  //         .map((snapshot) => snapshot.docs
  //             .map((doc) => CommunityPostModel.fromMap(doc))
  //             .toList());

  // // 스크랩한 글 보기
  // Stream<List<CommunityPostModel>> readScrapPost(
  //         {required String collectionName, required String uid}) =>
  //         firestore
  //         .collection(collectionName)
  //         .where('scrapPeople', arrayContains: uid)
  //         .orderBy('datetime', descending: true)
  //         .snapshots()
  //         .map((snapshot) => snapshot.docs
  //             .map((doc) => CommunityPostModel.fromMap(doc))
  //             .toList());

}
