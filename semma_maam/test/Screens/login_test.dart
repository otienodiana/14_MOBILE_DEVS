import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mockito/mockito.dart';
import 'package:semma_maam/Screens/home.dart';
import 'package:semma_maam/Screens/login.dart';
import 'package:semma_maam/Screens/signup.dart';

class MockFirebaseAuth extends Mock implements FirebaseAuth {}
class MockUserCredential extends Mock implements UserCredential {}
class MockGoogleSignIn extends Mock implements GoogleSignIn {}
// ignore: must_be_immutable
class MockGoogleSignInAccount extends Mock implements GoogleSignInAccount {}
class MockGoogleSignInAuthentication extends Mock implements GoogleSignInAuthentication {}

void main() {
  group('LoginScreen', () {
    late MockFirebaseAuth mockFirebaseAuth;
    late MockUserCredential mockUserCredential;
    late MockGoogleSignIn mockGoogleSignIn;
    late MockGoogleSignInAccount mockGoogleSignInAccount;
    late MockGoogleSignInAuthentication mockGoogleSignInAuthentication;

    setUp(() {
      mockFirebaseAuth = MockFirebaseAuth();
      mockUserCredential = MockUserCredential();
      mockGoogleSignIn = MockGoogleSignIn();
      mockGoogleSignInAccount = MockGoogleSignInAccount();
      mockGoogleSignInAuthentication = MockGoogleSignInAuthentication();
    });

    testWidgets('User enters valid email and password and clicks on Login button', (WidgetTester tester) async {
      // Arrange
      await Firebase.initializeApp();
      when(mockFirebaseAuth.signInWithEmailAndPassword(
        email: 'test@example.com',
        password: 'password',
      )).thenAnswer((_) async => mockUserCredential);

      // Build the widget
      await tester.pumpWidget(MaterialApp(home: LoginScreen()));

      // Enter user details
      await tester.enterText(find.byType(TextFormField).first, 'test@example.com');
      await tester.enterText(find.byType(TextFormField).last, 'password');

      // Tap the Login button
      await tester.tap(find.byType(ElevatedButton).first);
      await tester.pumpAndSettle();

      // Verify that the user is navigated to the HomeScreen
      expect(find.byType(HomeScreen), findsOneWidget);
    });

    testWidgets('User clicks on Sign in with Google button', (WidgetTester tester) async {
  // Arrange
  await Firebase.initializeApp();
  when(mockGoogleSignIn.signIn()).thenAnswer((_) async => mockGoogleSignInAccount);
  when(mockGoogleSignInAccount.authentication).thenAnswer((_) async => mockGoogleSignInAuthentication);
  when(mockFirebaseAuth.signInWithCredential(argThat(isA<AuthCredential>())))
      .thenAnswer((_) async => mockUserCredential);

  // Build the widget
  await tester.pumpWidget(MaterialApp(home: LoginScreen()));

  // Tap the Sign in with Google button
  await tester.tap(find.byType(ElevatedButton).last);
  await tester.pumpAndSettle();

  // Verify that the Google sign-in process is initiated
  verify(mockGoogleSignIn.signIn()).called(1);
});

    testWidgets('User navigates to SignupScreen', (WidgetTester tester) async {
      // Arrange
      await Firebase.initializeApp();
      when(mockFirebaseAuth.signInWithEmailAndPassword(
        email: 'test@example.com',
        password: 'password',
      )).thenThrow(FirebaseAuthException(code: 'user-not-found'));

      // Build the widget
      await tester.pumpWidget(MaterialApp(home: LoginScreen()));

      // Enter user details
      await tester.enterText(find.byType(TextFormField).first, 'test@example.com');
      await tester.enterText(find.byType(TextFormField).last, 'password');

      // Tap the Login button
      await tester.tap(find.byType(ElevatedButton).first);
      await tester.pumpAndSettle();

      // Verify that the user is navigated to the SignupScreen
      expect(find.byType(SignupScreen), findsOneWidget);
    });
  });
}