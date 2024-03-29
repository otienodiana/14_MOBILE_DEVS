    // User enters valid email and password and clicks on Login button
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:semma_maam/Screens/login.dart';


void main() {
  testWidgets('User enters valid email and password and clicks on Login button', (WidgetTester tester) async {
    await tester.pumpWidget(LoginScreen());

    final emailField = find.byKey(const Key('email_field'));
    final passwordField = find.byKey(const Key('password_field'));
    final loginButton = find.byKey(const Key('login_button'));

    await tester.enterText(emailField, 'test@example.com');
    await tester.enterText(passwordField, 'password');
    await tester.tap(loginButton);
    await tester.pump();

    expect(find.text('Home Screen'), findsOneWidget);
  });
}