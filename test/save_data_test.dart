// import 'package:byourside/model/comment.dart';
// import 'package:byourside/model/community_post.dart';
// import 'package:byourside/model/save_data.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:firebase_storage_mocks/firebase_storage_mocks.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:test/test.dart';

// import 'mock.dart';

// void main() {

//   setupFirebaseAuthMocks();

//   setUpAll(() async {
//     await Firebase.initializeApp();
//   });

//   group('SaveData', () {
//     FakeFirebaseFirestore? fakeFirebaseFirestore;
//     MockFirebaseStorage? fakeFirebaseStorage;

//     CommunityPostModel data = CommunityPostModel(
//       uid: 'mg12345',
//       title: 'Community Post Upload Test',
//       nickname: 'mg',
//       content: 'Hello World!',
//       datetime: Timestamp.now(),
//       images: [],
//       imgInfos: [],
//       category: '자유',
//       type: ['뇌병변장애'],
//       likes: 3,
//       likesPeople: ['1', '2', '3'],
//       scrapPeople: [],
//       keyword: ['Community', 'Post', 'Upload', 'Test'],
//     );

//     setUp(() {
//       fakeFirebaseFirestore = FakeFirebaseFirestore();
//       fakeFirebaseStorage = MockFirebaseStorage();
//     });

//     group(
//       'Collection Operations',
//       () {
//         test('addCommunityPost adds data to given collection', () async {
//           SaveData firestore = SaveData(firestore: fakeFirebaseFirestore, storage: fakeFirebaseStorage);
//           const String collectionName = 'collectionName';

//           await firestore.addCommunityPost(collectionName, data);

//           List<Map<String, dynamic>> actualDataList =
//               (await fakeFirebaseFirestore!.collection('collectionName').get())
//                   .docs
//                   .map((e) => e.data())
//                   .toList();

//           expect(actualDataList, [data.toMap()]);
//         });});

  
//     group('Document Operations', () {
//       test(
//           'deletePost deletes a document from a given collection',
//           () async {
//         SaveData firestore = SaveData(firestore: fakeFirebaseFirestore, storage: fakeFirebaseStorage);
//         const String collectionName = 'collectionName';

//         CollectionReference<Map<String, dynamic>> collectionReference =
//             fakeFirebaseFirestore!.collection(collectionName);

//         DocumentReference<Map<String, dynamic>> documentReference =
//             await collectionReference.add(data.toMap());

//         String documentID = documentReference.id;

//         DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
//             await collectionReference.doc(documentID).get();

//         expect(documentSnapshot.exists, true);
        
//         await firestore.deletePost(collectionName, documentID);

//         DocumentSnapshot<Map<String, dynamic>> deletedDocumentSnapshot =
//             await collectionReference.doc(documentID).get();

//         expect(deletedDocumentSnapshot.exists, false);
//       });

//        test('addLike update likes & likesPeople field from a given document', () async {
//         SaveData firestore = SaveData(firestore: fakeFirebaseFirestore, storage: fakeFirebaseStorage);
//         const String collectionName = 'collectionName';

//         CollectionReference<Map<String, dynamic>> collectionReference =
//             fakeFirebaseFirestore!.collection(collectionName);

//         DocumentReference<Map<String, dynamic>> documentReference =
//             await collectionReference.add(data.toMap());

//         String documentID = documentReference.id;
        
//         await firestore.addLike(collectionName, documentID, 'mg');
//         await firestore.addLike(collectionName, documentID, 'he');
//         await firestore.addLike(collectionName, documentID, 'jw');

//         DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
//             await collectionReference.doc(documentID).get();
        
//         int likesActualData = documentSnapshot['likes'];
//         List<dynamic> likesPeopleActualData = documentSnapshot['likesPeople'];

//         expect(likesActualData, 6);
//         expect(likesPeopleActualData, ['1', '2', '3', 'mg', 'he', 'jw']);
//       });
    
//       test('cancelLike update likes & likesPeople field from a given document', () async {
//         SaveData firestore = SaveData(firestore: fakeFirebaseFirestore, storage: fakeFirebaseStorage);
//         const String collectionName = 'collectionName';

//         CollectionReference<Map<String, dynamic>> collectionReference =
//             fakeFirebaseFirestore!.collection(collectionName);

//         DocumentReference<Map<String, dynamic>> documentReference =
//             await collectionReference.add(data.toMap());

//         String documentID = documentReference.id;
        
//         await firestore.cancelLike(collectionName, documentID, '3');

//         DocumentSnapshot<Map<String, dynamic>> firstIndexDeleteDocumentSnapshot =
//             await collectionReference.doc(documentID).get();
        
//         int firstLikesActualData = firstIndexDeleteDocumentSnapshot['likes'];
//         List<dynamic> firstLikesPeopleActualData = firstIndexDeleteDocumentSnapshot['likesPeople'];
        
//         expect(firstLikesActualData, 2);
//         expect(firstLikesPeopleActualData, ['1', '2']);

//         await firestore.cancelLike(collectionName, documentID, '1');

//         DocumentSnapshot<Map<String, dynamic>> secondIndexDeleteDocumentSnapshot =
//             await collectionReference.doc(documentID).get();
        
//         int secondLikesActualData = secondIndexDeleteDocumentSnapshot['likes'];
//         List<dynamic> secondLikesPeopleActualData = secondIndexDeleteDocumentSnapshot['likesPeople'];

//         expect(secondLikesActualData, 1);
//         expect(secondLikesPeopleActualData, ['2']);
//       });


//       test('addScrap update scrapPeople field from a given document', () async {
//         SaveData firestore = SaveData(firestore: fakeFirebaseFirestore, storage: fakeFirebaseStorage);
//         const String collectionName = 'collectionName';

//         CollectionReference<Map<String, dynamic>> collectionReference =
//             fakeFirebaseFirestore!.collection(collectionName);

//         DocumentReference<Map<String, dynamic>> documentReference =
//             await collectionReference.add(data.toMap());

//         String documentID = documentReference.id;
        
//         await firestore.addScrap(collectionName, documentID, 'mg');
//         await firestore.addScrap(collectionName, documentID, 'he');
//         await firestore.addScrap(collectionName, documentID, 'jw');

//         DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
//             await collectionReference.doc(documentID).get();
        
//         List<dynamic> actualData = documentSnapshot['scrapPeople'];

//         expect(actualData, ['mg', 'he', 'jw']);
//       });
    
//       test('cancelScrap update scrapPeople field from a given document', () async {
//         SaveData firestore = SaveData(firestore: fakeFirebaseFirestore, storage: fakeFirebaseStorage);
//         const String collectionName = 'collectionName';

//         CommunityPostModel dataForAddScrap = CommunityPostModel(
//           uid: 'mg12345',
//           title: 'Community Post Upload Test',
//           nickname: 'mg',
//           content: 'Hello World!',
//           datetime: Timestamp.now(),
//           images: [],
//           imgInfos: [],
//           category: '자유',
//           type: ['뇌병변장애'],
//           likes: 3,
//           likesPeople: [],
//           scrapPeople: ['mg', 'he', 'jw'],
//           keyword: ['Community', 'Post', 'Upload', 'Test'],
//         );

//         CollectionReference<Map<String, dynamic>> collectionReference =
//             fakeFirebaseFirestore!.collection(collectionName);

//         DocumentReference<Map<String, dynamic>> documentReference =
//             await collectionReference.add(dataForAddScrap.toMap());

//         String documentID = documentReference.id;
        
//         await firestore.cancelScrap(collectionName, documentID, 'mg');

//         DocumentSnapshot<Map<String, dynamic>> firstIndexDeleteDocumentSnapshot =
//             await collectionReference.doc(documentID).get();
        
//         List<dynamic> firstActualData = firstIndexDeleteDocumentSnapshot['scrapPeople'];

//         expect(firstActualData, ['he', 'jw']);

//         await firestore.cancelScrap(collectionName, documentID, 'jw');

//         DocumentSnapshot<Map<String, dynamic>> secondIndexDeleteDocumentSnapshot =
//             await collectionReference.doc(documentID).get();
        
//         List<dynamic> secondActualData = secondIndexDeleteDocumentSnapshot['scrapPeople'];

//         expect(secondActualData, ['he']);
//       });

//       test('addComment adds comment data to given collection', () async {
//         SaveData firestore = SaveData(firestore: fakeFirebaseFirestore, storage: fakeFirebaseStorage);
//         const String collectionName = 'collectionName';

//         CommentModel comment = CommentModel(
//           uid: 'shin',
//           nickname: 'mg',
//           content: '댓글임당',
//           datetime: Timestamp.now()
//         );

//         CollectionReference<Map<String, dynamic>> collectionReference =
//             fakeFirebaseFirestore!.collection(collectionName);

//         DocumentReference<Map<String, dynamic>> documentReference =
//             await collectionReference.add(data.toMap());

//         String documentID = documentReference.id;
        
//         DocumentReference<Map<String, dynamic>> commentDocumentReference =
//           await firestore.addComment(collectionName, documentID, comment);

//         String commentID = commentDocumentReference.id;

//         DocumentSnapshot<Map<String, dynamic>> commentDocumentSnapshot =
//             await collectionReference.doc(documentID).collection('comment').doc(commentID).get();
        
//         String uid = commentDocumentSnapshot['uid'];
//         String nickname = commentDocumentSnapshot['nickname'];
//         String content = commentDocumentSnapshot['content'];

//         expect(uid, 'shin');
//         expect(nickname, 'mg');
//         expect(content, '댓글임당');
//       });

//       test('addComment adds comment data to given collection', () async {
//         SaveData firestore = SaveData(firestore: fakeFirebaseFirestore, storage: fakeFirebaseStorage);
//         const String collectionName = 'collectionName';

//         CommentModel comment = CommentModel(
//           uid: 'shin',
//           nickname: 'mg',
//           content: '댓글임당',
//           datetime: Timestamp.now()
//         );

//         CollectionReference<Map<String, dynamic>> collectionReference =
//             fakeFirebaseFirestore!.collection(collectionName);

//         DocumentReference<Map<String, dynamic>> documentReference =
//             await collectionReference.add(data.toMap());

//         String documentID = documentReference.id;

//         DocumentReference<Map<String, dynamic>> commentDocumentReference =
//             await documentReference.collection('comment').add(comment.toMap());
        
//         String commentID = commentDocumentReference.id;

//         DocumentSnapshot<Map<String, dynamic>> commentDocumentSnapshot =
//             await commentDocumentReference.get();

//         expect(commentDocumentSnapshot.exists, true);
        
//         String uid = commentDocumentSnapshot['uid'];
//         String nickname = commentDocumentSnapshot['nickname'];
//         String content = commentDocumentSnapshot['content'];

//         expect(uid, 'shin');
//         expect(nickname, 'mg');
//         expect(content, '댓글임당');

//         await firestore.deleteComment(collectionName, documentID, commentID);

//         DocumentSnapshot<Map<String, dynamic>> deletedCommentDocumentSnapshot =
//             await collectionReference.doc(documentID).collection('comment').doc(commentID).get();
      
//         expect(deletedCommentDocumentSnapshot.exists, false);
//       });

//       test('uploadFile add image data to storage', () async {
//         SaveData saveData = SaveData(firestore: fakeFirebaseFirestore, storage: fakeFirebaseStorage);

//         List<XFile> images = [
//           XFile('곁.png'),
//           XFile('cat.jpeg')];

//         List<String> urls = await saveData.uploadFile(images);

//         String firstImageUrl = await fakeFirebaseStorage!.ref().child('images/곁.png').getDownloadURL();
//         String secondImageUrl = await fakeFirebaseStorage!.ref().child('images/cat.jpeg').getDownloadURL();

//         expect(firstImageUrl, urls[0]);
//         expect(secondImageUrl, urls[1]);

//         expect(urls.length, 2);
//       });
//     });


//     // group('Transaction Operation', () {
//     //   test('runTransaction runs the correct transaction operation', () async {
//     //     final SaveData firestore =
//     //         SaveData(firestore: fakeFirebaseFirestore!);

//     //     const String collectionName = 'collectionName';
//     //     const String documentPathToUpdate = 'documentPathToUpdate';
//     //     const String documentPathToSetTo = 'documentPathToSetTo';
//     //     const String documentPathToDelete = 'documentPathToDelete';

//     //     final CollectionReference collectionReference =
//     //         fakeFirebaseFirestore!.collection(collectionName);

//     //     final DocumentReference documentReferenceToUpdate =
//     //         collectionReference.doc(documentPathToUpdate);
//     //     final DocumentReference documentReferenceToSetTo =
//     //         collectionReference.doc(documentPathToSetTo);
//     //     final DocumentReference documentReferenceToDelete =
//     //         collectionReference.doc(documentPathToDelete);

//     //     documentReferenceToUpdate.set(data);
//     //     documentReferenceToDelete.set(data);

//     //     const Map<String, dynamic> dataToUpdateWith = {'updated_data': '43'};
//     //     const Map<String, dynamic> dataToSet = {'data': 44};

//     //     const Map<String, dynamic> expectedUpdatedData = {
//     //       ...data,
//     //       ...dataToUpdateWith
//     //     };

//     //     await firestore.runTransaction(
//     //         dataToUpdate: dataToUpdateWith,
//     //         dataToSet: dataToSet,
//     //         collectionName: collectionName,
//     //         documentPathToUpdate: documentPathToUpdate,
//     //         documentPathToSetTo: documentPathToSetTo,
//     //         documentPathToDelete: documentPathToDelete);

//     //     final DocumentSnapshot documentSnapshotForUpdate =
//     //         await documentReferenceToUpdate.get();
//     //     final DocumentSnapshot documentSnapshotForSet =
//     //         await documentReferenceToSetTo.get();
//     //     final DocumentSnapshot documentSnapshotForDelete =
//     //         await documentReferenceToDelete.get();

//     //     final actualDataFromUpdate = documentSnapshotForUpdate.data();
//     //     final actualDataFromSet = documentSnapshotForSet.data();
//     //     final actualDataFromDelete = documentSnapshotForDelete.data();

//     //     expect(actualDataFromUpdate, expectedUpdatedData);
//     //     expect(actualDataFromSet, dataToSet);
//     //     expect(actualDataFromDelete, null);
//     //   });
//     // });
// });}

// //     group('Batched Write Operation', () {
// //       test('runBatchedWrite runs the correct batched write operation',
// //           () async {
// //         final SaveData firestore =
// //             SaveData(firestore: fakeFirebaseFirestore!);
// //         const String collectionName = 'collectionName';
// //         const String documentPathToUpdate = 'documentPathToUpdate';
// //         const String documentPathToSetTo = 'documentPathToSetTo';
// //         const String documentPathToDelete = 'documentPathToDelete';

// //         final CollectionReference collectionReference =
// //             fakeFirebaseFirestore!.collection(collectionName);

// //         final DocumentReference documentReferenceToUpdate =
// //             collectionReference.doc(documentPathToUpdate);
// //         final DocumentReference documentReferenceToSetTo =
// //             collectionReference.doc(documentPathToSetTo);
// //         final DocumentReference documentReferenceToDelete =
// //             collectionReference.doc(documentPathToDelete);

// //         documentReferenceToUpdate.set(data);
// //         documentReferenceToDelete.set(data);

// //         const Map<String, dynamic> dataToUpdateWith = {'updated_data': '43'};
// //         const Map<String, dynamic> dataToSet = {'data': 44};

// //         const Map<String, dynamic> expectedUpdatedData = {
// //           ...data,
// //           ...dataToUpdateWith
// //         };

// //         await firestore.runBatchedWrite(
// //             dataToUpdate: dataToUpdateWith,
// //             dataToSet: dataToSet,
// //             collectionName: collectionName,
// //             documentPathToUpdate: documentPathToUpdate,
// //             documentPathToSetTo: documentPathToSetTo,
// //             documentPathToDelete: documentPathToDelete);

// //         final DocumentSnapshot documentSnapshotForUpdate =
// //             await documentReferenceToUpdate.get();
// //         final DocumentSnapshot documentSnapshotForSet =
// //             await documentReferenceToSetTo.get();
// //         final DocumentSnapshot documentSnapshotForDelete =
// //             await documentReferenceToDelete.get();

// //         final actualDataFromUpdate = documentSnapshotForUpdate.data();
// //         final actualDataFromSet = documentSnapshotForSet.data();
// //         final actualDataFromDelete = documentSnapshotForDelete.data();

// //         expect(actualDataFromUpdate, expectedUpdatedData);
// //         expect(actualDataFromSet, dataToSet);
// //         expect(actualDataFromDelete, null);
// //       });
// //     });
// //   });
// // }

// // class MapListContains extends Matcher {
// //   final Map<dynamic, dynamic> _expected;

// //   const MapListContains(this._expected);

// //   @override
// //   Description describe(Description description) {
// //     return description.addDescriptionOf(_expected);
// //   }

// //   @override
// //   bool matches(dynamic item, Map matchState) {
// //     if (item is List<Map>) {
// //       return item.any((element) => mapEquals(element, _expected));
// //     }
// //     return false;
// //   }
// // }