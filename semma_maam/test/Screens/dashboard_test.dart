    // When the onTap function of any of the ListTiles is called, it should perform the expected action
import 'package:flutter_test/flutter_test.dart';
import 'package:semma_maam/Screens/dashboard.dart';

// ignore: non_constant_identifier_names
Future<void> test_listtile_on_tap_action() async {
  // Arrange
  bool userProfileTapped = false;
  bool reportsTapped = false;
  bool settingsTapped = false;

  // ignore: unused_local_variable
  final widget = DashboardScreen(
    userProfileOnTap: () {
      userProfileTapped = true;
    },
    reportsOnTap: () {
      reportsTapped = true;
    },
    settingsOnTap: () {
      settingsTapped = true;
    },
  );

  // Act
  final userProfileFinder = find.text('UserProfile');
  final reportsFinder = find.text('Reports');
  final settingsFinder = find.text('Settings');

// ignore: prefer_typing_uninitialized_variables
  var tester;
  await tester.tap(userProfileFinder);
  
  await tester.tap(reportsFinder);
  await tester.tap(settingsFinder);

  // Assert
  expect(userProfileTapped, isTrue);
  expect(reportsTapped, isTrue);
  expect(settingsTapped, isTrue);
}