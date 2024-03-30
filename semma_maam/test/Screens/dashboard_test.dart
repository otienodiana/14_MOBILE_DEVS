import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:semma_maam/Screens/dashboard.dart'; 

void main() {
  testWidgets('DashboardScreen widget test', (WidgetTester tester) async {
    
    Null Function()? userProfileOnTap = () => null;
    Null Function()? reportsOnTap = () => null;
    Null Function()? settingsOnTap = () => null;

    // Build the widget tree
    await tester.pumpWidget(
      MaterialApp(
        home: DashboardScreen(
          userProfileOnTap: userProfileOnTap,
          reportsOnTap: reportsOnTap,
          settingsOnTap: settingsOnTap,
        ),
      ),
    );

    
    expect(find.byType(Scaffold), findsOneWidget);
    expect(find.byType(AppBar), findsOneWidget);
    expect(find.descendant(of: find.byType(AppBar), matching: find.byType(Text)), findsOneWidget);
    expect(find.byType(Container), findsWidgets);
    expect(find.byType(Row), findsOneWidget);
    expect(find.byType(ListView), findsWidgets);
    expect(find.byType(ListTile), findsNWidgets(3));
    expect(find.byType(Icon), findsNWidgets(3));
    expect(find.byType(Expanded), findsWidgets);
    expect(find.descendant(of: find.byType(Expanded), matching: find.byType(Container)), findsWidgets);
    expect(find.byType(Column), findsWidgets);
    expect(find.descendant(of: find.byType(Column), matching: find.byType(Text)), findsWidgets);
    expect(find.byType(SizedBox), findsWidgets);
  });
}