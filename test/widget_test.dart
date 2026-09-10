import 'package:flutter_test/flutter_test.dart';
import 'package:azalea/main.dart';

void main() {
  testWidgets('AZALEA app loads successfully', (WidgetTester tester) async {
    await tester.pumpWidget(const AzaleaApp());

    // Verify that the AZALEA app loads.
    expect(find.text('AZALEA'), findsOneWidget);
  });
}