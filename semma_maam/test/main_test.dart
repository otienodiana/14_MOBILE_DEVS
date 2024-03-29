    // Should render the WelcomePage widget as the home screen
import 'package:flutter_test/flutter_test.dart';
import 'package:semma_maam/main.dart';

void main() {
  testWidgets('should render WelcomePage as home screen', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.byType(WelcomePage), findsOneWidget);
  });
}