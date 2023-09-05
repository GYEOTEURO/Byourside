import 'package:byourside/screen/community/add_post_category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:byourside/screen/community/add_post.dart';

void main() {
  // group('CommunityAddPostCategory', () {
  //   testWidgets('Category button selection', (WidgetTester tester) async {
  //     final categories = Category(null, null);
  //     await tester.pumpWidget(
  //       MaterialApp(
  //         home: CommunityAddPostCategory(categories: categories),
  //       ),
  //     );

  //     // Verify initial state
  //     expect(categories.category, isNull);

  //     // Select a category button
  //     final categoryButton = find.widgetWithText(ElevatedButton, '자유게시판');
  //     await tester.tap(categoryButton);
  //     await tester.pump();

  //     // Verify category selection
  //     expect(categories.category, '자유게시판');

  //     // Deselect the category button
  //     await tester.tap(categoryButton);
  //     await tester.pump();

  //     // Verify category deselection
  //     expect(categories.category, isNull);
  //   });

  //   testWidgets('Type button selection', (WidgetTester tester) async {
  //     final categories = Category(null, null);
  //     await tester.pumpWidget(
  //       MaterialApp(
  //         home: CommunityAddPostCategory(categories: categories),
  //       ),
  //     );

  //     // Verify initial state
  //     expect(categories.type, isNull);

  //     // Select a type button
  //     final typeButton = find.widgetWithText(ElevatedButton, '발달장애');
  //     await tester.tap(typeButton);
  //     await tester.pump();

  //     // Verify type selection
  //     expect(categories.type, ['발달장애']);

  //     // Deselect the type button
  //     await tester.tap(typeButton);
  //     await tester.pump();

  //     // Verify type deselection
  //     expect(categories.type, isNull);
  //   });

  //   testWidgets('Back button pressed', (WidgetTester tester) async {
  //     final categories = Category(null, null);
  //     await tester.pumpWidget(
  //       MaterialApp(
  //         home: CommunityAddPostCategory(categories: categories),
  //       ),
  //     );

  //     // Select a category and type buttons
  //     final categoryButton = find.widgetWithText(ElevatedButton, '자유게시판');
  //     final typeButton = find.widgetWithText(ElevatedButton, '발달장애');
  //     await tester.tap(categoryButton);
  //     await tester.tap(typeButton);
  //     await tester.pump();

  //     // Press the back button
  //     final backButton = find.byIcon(Icons.arrow_back);
  //     await tester.tap(backButton);
  //     await tester.pump();

  //     // Verify category and type values
  //     expect(categories.category, '자유게시판');
  //     expect(categories.type, ['발달장애']);
  //   });
  // });
}
