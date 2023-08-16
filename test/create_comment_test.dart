import 'package:byourside/screen/comment/create_comment.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage_mocks/firebase_storage_mocks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {

  setUpAll(() async {
    //await dotenv.load(fileName: 'assets/config/.env');
    await Firebase.initializeApp();
    TestWidgetsFlutterBinding.ensureInitialized();
  });

  const rootWidget = MaterialApp(
      home: CreateComment(collectionName: 'collectionName', documentID: 'documentID')
    ); 
    runApp(rootWidget);

  group('SaveData', () {
    FakeFirebaseFirestore? fakeFirebaseFirestore;
    MockFirebaseStorage? fakeFirebaseStorage;

    setUp(() {
      fakeFirebaseFirestore = FakeFirebaseFirestore();
      fakeFirebaseStorage = MockFirebaseStorage();
    });

    group(
      'Collection Operations',
      () {
        testWidgets('createComment test', (WidgetTester tester) async {
          //pumpWidget의 전달인자로 MaterialApp을 전달해야 함
          //await tester.pumpWidget(rootWidget);

          final semanticsFinder = find.byType(Semantics);
          final commentAreaFinder = find.byType(TextFormField);
          final sendButtonFinder = find.byType(IconButton);

          expect(semanticsFinder, findsOneWidget);
          expect(commentAreaFinder, findsOneWidget);
          expect(sendButtonFinder, findsOneWidget);

          await tester.tap(commentAreaFinder);
          await tester.enterText(commentAreaFinder, '댓글 작성 테스트');
          await tester.tap(sendButtonFinder);
      });

    });
  });
}  
  
