import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:idcash_agent_app/main.dart';

void main() {
  testWidgets('Agent welcome screen is reachable after first launch', (tester) async {
    SharedPreferences.setMockInitialValues({introPreference: true});
    await tester.pumpWidget(const IdcashAgentApp());
    await tester.pumpAndSettle();
    expect(find.text('ID-CASH Agent'), findsOneWidget);
    expect(find.text('YOUR IDENTITY IS YOUR CASH'), findsOneWidget);
  });
}
