import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:app_boilerplate/app.dart';

void main() {
  testWidgets('shows onboarding for a new session', (WidgetTester tester) async {
    SharedPreferences.setMockInitialValues(<String, Object>{});
    await tester.pumpWidget(const FactoryApp());
    await tester.pumpAndSettle();
    expect(find.text('See the problem'), findsOneWidget);
    expect(find.text('Next'), findsOneWidget);
  });
}
