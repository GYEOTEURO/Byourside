import 'dart:io';
import 'package:byourside/model/comment.dart';
import 'package:byourside/model/nanum_post.dart';
import 'package:byourside/model/ondo_post.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class DBSet {
  // 마음온도 문서 생성
  static addOndoPost(String collectionName, OndoPostModel postData) async {
    FirebaseFirestore.instance.collection(collectionName).add(postData.toMap());
  }

  // 마음나눔 문서 생성
  static addNanumPost(String collectionName, NanumPostModel postData) async {
    FirebaseFirestore.instance.collection(collectionName).add(postData.toMap());
  }

  // image 파일 있을때, firebase storage에 업로드 후 firestore에 저장할 image url 다운로드 
  static Future<List<String>> uploadFile(List<XFile> images) async{
    List<String> urls = [];

    for(XFile element in images){
      final imageRef = FirebaseStorage.instance.ref().child('images/${element.name}');
      File file = File(element.path);

      try {
        await imageRef.putFile(file);
        final String url = await imageRef.getDownloadURL();
        urls.add(url);
      } on FirebaseException catch(e) {} 
    } 

    return urls;
  }

  // 문서 삭제
  static deletePost(String collectionName, String documentID) async {
    await FirebaseFirestore.instance.collection(collectionName).doc(documentID).delete();
  }

  // 댓글 저장
  static addComment(String collectionName, String documentID, CommentModel commentData) async {
    await FirebaseFirestore.instance.collection(collectionName).doc(documentID).collection('comment').add(commentData.toMap());
  }
  
  // 댓글 삭제
  static deleteComment(String collectionName, String documentID, String commentID) async {
    await FirebaseFirestore.instance.collection(collectionName).doc(documentID).collection('comment').doc(commentID).delete();
  }

  // 거래 진행 여부 업데이트 (거래중 -> 거래완료 / 거래완료 -> 거래중)
  static updateIsCompleted(String collectionName, String documentID, bool isCompleted) async {
    await FirebaseFirestore.instance.collection(collectionName).doc(documentID).update({ 'isCompleted':isCompleted });
  }

  // // 좋아요 추가
  // static addLike(String collectionName, String documentID) async {
  //   await FirebaseFirestore.instance.collection(collectionName).doc(documentID).update({ 'likes':likes+1 });
  // }
  //
  // // 좋아요 취소
  // static cancelLike(String collectionName, String documentID) async {
  //   await FirebaseFirestore.instance.collection(collectionName).doc(documentID).update({ 'likes':likes-1 });
  // }
  //
  // // 스크랩 추가
  // static addScrap(String documentID, String uid) async {
  //   await FirebaseFirestore.instance.collection('user').doc(uid).set({ 'scrap': documentID }, SetOptions(merge: true));
  // }
  //
  // // 스크랩 취소
  // static cancelScrap(String documentID, String uid) async {
  //   await FirebaseFirestore.instance.collection('user').doc(uid).set({ 'scrap': documentID });
  // }
}
