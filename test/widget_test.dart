import 'package:flutter_test/flutter_test.dart';

import 'package:tasky_app/main.dart';

void main() {
  testWidgets('shows welcome screen when username is missing', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp(username: null));

    expect(find.text('Tasky'), findsOneWidget);
    expect(find.text('Welcome To Tasky'), findsOneWidget);
  });
}
