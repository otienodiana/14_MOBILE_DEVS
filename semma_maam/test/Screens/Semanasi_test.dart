import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:semma_maam/Screens/Semanasi.dart';

import 'signup_test.dart'; // Import your SemaNasiPage implementation

class MockNavigator extends Mock implements NavigatorState {
  @override
  String toString({DiagnosticLevel? minLevel}) {
    return super.toString();
  }
}



void main() {
  testWidgets('Clicking on "YouTube Videos" opens the YouTube channel in a browser', (WidgetTester tester) async {
    // Arrange
    final mockNavigator = MockNavigator();
    final mockObserver = MockNavigatorObserver();
    
    // Build the widget
    await tester.pumpWidget(MaterialApp(
      home: const SemaNasiPage(),
      navigatorKey: GlobalKey<NavigatorState>(),
      navigatorObservers: [mockObserver],
    ));
    
    // Act: Find and tap the 'YouTube Videos' widget
    await tester.tap(find.text('YouTube Videos'));
    await tester.pumpAndSettle();
    
    // Assert: Verify that navigator.push is called with the correct MaterialPageRoute
    verify(mockNavigator.push(anything as Route).whenComplete(1 as FutureOr<void> Function()));
  });
}

