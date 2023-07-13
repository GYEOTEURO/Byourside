import 'package:byourside/widget/alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('CustomAlertDialog displays correct content', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (BuildContext context) {
              return ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return const CustomAlertDialog(
                        message: 'This is a test message.',
                        buttonText: 'OK',
                      );
                    },
                  );
                },
                child: const Text('Show Dialog'),
              );
            },
          ),
        ),
      ),
    );

    // Find and tap the button to show the dialog
    await tester.tap(find.text('Show Dialog'));
    await tester.pumpAndSettle();

    // Verify that the dialog content is displayed correctly
    expect(find.text('This is a test message.'), findsOneWidget);
    expect(find.text('OK'), findsOneWidget);
  });
}
