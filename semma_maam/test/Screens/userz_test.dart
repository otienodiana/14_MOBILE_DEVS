    // Renders the 'User Management' screen with an app bar and a list of users.
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:semma_maam/Screens/userz.dart';

void main() {
  testWidgets('should render User Management screen with app bar and list of users', (WidgetTester tester) async {
    // Wrapping the UsersScreen with MaterialApp
    await tester.pumpWidget(MaterialApp(home: UsersScreen()));

    // Expectations to find AppBar, 'User Management' text, and ListView
    expect(find.byType(AppBar), findsOneWidget);
    expect(find.text('User Management'), findsOneWidget);
    expect(find.byType(ListView), findsOneWidget);
  });
}