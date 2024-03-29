import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:semma_maam/Screens/signup.dart';



// Mock BuildContext
class MockBuildContext extends Mock implements BuildContext {}

// Mock Navigator
class MockNavigatorObserver extends Mock implements NavigatorObserver {
  @override
  // ignore: override_on_non_overriding_member
  void didPushReplacement(Route<dynamic>? route, Route<dynamic>? previousRoute) {}
}

// Mock FirebaseAuth
class MockFirebaseAuth extends Mock implements FirebaseAuth {}

// Mock FirebaseFirestore
class MockFirebaseFirestore extends Mock {
  dynamic collection(String s) {}
}

// Mock UserCredential
class MockUserCredential extends Mock implements UserCredential {}

void main() {
  setUpAll(() async {
    // Initialize Firebase for testing
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
  });

  group('SignupScreen - createUser method', () {
    late MockBuildContext mockBuildContext;
    late MockFirebaseAuth mockFirebaseAuth;
    late MockFirebaseFirestore mockFirebaseFirestore;
    late MockNavigatorObserver mockNavigatorObserver;

    setUp(() {
      // Initialize mocks
      mockBuildContext = MockBuildContext();
      mockFirebaseAuth = MockFirebaseAuth();
      mockFirebaseFirestore = MockFirebaseFirestore();
      mockNavigatorObserver = MockNavigatorObserver();
    });

    test('createUser - Successful signup', () async {
      // Arrange
      final signupScreen = SignupScreen();

      // Mock FirebaseAuth createUserWithEmailAndPassword method
      when(mockFirebaseAuth.createUserWithEmailAndPassword(
        email: 'test@example.com',
        password: 'password',
      )).thenAnswer((_) => Future.value(MockUserCredential()));

      // Mock FirebaseFirestore set method
      when(mockFirebaseFirestore.collection('users').doc(any).set(any)).thenAnswer((_) => Future.value());

      // Act
      await signupScreen.createUser(
        context: mockBuildContext,
        username: 'testUser',
        email: 'test@example.com',
        password: 'password',
      );

      // Assert
      // Verify that navigation to LoginScreen occurred
      verify(mockNavigatorObserver.didPushReplacement(any, any)).called(1);
    });
  });
}
