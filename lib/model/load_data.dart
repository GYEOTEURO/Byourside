import 'package:byourside/model/comment.dart';
import 'package:byourside/model/community_post.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LoadData{  //클래스 이름은 명사로
  LoadData({FirebaseFirestore? firestore}) : firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore firestore;

  Stream<DocumentSnapshot> readUserInfo({required String uid}){
      return firestore.collection('user').doc(uid).snapshots();
  }

  Stream<List<CommunityPostModel>> readCommunityPosts({String? category, required String disabilityType}) {
    if(category == null) {
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
  Stream<List<CommentModel>> readCommunityComments(
          {required String documentID}) =>
          firestore
          .collection('community_comment')
          .doc(documentID)
          .collection('comments')
          .orderBy('createdAt', descending: false)
          .snapshots()
          .map((snapshot) =>
              snapshot.docs.map((doc) => CommentModel.fromDocument(doc: doc)).toList());

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

  // // Firestore의 커뮤니티 collection 내 특정 문서 불러오기
  // Stream<CommunityPostModel> readCommunityDocument(
  //         {required String collectionName, required String documentID}) =>
  //         firestore
  //         .collection(collectionName)
  //         .doc(documentID)
  //         .snapshots()
  //         .map((snapshot) => CommunityPostModel.fromMap(snapshot));
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
