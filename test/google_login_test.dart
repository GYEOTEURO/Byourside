import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:byourside/screen/authenticate/social_login/social_login.dart';
import 'package:mockito/mockito.dart';
import 'package:byourside/screen/authenticate/info/user_type.dart';

class MockGoogleSignIn extends Mock implements GoogleSignIn {}

class MockGoogleSignInAuthentication extends Mock
    implements GoogleSignInAuthentication {}

class MockGoogleSignInAccount extends Mock implements GoogleSignInAccount {}

void main() {
  late MockGoogleSignIn mockGoogleSignIn;

  setUp(() {
    mockGoogleSignIn = MockGoogleSignIn();
  });

testWidgets('Login with Google success', (WidgetTester tester) async {
  var fakeGoogleAuth = MockGoogleSignInAuthentication();
  when(fakeGoogleAuth.idToken).thenReturn('fake_id_token');
  when(fakeGoogleAuth.accessToken).thenReturn('fake_access_token');

  var fakeUser = MockGoogleSignInAccount();
  when(fakeUser.displayName).thenReturn('John Doe');
  when(fakeUser.email).thenReturn('johndoe@example.com');
  when(fakeUser.authentication).thenAnswer((_) => Future.value(fakeGoogleAuth));

  when(mockGoogleSignIn.signIn()).thenAnswer((_) => Future.value(fakeUser));

    // Build the widget and trigger the login process
    await tester.pumpWidget(const MaterialApp(
      home: SocialLogin(),
    ));

    // Tap the "Google 로그인" button
    await tester.tap(find.text('Google 로그인'));
    await tester.pumpAndSettle();

    // Verify that the user is navigated to the SetupUser page
    expect(find.byType(SetupUser), findsOneWidget);
  });

  testWidgets('Login with Google cancelled', (WidgetTester tester) async {
    // Mock the GoogleSignIn.signIn() to return null (cancelled)
    when(mockGoogleSignIn.signIn()).thenAnswer((_) => Future.value(null));

    // Build the widget and trigger the login process
    await tester.pumpWidget(const MaterialApp(
      home: SocialLogin(),
    ));

    // Tap the "Google 로그인" button
    await tester.tap(find.text('Google 로그인'));
    await tester.pumpAndSettle();

    // Verify that the user remains on the same page
    expect(find.byType(SocialLogin), findsOneWidget);
  });

  // You can write similar tests for sign in with Apple
}