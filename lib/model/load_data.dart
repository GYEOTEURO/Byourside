import 'package:byourside/model/comment.dart';
import 'package:byourside/model/community_post.dart';
import 'package:byourside/model/post_list.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LoadData{  //클래스 이름은 명사로
  LoadData({FirebaseFirestore? firestore}) : firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore firestore;

  // Firestore의 collection에 있는 모든 데이터 불러오기
  Stream<List<PostListModel>> readAllCollection({required String collectionName, List<String>? type}) {
        if(type == null || type.isEmpty){
          return firestore
            .collection(collectionName)
            .orderBy('datetime', descending: true)
            .snapshots()
            .map((snapshot) => snapshot.docs.map((doc) => PostListModel.fromMap(doc, collectionName))
            .toList());
        }
        else{
          return firestore
            .collection(collectionName)
            .where('type', arrayContainsAny: type)
            .orderBy('datetime', descending: true)
            .snapshots()
            .map((snapshot) => snapshot.docs.map((doc) => PostListModel.fromMap(doc, collectionName))
            .toList());
        }
  }

  // 검색을 위한 쿼리 비교
  Stream<List<PostListModel>> readSearchDocs(String query,
          {required String collectionName}) =>
          firestore
          .collection(collectionName)
          .where('keyword', arrayContainsAny: [query])
          .orderBy('datetime', descending: true)
          .snapshots()
          .map((snapshot) => snapshot.docs
              .map((doc) => PostListModel.fromMap(doc, collectionName))
              .toList());


  // Firestore의 커뮤니티 collection 내 특정 문서 불러오기
  Stream<CommunityPostModel> readCommunityDocument(
          {required String collectionName, required String documentID}) =>
          firestore
          .collection(collectionName)
          .doc(documentID)
          .snapshots()
          .map((snapshot) => CommunityPostModel.fromMap(snapshot));

  // Firestore의 특정 문서에 있는 모든 댓글 불러오기
  Stream<List<CommentModel>> readComment(
          {required String collectionName, required String documentID}) =>
          firestore
          .collection(collectionName)
          .doc(documentID)
          .collection('comment')
          .orderBy('datetime', descending: false)
          .snapshots()
          .map((snapshot) =>
              snapshot.docs.map((doc) => CommentModel.fromMap(doc)).toList());

  // 작성한 글 보기
  Stream<List<PostListModel>> readCreatePost(
          {required String collectionName, required String uid}) =>
          firestore
          .collection(collectionName)
          .where('uid', isEqualTo: uid)
          .orderBy('datetime', descending: true)
          .snapshots()
          .map((snapshot) => snapshot.docs
              .map((doc) => PostListModel.fromMap(doc, collectionName))
              .toList());

  // 스크랩한 글 보기
  Stream<List<PostListModel>> readScrapPost(
          {required String collectionName, required String uid}) =>
          firestore
          .collection(collectionName)
          .where('scrapPeople', arrayContains: uid)
          .orderBy('datetime', descending: true)
          .snapshots()
          .map((snapshot) => snapshot.docs
              .map((doc) => PostListModel.fromMap(doc, collectionName))
              .toList());

}
