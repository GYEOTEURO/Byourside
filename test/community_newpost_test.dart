import 'dart:ui'; // Color class 사용하려면 필요
import 'package:byourside/screen/ondo/community_add_post.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Community Newpost Widget test', () {
    testWidgets('RECENT GRAMMER : OndoPostPage widget has a title text widget',
        (WidgetTester tester) async {
      // given
      await tester.pumpWidget(const OndoPostPage());

      // when
      final titleFinder = find.text('제목');

      // then
      expect(titleFinder, findsOneWidget);
      // expect(find.byType(Text), findsNWidgets(4));
    });
  });
}
