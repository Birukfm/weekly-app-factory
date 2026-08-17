import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:tattoo_meaning/app.dart';

void main() {
  testWidgets('shows onboarding for a new session', (WidgetTester tester) async {
    SharedPreferences.setMockInitialValues(<String, Object>{});
    await tester.pumpWidget(const FactoryApp());
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 50));
    expect(find.text('Snap the ink'), findsOneWidget);
    expect(find.text('Next'), findsOneWidget);
  });
}
