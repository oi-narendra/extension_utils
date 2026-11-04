import 'package:extension_utils/extension_utils.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const interval = Duration(milliseconds: 100);
  group('Debouncer', () {
    test('rejects negative delay', () {
      expect(() => Debouncer(delay: const Duration(microseconds: -1)),
          throwsArgumentError);
    });
    testWidgets('runs latest callback after a full quiet period',
        (tester) async {
      final debounce = Debouncer(delay: interval);
      addTearDown(debounce.dispose);
      final calls = <int>[];
      expect(debounce.isPending, isFalse);
      debounce.run(() => calls.add(1));
      await tester.pump(const Duration(milliseconds: 99));
      expect(calls, isEmpty);
      debounce.run(() => calls.add(2));
      await tester.pump(const Duration(milliseconds: 99));
      expect(calls, isEmpty);
      expect(debounce.isPending, isTrue);
      await tester.pump(const Duration(milliseconds: 1));
      expect(calls, [2]);
      expect(debounce.isPending, isFalse);
      await tester.pump(interval);
      expect(calls, [2]);
    });
    testWidgets('cancel discards work and permits reuse', (tester) async {
      final debounce = Debouncer(delay: interval);
      addTearDown(debounce.dispose);
      var calls = 0;
      debounce.run(() => calls++);
      debounce.cancel();
      debounce.cancel();
      await tester.pump(interval);
      expect(calls, 0);
      expect(debounce.isPending, isFalse);
      debounce.run(() => calls++);
      await tester.pump(interval);
      expect(calls, 1);
    });
    testWidgets('flush runs latest callback once and can be repeated',
        (tester) async {
      final debounce = Debouncer(delay: interval);
      addTearDown(debounce.dispose);
      final calls = <int>[];
      debounce.flush();
      debounce.run(() => calls.add(1));
      debounce.run(() => calls.add(2));
      debounce.flush();
      debounce.flush();
      expect(calls, [2]);
      await tester.pump(interval);
      expect(calls, [2]);
    });
    testWidgets('callback can schedule another callback', (tester) async {
      final debounce = Debouncer(delay: interval);
      addTearDown(debounce.dispose);
      var calls = 0;
      debounce.run(() {
        calls++;
        debounce.run(() => calls++);
      });
      await tester.pump(interval);
      expect(calls, 1);
      expect(debounce.isPending, isTrue);
      await tester.pump(interval);
      expect(calls, 2);
    });
    testWidgets('flush errors propagate without leaving pending work',
        (tester) async {
      final debounce = Debouncer(delay: interval);
      addTearDown(debounce.dispose);
      debounce.run(() => throw StateError('callback'));
      expect(debounce.flush, throwsStateError);
      expect(debounce.isPending, isFalse);
      var called = false;
      debounce.run(() => called = true);
      await tester.pump(interval);
      expect(called, isTrue);
    });
    testWidgets('zero delay is deferred and still coalesces calls',
        (tester) async {
      final debounce = Debouncer(delay: Duration.zero);
      addTearDown(debounce.dispose);
      final calls = <int>[];
      debounce.run(() => calls.add(1));
      debounce.run(() => calls.add(2));
      expect(calls, isEmpty);
      await tester.pump(Duration.zero);
      expect(calls, [2]);
    });
    testWidgets('dispose cancels work and rejects reuse', (tester) async {
      final debounce = Debouncer(delay: interval);
      var called = false;
      debounce.run(() => called = true);
      debounce.dispose();
      debounce.dispose();
      debounce.flush();
      debounce.cancel();
      expect(() => debounce.run(() {}), throwsStateError);
      await tester.pump(interval);
      expect(called, isFalse);
      expect(debounce.isPending, isFalse);
    });
  });
  group('Throttler', () {
    test('rejects negative interval', () {
      expect(() => Throttler(interval: const Duration(microseconds: -1)),
          throwsArgumentError);
    });
    testWidgets('runs immediately and accepts again at cooldown boundary',
        (tester) async {
      final throttle = Throttler(interval: interval);
      addTearDown(throttle.dispose);
      final calls = <int>[];
      expect(throttle.isActive, isFalse);
      expect(throttle.run(() => calls.add(1)), isTrue);
      expect(calls, [1]);
      expect(throttle.isActive, isTrue);
      await tester.pump(const Duration(milliseconds: 99));
      expect(throttle.run(() => calls.add(2)), isFalse);
      await tester.pump(const Duration(milliseconds: 1));
      expect(throttle.isActive, isFalse);
      expect(calls, [1]);
      expect(throttle.run(() => calls.add(3)), isTrue);
      await tester.pump(interval);
      expect(calls, [1, 3]);
    });
    testWidgets('reentrant calls are ignored', (tester) async {
      final throttle = Throttler(interval: interval);
      addTearDown(throttle.dispose);
      throttle.run(() {
        expect(throttle.run(() => fail('reentrant call')), isFalse);
      });
      throttle.dispose();
    });
    testWidgets('cancel permits immediate reuse', (tester) async {
      final throttle = Throttler(interval: interval);
      addTearDown(throttle.dispose);
      throttle.run(() {});
      throttle.cancel();
      throttle.cancel();
      expect(throttle.isActive, isFalse);
      expect(throttle.run(() {}), isTrue);
      throttle.dispose();
    });
    testWidgets('errors propagate and keep cooldown active', (tester) async {
      final throttle = Throttler(interval: interval);
      addTearDown(throttle.dispose);
      expect(() => throttle.run(() => throw StateError('callback')),
          throwsStateError);
      expect(throttle.run(() => fail('cooldown bypassed')), isFalse);
      await tester.pump(interval);
      expect(throttle.run(() {}), isTrue);
      throttle.dispose();
    });
    testWidgets('zero interval accepts every call', (tester) async {
      final throttle = Throttler(interval: Duration.zero);
      addTearDown(throttle.dispose);
      var calls = 0;
      expect(throttle.run(() => calls++), isTrue);
      expect(throttle.run(() => calls++), isTrue);
      expect(calls, 2);
      expect(throttle.isActive, isFalse);
    });
    testWidgets('dispose rejects reuse even after cooldown', (tester) async {
      final throttle = Throttler(interval: interval);
      throttle.run(() {});
      throttle.dispose();
      throttle.dispose();
      throttle.cancel();
      await tester.pump(interval);
      expect(throttle.isActive, isFalse);
      expect(() => throttle.run(() {}), throwsStateError);
    });
  });
}
