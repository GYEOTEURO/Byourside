import 'package:byourside/model/community_post.dart';
import 'package:byourside/model/save_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:test/test.dart';

void main() {
  group('SaveData', () {
    FakeFirebaseFirestore? fakeFirebaseFirestore;

    CommunityPostModel data = CommunityPostModel(
      uid: 'mg12345',
      title: 'Community Post Upload Test',
      nickname: 'mg',
      content: 'Hello World!',
      datetime: Timestamp.now(),
      images: [],
      imgInfos: [],
      category: '자유',
      type: ['뇌병변장애'],
      likes: 3,
      likesPeople: [],
      scrapPeople: [],
      keyword: ['Community', 'Post', 'Upload', 'Test'],
    );

    setUp(() {
      fakeFirebaseFirestore = FakeFirebaseFirestore();
    });

    group(
      'Collection Operations',
      () {
        test('addCommunityPost adds data to given collection', () async {
          SaveData firestore = SaveData(firestore: fakeFirebaseFirestore);
          const String collectionName = 'collectionName';

          await firestore.addCommunityPost(collectionName, data);

          List<Map<String, dynamic>> actualDataList =
              (await fakeFirebaseFirestore!.collection('collectionName').get())
                  .docs
                  .map((e) => e.data())
                  .toList();

          expect(actualDataList, [data.toMap()]);
        });});


  
    group('Document Operations', () {
      test(
          'deletePost deletes a document from a given collection',
          () async {
        SaveData firestore = SaveData(firestore: fakeFirebaseFirestore);
        const String collectionName = 'collectionName';

        CollectionReference<Map<String, dynamic>> collectionReference =
            fakeFirebaseFirestore!.collection(collectionName);

        DocumentReference<Map<String, dynamic>> documentReference =
            await collectionReference.add(data.toMap());

        String documentID = documentReference.id;

        DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
            await collectionReference.doc(documentID).get();

        expect(documentSnapshot.exists, true);
        
        await firestore.deletePost(collectionName, documentID);

        DocumentSnapshot<Map<String, dynamic>> deletedDocumentSnapshot =
            await collectionReference.doc(documentID).get();

        expect(deletedDocumentSnapshot.exists, false);
      });

      test('addLike update likes field from a given document', () async {
        SaveData firestore = SaveData(firestore: fakeFirebaseFirestore);
        const String collectionName = 'collectionName';

        CollectionReference<Map<String, dynamic>> collectionReference =
            fakeFirebaseFirestore!.collection(collectionName);

        DocumentReference<Map<String, dynamic>> documentReference =
            await collectionReference.add(data.toMap());

        String documentID = documentReference.id;
        
        await firestore.addLike(collectionName, documentID, 'mg');

        DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
            await collectionReference.doc(documentID).get();
        
        int actualData = documentSnapshot['likes'];

        expect(actualData, 4);
      });
    
      test('cancelLike update likes field from a given document', () async {
        SaveData firestore = SaveData(firestore: fakeFirebaseFirestore);
        const String collectionName = 'collectionName';

        CollectionReference<Map<String, dynamic>> collectionReference =
            fakeFirebaseFirestore!.collection(collectionName);

        DocumentReference<Map<String, dynamic>> documentReference =
            await collectionReference.add(data.toMap());

        String documentID = documentReference.id;
        
        await firestore.cancelLike(collectionName, documentID, 'mg');

        DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
            await collectionReference.doc(documentID).get();
        
        int actualData = documentSnapshot['likes'];

        expect(actualData, 2);
      });

      
    });
  });}

  // uploadFile
  // addComment
  // deleteComment
  // updateIsCompleted
  // addScrap
  // cancelScrap
  // declaration
  // addBlock
  // cancelBlock
  

//     group('Transaction Operation', () {
//       test('runTransaction runs the correct transaction operation', () async {
//         final SaveData firestore =
//             SaveData(firestore: fakeFirebaseFirestore!);

//         const String collectionName = 'collectionName';
//         const String documentPathToUpdate = 'documentPathToUpdate';
//         const String documentPathToSetTo = 'documentPathToSetTo';
//         const String documentPathToDelete = 'documentPathToDelete';

//         final CollectionReference collectionReference =
//             fakeFirebaseFirestore!.collection(collectionName);

//         final DocumentReference documentReferenceToUpdate =
//             collectionReference.doc(documentPathToUpdate);
//         final DocumentReference documentReferenceToSetTo =
//             collectionReference.doc(documentPathToSetTo);
//         final DocumentReference documentReferenceToDelete =
//             collectionReference.doc(documentPathToDelete);

//         documentReferenceToUpdate.set(data);
//         documentReferenceToDelete.set(data);

//         const Map<String, dynamic> dataToUpdateWith = {'updated_data': '43'};
//         const Map<String, dynamic> dataToSet = {'data': 44};

//         const Map<String, dynamic> expectedUpdatedData = {
//           ...data,
//           ...dataToUpdateWith
//         };

//         await firestore.runTransaction(
//             dataToUpdate: dataToUpdateWith,
//             dataToSet: dataToSet,
//             collectionName: collectionName,
//             documentPathToUpdate: documentPathToUpdate,
//             documentPathToSetTo: documentPathToSetTo,
//             documentPathToDelete: documentPathToDelete);

//         final DocumentSnapshot documentSnapshotForUpdate =
//             await documentReferenceToUpdate.get();
//         final DocumentSnapshot documentSnapshotForSet =
//             await documentReferenceToSetTo.get();
//         final DocumentSnapshot documentSnapshotForDelete =
//             await documentReferenceToDelete.get();

//         final actualDataFromUpdate = documentSnapshotForUpdate.data();
//         final actualDataFromSet = documentSnapshotForSet.data();
//         final actualDataFromDelete = documentSnapshotForDelete.data();

//         expect(actualDataFromUpdate, expectedUpdatedData);
//         expect(actualDataFromSet, dataToSet);
//         expect(actualDataFromDelete, null);
//       });
//     });

//     group('Batched Write Operation', () {
//       test('runBatchedWrite runs the correct batched write operation',
//           () async {
//         final SaveData firestore =
//             SaveData(firestore: fakeFirebaseFirestore!);
//         const String collectionName = 'collectionName';
//         const String documentPathToUpdate = 'documentPathToUpdate';
//         const String documentPathToSetTo = 'documentPathToSetTo';
//         const String documentPathToDelete = 'documentPathToDelete';

//         final CollectionReference collectionReference =
//             fakeFirebaseFirestore!.collection(collectionName);

//         final DocumentReference documentReferenceToUpdate =
//             collectionReference.doc(documentPathToUpdate);
//         final DocumentReference documentReferenceToSetTo =
//             collectionReference.doc(documentPathToSetTo);
//         final DocumentReference documentReferenceToDelete =
//             collectionReference.doc(documentPathToDelete);

//         documentReferenceToUpdate.set(data);
//         documentReferenceToDelete.set(data);

//         const Map<String, dynamic> dataToUpdateWith = {'updated_data': '43'};
//         const Map<String, dynamic> dataToSet = {'data': 44};

//         const Map<String, dynamic> expectedUpdatedData = {
//           ...data,
//           ...dataToUpdateWith
//         };

//         await firestore.runBatchedWrite(
//             dataToUpdate: dataToUpdateWith,
//             dataToSet: dataToSet,
//             collectionName: collectionName,
//             documentPathToUpdate: documentPathToUpdate,
//             documentPathToSetTo: documentPathToSetTo,
//             documentPathToDelete: documentPathToDelete);

//         final DocumentSnapshot documentSnapshotForUpdate =
//             await documentReferenceToUpdate.get();
//         final DocumentSnapshot documentSnapshotForSet =
//             await documentReferenceToSetTo.get();
//         final DocumentSnapshot documentSnapshotForDelete =
//             await documentReferenceToDelete.get();

//         final actualDataFromUpdate = documentSnapshotForUpdate.data();
//         final actualDataFromSet = documentSnapshotForSet.data();
//         final actualDataFromDelete = documentSnapshotForDelete.data();

//         expect(actualDataFromUpdate, expectedUpdatedData);
//         expect(actualDataFromSet, dataToSet);
//         expect(actualDataFromDelete, null);
//       });
//     });
//   });
// }

class MapListContains extends Matcher {
  final Map<dynamic, dynamic> _expected;

  const MapListContains(this._expected);

  @override
  Description describe(Description description) {
    return description.addDescriptionOf(_expected);
  }

  @override
  bool matches(dynamic item, Map matchState) {
    if (item is List<Map>) {
      return item.any((element) => mapEquals(element, _expected));
    }
    return false;
  }
}