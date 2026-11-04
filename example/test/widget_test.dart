import 'package:example/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('search debounces, flushes, and cancels', (tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.enterText(find.byType(TextField), 'first');
    await tester.pump(const Duration(milliseconds: 200));
    await tester.enterText(find.byType(TextField), 'latest');
    await tester.pump(const Duration(milliseconds: 399));
    expect(find.text('Search calls: 0'), findsOneWidget);
    await tester.pump(const Duration(milliseconds: 1));
    expect(find.text('Last query: latest'), findsOneWidget);
    expect(find.text('Search calls: 1'), findsOneWidget);
    await tester.enterText(find.byType(TextField), 'now');
    await tester.tap(find.text('Run now'));
    await tester.pump();
    expect(find.text('Last query: now'), findsOneWidget);
    await tester.enterText(find.byType(TextField), 'cancelled');
    await tester.tap(find.text('Cancel pending search'));
    await tester.pump(const Duration(seconds: 1));
    expect(find.text('Last query: now'), findsOneWidget);
    expect(find.text('Search calls: 2'), findsOneWidget);
  });

  testWidgets('rapid taps are ignored until the cooldown ends', (tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.tap(find.text('Try action'));
    await tester.tap(find.text('Try action'));
    await tester.pump();
    expect(find.text('Accepted: 1 · Ignored: 1'), findsOneWidget);
    await tester.pump(const Duration(seconds: 1));
    await tester.tap(find.text('Try action'));
    await tester.pump();
    expect(find.text('Accepted: 2 · Ignored: 1'), findsOneWidget);
    await tester.pumpWidget(const SizedBox());
  });

  testWidgets('leaving the screen cancels pending work', (tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.enterText(find.byType(TextField), 'pending');
    await tester.pumpWidget(const SizedBox());
    await tester.pump(const Duration(seconds: 1));
    expect(tester.takeException(), isNull);
  });
}
