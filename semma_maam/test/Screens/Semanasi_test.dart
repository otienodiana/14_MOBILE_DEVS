import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:semma_maam/Screens/Semanasi.dart';
import 'package:semma_maam/Screens/dashboard.dart';
import 'package:semma_maam/Screens/userz.dart';

class MockUrlLauncher extends Mock implements UrlLauncher {
  launch(String s) {}
}

class UrlLauncher {
}

void main() {
  group('SemaNasiPage', () {
    testWidgets('renders ListView with correct tiles', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: SemaNasiPage()));
      expect(find.byType(ListView), findsOneWidget);
      expect(find.text(' YouTube Videos'), findsOneWidget);
      expect(find.text('Our Location'), findsOneWidget);
      expect(find.text('Sema Articles'), findsOneWidget);
      expect(find.text('Dashboard'), findsOneWidget);
      expect(find.text('Users'), findsOneWidget);
    });

    testWidgets('launches YouTube channel when tapping YouTube Videos tile', (WidgetTester tester) async {
      final mockUrlLauncher = MockUrlLauncher();
      var UrlLauncher;
      UrlLauncher.instance = mockUrlLauncher;

      await tester.pumpWidget(const MaterialApp(home: SemaNasiPage()));
      await tester.tap(find.text(' YouTube Videos'));

      verify(mockUrlLauncher.launch('https://www.youtube.com/channel/your_channel_id'));
    });

    testWidgets('launches Google Maps when tapping Our Location tile', (WidgetTester tester) async {
      final mockUrlLauncher = MockUrlLauncher();
      // ignore: non_constant_identifier_names
      var UrlLauncher;
      UrlLauncher.instance = mockUrlLauncher;

      await tester.pumpWidget(const MaterialApp(home: SemaNasiPage()));
      await tester.tap(find.text('Our Location'));

      verify(mockUrlLauncher.launch('https://maps.google.com/?q=your_location'));
    });

    testWidgets('launches Sema Articles website when tapping Sema Articles tile', (WidgetTester tester) async {
      final mockUrlLauncher = MockUrlLauncher();
      var UrlLauncher;
      UrlLauncher.instance = mockUrlLauncher;

      await tester.pumpWidget(const MaterialApp(home: SemaNasiPage()));
      await tester.tap(find.text('Sema Articles'));

      verify(mockUrlLauncher.launch('https://your_sema_mama_articles_website.com'));
    });

    testWidgets('navigates to DashboardScreen when tapping Dashboard button', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: SemaNasiPage()));
      await tester.tap(find.text('Dashboard'));
      await tester.pumpAndSettle();

      expect(find.byType(DashboardScreen), findsOneWidget);
    });

    testWidgets('navigates to UsersScreen when tapping Users button', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: SemaNasiPage()));
      await tester.tap(find.text('Users'));
      await tester.pumpAndSettle();

      expect(find.byType(UsersScreen), findsOneWidget);
    });
  });
}