import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:semma_maam/Screens/login.dart';
import 'package:semma_maam/Screens/signup.dart';

class MockFirebaseAuth extends Mock implements FirebaseAuth {}
class MockUserCredential extends Mock implements UserCredential {}
class MockFirebaseFirestore extends Mock implements FirebaseFirestore {}
// ignore: must_be_immutable, subtype_of_sealed_class
class MockDocumentReference extends Mock implements DocumentReference {}

void main() {
  group('SignupScreen', () {
    late MockFirebaseAuth mockFirebaseAuth;
    late MockUserCredential mockUserCredential;
    late MockFirebaseFirestore mockFirebaseFirestore;
    late MockDocumentReference mockDocumentReference;

    setUp(() {
      mockFirebaseAuth = MockFirebaseAuth();
      mockUserCredential = MockUserCredential();
      mockFirebaseFirestore = MockFirebaseFirestore();
      mockDocumentReference = MockDocumentReference();
    });

    testWidgets('createUser - Successful signup', (WidgetTester tester) async {
      // Arrange
      await Firebase.initializeApp();
      when(mockFirebaseAuth.createUserWithEmailAndPassword(
              email: 'test@example.com', password: 'password'))
          .thenAnswer((_) async => mockUserCredential);
      when(mockFirebaseFirestore.collection('users').doc())
          .thenReturn(mockDocumentReference as DocumentReference<Map<String, dynamic>>);
      when(mockDocumentReference.set(any)).thenAnswer((_) async => true);

      // Build the widget
      await tester.pumpWidget(MaterialApp(home: SignupScreen()));

      // Enter user details
      await tester.enterText(find.byType(TextField).first, 'testUser');
      await tester.enterText(find.byType(TextField).at(1), 'test@example.com');
      await tester.enterText(find.byType(TextField).last, 'password');

      // Tap the Sign Up button
      await tester.tap(find.byType(TextButton));
      await tester.pumpAndSettle();

      // Verify that the user is navigated to the LoginScreen
      expect(find.byType(LoginScreen), findsOneWidget);
    });
  });
}