import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:semma_maam/Screens/Semanasi.dart';
import 'package:semma_maam/Screens/home.dart';

void main() {
  testWidgets('HomeScreen UI Test', (WidgetTester tester) async {
    // Build our HomeScreen widget and trigger a frame.
    await tester.pumpWidget(const MaterialApp(
      home: HomeScreen(),
    ));

    // Verify that our app bar title is displayed.
    expect(find.text('SemaHome'), findsOneWidget);

    // Tap the 'Next' button and trigger a frame.
    await tester.tap(find.text('Next'));
    await tester.pumpAndSettle(); // Wait for navigation to complete and widgets to settle.

    // Verify that the navigation to SemaNasiPage happened.
    expect(find.byType(SemaNasiPage), findsOneWidget);
  });
}
