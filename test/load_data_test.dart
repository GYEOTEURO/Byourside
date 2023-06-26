import 'package:byourside/model/load_data.dart';
import 'package:byourside/model/ondo_post.dart';
import 'package:byourside/model/post_list.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:test/test.dart';

void main() {
  group('LoadData', () {
    FakeFirebaseFirestore? fakeFirebaseFirestore;

    OndoPostModel data = OndoPostModel(
      uid: 'mg12345',
      title: 'Ondo Post Upload Test',
      nickname: 'mg',
      content: 'Hello World!',
      datetime: Timestamp.now(),
      images: [],
      imgInfos: [],
      category: '자유',
      type: ['뇌병변장애'],
      likes: 0,
      likesPeople: [],
      scrapPeople: [],
      keyword: ['Ondo', 'Post', 'Upload', 'Test'],
    );

    setUp(() {
      fakeFirebaseFirestore = FakeFirebaseFirestore();
    });

    group(
      'Collection Operations',
      () {
        test('readAllCollection adds data to given collection', () async {
          //await fakeFirebaseFirestore!.collection('ondo').add(data.toMap());

          LoadData firestore = LoadData(firestore: fakeFirebaseFirestore);
          const String collectionName = 'ondo';

          final CollectionReference<Map<String, dynamic>> collectionReference =
              fakeFirebaseFirestore!.collection(collectionName);
          await collectionReference.add(data.toMap());

          final Stream<QuerySnapshot<Map<String, dynamic>>>
              expectedSnapshotStream = collectionReference.snapshots();

          final QuerySnapshot<Map<String, dynamic>> expectedQuerySnapshot =
              await expectedSnapshotStream.first;

          final List<Map<String, dynamic>> expectedDataList =
              expectedQuerySnapshot.docs.map((e) => e.data()).toList();

          final actualDataList = firestore.readAllCollection(collectionName: collectionName);

          //final Future<List<PostListModel>> actualDataList = actualSnapshotStream.first;


          //expect(actualDataList, expectedDataList);

        });});});}

//         test('getFromCollection gets data from a given collection', () async {
//           final LoadData firestore =
//               LoadData(firestore: fakeFirebaseFirestore!);
//           const String collectionPath = 'collectionPath';

//           await fakeFirebaseFirestore!.collection(collectionPath).add(data);

//           final List<Map<String, dynamic>> dataList = (await firestore
//                   .getFromCollection(collectionPath: collectionPath))
//               .docs
//               .map((e) => e.data())
//               .toList();

//           expect(dataList, const MapListContains(data));
//         });

//         test(
//             'getSnapshotStreamFromCollection returns a stream of QuerySnaphot containing the data added',
//             () async {
//           final LoadData firestore =
//               LoadData(firestore: fakeFirebaseFirestore!);
//           const String collectionPath = 'collectionPath';

//           final CollectionReference<Map<String, dynamic>> collectionReference =
//               fakeFirebaseFirestore!.collection(collectionPath);
//           await collectionReference.add(data);

//           final Stream<QuerySnapshot<Map<String, dynamic>>>
//               expectedSnapshotStream = collectionReference.snapshots();

//           final actualSnapshotStream = firestore
//               .getSnapshotStreamFromCollection(collectionPath: collectionPath);

//           final QuerySnapshot<Map<String, dynamic>> expectedQuerySnapshot =
//               await expectedSnapshotStream.first;
//           final QuerySnapshot<Map<String, dynamic>> actualQuerySnapshot =
//               await actualSnapshotStream.first;

//           final List<Map<String, dynamic>> expectedDataList =
//               expectedQuerySnapshot.docs.map((e) => e.data()).toList();
//           final List<Map<String, dynamic>> actualDataList =
//               actualQuerySnapshot.docs.map((e) => e.data()).toList();

//           expect(actualDataList, expectedDataList);
//         });
//       },
//     );

//     group('Document Operations', () {
//       test(
//           'deleteDocumentFromCollection deletes a document from a given collection',
//           () async {
//         final LoadData firestore =
//             LoadData(firestore: fakeFirebaseFirestore!);
//         const String collectionPath = 'collectionPath';

//         final CollectionReference<Map<String, dynamic>> collectionReference =
//             fakeFirebaseFirestore!.collection(collectionPath);

//         final DocumentReference<Map<String, dynamic>> documentReference =
//             await collectionReference.add(data);

//         final String documentPath = documentReference.path;

//         await firestore.deleteDocumentFromCollection(
//             collectionPath: collectionPath, documentPath: documentPath);

//         final DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
//             await collectionReference.doc(documentPath).get();

//         expect(documentSnapshot.exists, false);
//       });

//       test('getFromDocument gets data from a given document', () async {
//         final LoadData firestore =
//             LoadData(firestore: fakeFirebaseFirestore!);

//         const String collectionPath = 'collectionPath';
//         const String documentPath = 'documentPath';

//         final DocumentReference<Map<String, dynamic>> documentReference =
//             fakeFirebaseFirestore!.collection(collectionPath).doc(documentPath);

//         await documentReference.set(data);

//         final DocumentSnapshot<Map<String, dynamic>> expectedDocumentSnapshot =
//             await documentReference.get();

//         final DocumentSnapshot<Map<String, dynamic>> actualDocumentSnapshot =
//             await firestore.getFromDocument(
//                 collectionPath: collectionPath, documentPath: documentPath);

//         final Map<String, dynamic>? expectedData =
//             expectedDocumentSnapshot.data();
//         final Map<String, dynamic>? actualData = actualDocumentSnapshot.data();

//         expect(actualData, expectedData);
//       });

//       test('setDataOnDocument runs the correct operations in the transaction',
//           () async {
//         final LoadData firestore =
//             LoadData(firestore: fakeFirebaseFirestore!);

//         const String collectionPath = 'collectionPath';
//         const String documentPath = 'documentPath';

//         await firestore.setDataOnDocument(
//             data: data,
//             collectionPath: collectionPath,
//             documentPath: documentPath);

//         final DocumentReference<Map<String, dynamic>> documentReference =
//             fakeFirebaseFirestore!.collection(collectionPath).doc(documentPath);

//         final DocumentSnapshot<Map<String, dynamic>> actualDocumentSnapshot =
//             await documentReference.get();
//         final Map<String, dynamic>? actualData = actualDocumentSnapshot.data();

//         const Map<String, dynamic> expectedData = data;

//         expect(actualData, expectedData);
//       });

//       test(
//           'getSnapshotStreamFromDocument returns a stream of DocumentSnapshot containing the data set',
//           () async {
//         final LoadData firestore =
//             LoadData(firestore: fakeFirebaseFirestore!);

//         const String collectionPath = 'collectionPath';
//         const String documentPath = 'documentPath';

//         final DocumentReference<Map<String, dynamic>> documentReference =
//             fakeFirebaseFirestore!.collection(collectionPath).doc(documentPath);

//         await documentReference.set(data);

//         final Stream<DocumentSnapshot<Map<String, dynamic>>>
//             expectedSnapshotStream = documentReference.snapshots();

//         final Stream<DocumentSnapshot<Map<String, dynamic>>>
//             actualSnapshotStream =
//             firestore.getSnapshotStreamFromDocument(
//                 collectionPath: collectionPath, documentPath: documentPath);

//         final DocumentSnapshot<Map<String, dynamic>> expectedDocumentSnapshot =
//             await expectedSnapshotStream.first;
//         final DocumentSnapshot<Map<String, dynamic>> actualDocumentSnapshot =
//             await actualSnapshotStream.first;

//         final Map<String, dynamic>? expectedData =
//             expectedDocumentSnapshot.data();
//         final Map<String, dynamic>? actualData = actualDocumentSnapshot.data();

//         expect(actualData, expectedData);
//       });

//       test('updateDataOnDocument updates a given document\'s data', () async {
//         final LoadData firestore =
//             LoadData(firestore: fakeFirebaseFirestore!);

//         const String collectionPath = 'collectionPath';
//         const String documentPath = 'documentPath';

//         final DocumentReference<Map<String, dynamic>> documentReference =
//             fakeFirebaseFirestore!.collection(collectionPath).doc(documentPath);

//         await documentReference.set(data);

//         final Map<String, dynamic> dataUpdate = {'data': '43'};

//         await firestore.updateDataOnDocument(
//             data: dataUpdate,
//             collectionPath: collectionPath,
//             documentPath: documentPath);

//         final DocumentSnapshot<Map<String, dynamic>> actualDocumentSnapshot =
//             await documentReference.get();

//         final Map<String, dynamic>? actualData = actualDocumentSnapshot.data();

//         final Map<String, dynamic> expectedData = dataUpdate;

//         expect(actualData, expectedData);
//       });
//     });

//     group('Transaction Operation', () {
//       test('runTransaction runs the correct transaction operation', () async {
//         final LoadData firestore =
//             LoadData(firestore: fakeFirebaseFirestore!);

//         const String collectionPath = 'collectionPath';
//         const String documentPathToUpdate = 'documentPathToUpdate';
//         const String documentPathToSetTo = 'documentPathToSetTo';
//         const String documentPathToDelete = 'documentPathToDelete';

//         final CollectionReference collectionReference =
//             fakeFirebaseFirestore!.collection(collectionPath);

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
//             collectionPath: collectionPath,
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
//         final LoadData firestore =
//             LoadData(firestore: fakeFirebaseFirestore!);
//         const String collectionPath = 'collectionPath';
//         const String documentPathToUpdate = 'documentPathToUpdate';
//         const String documentPathToSetTo = 'documentPathToSetTo';
//         const String documentPathToDelete = 'documentPathToDelete';

//         final CollectionReference collectionReference =
//             fakeFirebaseFirestore!.collection(collectionPath);

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
//             collectionPath: collectionPath,
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