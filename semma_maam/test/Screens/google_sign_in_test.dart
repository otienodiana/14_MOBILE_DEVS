import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';
import 'package:semma_maam/Screens/google_sign_in.dart';

class MockGoogleSignIn extends Mock implements GoogleSignIn {}

// ignore: must_be_immutable
class MockGoogleSignInAccount extends Mock implements GoogleSignInAccount {}

class MockGoogleSignInAuthentication extends Mock implements GoogleSignInAuthentication {}

class MockUser extends Mock implements User {
  @override
  String get displayName => 'Test User';

  @override
  String get email => 'test@example.com';
}

class MockUserCredential extends Mock implements UserCredential {
  @override
  User get user => MockUser();
}

class MockAuthCredential extends Mock implements AuthCredential {}

void main() {
  testWidgets('User can sign in with Google successfully', (WidgetTester tester) async {
    final mockGoogleSignIn = MockGoogleSignIn();
    final mockGoogleSignInAccount = MockGoogleSignInAccount();
    final mockGoogleSignInAuthentication = MockGoogleSignInAuthentication();
    final mockUserCredential = MockUserCredential();
    final mockAuthCredential = MockAuthCredential(); // Create mock AuthCredential instance

    when(mockGoogleSignIn.signIn()).thenAnswer((_) async => mockGoogleSignInAccount);
    when(mockGoogleSignInAccount.authentication).thenAnswer((_) async => mockGoogleSignInAuthentication);
    when(mockGoogleSignInAuthentication.accessToken).thenReturn('access_token');
    when(mockGoogleSignInAuthentication.idToken).thenReturn('id_token');
    when(FirebaseAuth.instance.signInWithCredential(mockAuthCredential)) // Pass mock AuthCredential instance
        .thenAnswer((_) async => mockUserCredential);

    await tester.pumpWidget(const MaterialApp(home: GoogleSignInScreen()));

    await tester.tap(find.byType(ElevatedButton));
    await tester.pumpAndSettle();

    verify(mockGoogleSignIn.signIn()).called(1);
    verify(mockGoogleSignInAccount.authentication).called(1);
    verify(FirebaseAuth.instance.signInWithCredential(mockAuthCredential)).called(1); // Pass mock AuthCredential instance
    expect(find.text('Test User'), findsOneWidget); // Check for display name
    expect(find.text('test@example.com'), findsOneWidget); // Check for email
  });
}
