import 'package:byourside/screen/community/community_add_post.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Test CommunityAddPost', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: CommunityAddPost()));

    // Find widgets
    final titleTextFieldFinder = find.byKey(const Key('title_text_field'));
    final categoryButtonFinder = find.byKey(const Key('category_button'));
    final attachButtonFinder = find.byKey(const Key('attach_button'));
    final contentTextFieldFinder = find.byKey(const Key('content_text_field'));
    final submitButtonFinder = find.byKey(const Key('submit_button'));

    // Enter text in title text field
    await tester.enterText(titleTextFieldFinder, 'Test Title');
    expect(find.text('Test Title'), findsOneWidget);

    // Tap category button
    await tester.tap(categoryButtonFinder);
    await tester.pumpAndSettle();

    // Select category
    await tester.tap(find.text('Test Category'));
    await tester.pumpAndSettle();
    expect(find.text('Test Category'), findsOneWidget);

    // Tap attach button
    await tester.tap(attachButtonFinder);
    await tester.pumpAndSettle();

    // Tap attach button in image picker dialog
    await tester.tap(find.byIcon(Icons.attach_file));
    await tester.pumpAndSettle();

    // Select image in image picker dialog
    await tester.tap(find.byIcon(Icons.image));
    await tester.pumpAndSettle();

    // Tap submit button
    await tester.tap(submitButtonFinder);
    await tester.pumpAndSettle();

    // Find dialogs
    expect(find.text('게시판 종류를 선택해주세요'), findsOneWidget);
    expect(find.text('확인'), findsOneWidget);

    // Tap confirm button in dialog
    await tester.tap(find.text('확인'));
    await tester.pumpAndSettle();

    // Verify dialog is dismissed
    expect(find.text('게시판 종류를 선택해주세요'), findsNothing);
    expect(find.text('확인'), findsNothing);

    // Enter text in content text field
    await tester.enterText(contentTextFieldFinder, 'Test Content');
    expect(find.text('Test Content'), findsOneWidget);

    // Tap submit button
    await tester.tap(submitButtonFinder);
    await tester.pumpAndSettle();

    // Verify navigation
    expect(find.byType(CommunityAddPost), findsNothing);
  });
}
