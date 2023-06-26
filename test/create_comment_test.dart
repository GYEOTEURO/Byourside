import 'package:byourside/constants.dart' as constants;
import 'package:byourside/screen/comment/create_comment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('createComment test', (WidgetTester tester) async {

    //home에는 미리 작성해둔 widget 입력 MyStateView -> Scaffold 리턴함
    const rootWidget = MaterialApp(
      title: 'material',
      home: const CreateComment(collectionName: 'collectionName', documentID: 'documentID', primaryColor: constants.mainColor)
    );

    //pumpWidget의 전달인자로 MaterialApp 을 전달해야 함
    await tester.pumpWidget(rootWidget);

    final commentDescriptionFinder = find.byIcon(Icons.send);

    expect(commentDescriptionFinder, findsOneWidget);
  });
}