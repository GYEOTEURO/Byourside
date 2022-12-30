import 'package:byourside/model/comment.dart';
import 'package:byourside/model/nanum_post.dart';
import 'package:byourside/model/ondo_post.dart';
import 'package:byourside/model/post_list.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DBGet {
  // Firestore의 특정 collection에 있는 모든 데이터 불러오기
  static Stream<List<PostListModel>> readCollection({required String collection}) =>
        FirebaseFirestore.instance
        .collection(collection)
        .orderBy('datetime', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => PostListModel.fromMap(doc))
        .toList());
      
  // Firestore의 마음온도 collection 내 특정 문서 불러오기
  static Stream<OndoPostModel> readOndoDocument({required String collection, required String documentID}) =>
        FirebaseFirestore.instance
        .collection(collection)
        .doc(documentID)
        .snapshots()
        .map((snapshot) => OndoPostModel.fromMap(snapshot));
  
  // Firestore의 마음나눔 collection 내 특정 문서 불러오기
  static Stream<NanumPostModel> readNanumDocument({required String collection, required String documentID}) =>
        FirebaseFirestore.instance
        .collection(collection)
        .doc(documentID)
        .snapshots()
        .map((snapshot) => NanumPostModel.fromMap(snapshot));

  // Firestore의 특정 문서에 있는 모든 댓글 불러오기
  static Stream<List<CommentModel>> readComment({required String collection, required String documentID}) =>
        FirebaseFirestore.instance
        .collection(collection)
        .doc(documentID)
        .collection('comment')
        .orderBy('datetime', descending: false)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => CommentModel.fromMap(doc))
        .toList());


  // // 작성한 마음온도 글 보기
  // static Stream<List<PostListModel>> readCreateOndoPost({required String collection, required List<String> postList}) =>
  //       FirebaseFirestore.instance
  //       .collection(collection)
  //       .where()
  //       .orderBy('datetime', descending: true)
  //       .snapshots()
  //       .map((snapshot) => snapshot.docs.map((doc) => PostListModel.fromMap(doc))
  //       .toList());
  //
  // // 작성한 마음나눔 글 보기
  // static Stream<List<PostListModel>> readCreateNanumPost({required String collection, required String uid}) =>
  //       FirebaseFirestore.instance
  //       .collection(collection)
  //       .where('uid' == uid)
  //       .orderBy('datetime', descending: true)
  //       .snapshots()
  //       .map((snapshot) => snapshot.docs.map((doc) => PostListModel.fromMap(doc))
  //       .toList());
  //
  // // 작성한 댓글 보기
  // static Stream<List<PostListModel>> readCreateComment({required String collection, required String uid}) =>
  //       FirebaseFirestore.instance
  //       .collectionGroup('comment')
  //       .where('uid' == uid)
  //       .orderBy('datetime', descending: true)
  //       .snapshots()
  //       .map((snapshot) => snapshot.docs.map((doc) => PostListModel.fromMap(doc))
  //       .toList());
  //
  // // 스크랩한 글 보기
  // static Stream<List<PostListModel>> readScrapPost({required String collection, required List<String> scrapList}) =>
  //       FirebaseFirestore.instance
  //       .collection(collection)
  //       .where(in scrapList)
  //       .orderBy('datetime', descending: true)
  //       .snapshots()
  //       .map((snapshot) => snapshot.docs.map((doc) => PostListModel.fromMap(doc))
  //       .toList());
  //
  // // User의 Nickname 정보 가져오기
  // static Stream<OndoPostModel> getUserNickname({required String uid}) =>
  //       FirebaseFirestore.instance
  //       .collection('user')
  //       .doc(uid)
  //       .snapshots()
  //       .map((snapshot) => OndoPostModel.fromMap(snapshot));

}
          