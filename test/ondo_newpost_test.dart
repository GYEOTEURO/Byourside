import 'dart:ui'; // Color class 사용하려면 필요
import 'package:byourside/screen/ondo/postPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('OLD GRAMMER : OndoPostPage widget has a proper title',
      (WidgetTester tester) async {
    // given
    await tester.pumpWidget(
        const OndoPostPage(primaryColor: Color(0xFF045558), title: '마음온도 글쓰기'));

    // when
    final appbar = tester.widget<AppBar>(find.byType(AppBar));

    // then
    expect(appbar.title, '마음온도 글쓰기');
  });

  testWidgets('RECENT GRAMMER : OndoPostPage widget has a proper title',
      (WidgetTester tester) async {
    // given
    await tester.pumpWidget(
        const OndoPostPage(primaryColor: Color(0xFF045558), title: '마음온도 글쓰기'));

    // when
    final titleFinder = find.text('마음온도 글쓰기');

    // then
    expect(titleFinder, findsOneWidget);
  });
}
