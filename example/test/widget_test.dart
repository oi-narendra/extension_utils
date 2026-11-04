import 'package:example/main.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('example app renders', (tester) async {
    await tester.pumpWidget(const MyApp());
    expect(find.text('Example'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
