import 'package:flutter_test/flutter_test.dart';
import 'package:npk2/main.dart';

void main() {
  testWidgets('Smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const AgroCalcApp());
  });
}
