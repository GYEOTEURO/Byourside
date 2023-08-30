import 'dart:io';
import 'package:byourside/model/comment.dart';
import 'package:byourside/model/community_post.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class SaveData {
  SaveData({FirebaseFirestore? firestore, FirebaseStorage? storage}) 
  : firestore = firestore ?? FirebaseFirestore.instance,
    storage = storage ?? FirebaseStorage.instance;

  final FirebaseFirestore firestore;
  final FirebaseStorage storage;

  // 커뮤니티 문서 생성
  addCommunityPost(String category, CommunityPostModel post) async {
    firestore.collection('community').doc(category).collection('community_posts').add(post.convertToDocument());
  }

  // image 파일 있을때, firebase storage에 업로드 후 firestore에 저장할 image url 다운로드 
  Future<List<String>> uploadFile(List<XFile> images) async{
    List<String> urls = [];

    for(XFile element in images){
      var imageRef = storage.ref().child('images/${element.name}');
      File file = File(element.path);

      try {
        await imageRef.putFile(file);
        String url = await imageRef.getDownloadURL();
        urls.add(url);
      // ignore: empty_catches
      } on FirebaseException {} 
    } 

    return urls;
  }

  // 문서 삭제
  deleteCommunityPost(String category, String documentID) async {
    await firestore.collection('community').doc(category).collection('community_posts').doc(documentID).delete();
  }

  // 댓글 저장
  addComment(String collectionName, String documentID, CommentModel comment) async {
    return firestore.collection(collectionName).doc(documentID).collection('comments').add(comment.convertToDocument());
  }
  
  // 댓글 삭제
  deleteComment(String collectionName, String documentID, String? commentID) async {
    await firestore.collection(collectionName).doc(documentID).collection('comments').doc(commentID).delete();
  }

   // 좋아요/스크랩 추가
  addLikeOrScrap(String category, String documentID, String uid, String likeOrScrap) async {
    DocumentReference document = firestore.collection('community').doc(category).collection('community_posts').doc(documentID);
  
    await firestore.runTransaction((transaction) async {
        DocumentSnapshot snapshot = await transaction.get(document);
        int currentLikes = snapshot[likeOrScrap] + 1;
        transaction.update(document, {likeOrScrap: currentLikes});
    });

    document.update({'${likeOrScrap}User': FieldValue.arrayUnion([uid])});
  }
  
  // 좋아요/스크랩 취소
  cancelLikeOrScrap(String category, String documentID, String uid, String likeOrScrap) async {
    DocumentReference document = firestore.collection('community').doc(category).collection('community_posts').doc(documentID);
  
    await firestore.runTransaction((transaction) async {
        DocumentSnapshot snapshot = await transaction.get(document);
        int currentLikes = snapshot[likeOrScrap] - 1;
        transaction.update(document, {likeOrScrap: currentLikes});
    });

    document.update({'${likeOrScrap}User': FieldValue.arrayRemove([uid])});
  }

  // 신고
  report(String collectionName, String postOrComment, String id) async {
    await firestore.collection('report').doc(collectionName).collection(postOrComment).doc(id).set({ 'check' : false });
  }

  // 차단 목록 변경
  changeBlock(String uid, List<String>? blockedUsers) async {
    await firestore.collection('userInfo').doc(uid).update({'blockedUsers': blockedUsers});
  }

  // 개발자에게 문의하기
  sendMsg2dev(String uid, String messages) async {
    await firestore.collection('msg2dev').add({'uid': uid, 'content': messages, 'datetime': Timestamp.now()});
  }
}

