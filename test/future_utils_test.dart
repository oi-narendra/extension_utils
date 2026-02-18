import 'package:flutter_test/flutter_test.dart';
import 'package:extension_utils/future_utils.dart';

void main() {
  group('FutureUtils', () {
    group('retryFuture', () {
      test('returns value on first success', () async {
        final result = await retryFuture(() => Future.value(42));
        expect(result, 42);
      });

      test('retries on failure and eventually succeeds', () async {
        var attempts = 0;
        Future<int> flaky() async {
          attempts++;
          if (attempts < 3) throw Exception('fail');
          return 99;
        }

        final result = await retryFuture(flaky, times: 2);
        expect(result, 99);
        expect(attempts, 3);
      });

      test('rethrows after exhausting retries', () async {
        Future<int> alwaysFails() => Future.error(Exception('always fails'));
        expect(
          () => retryFuture(alwaysFails, times: 2),
          throwsException,
        );
      });
    });

    group('withTimeout', () {
      test('returns value when completes in time', () async {
        final result =
            await Future.value(10).withTimeout(const Duration(seconds: 5));
        expect(result, 10);
      });

      test('returns fallback on timeout', () async {
        final result = await Future<int>.delayed(
          const Duration(seconds: 10),
          () => 99,
        ).withTimeout(const Duration(milliseconds: 10), fallback: -1);
        expect(result, -1);
      });

      test('returns null fallback by default on timeout', () async {
        final result = await Future<int>.delayed(
          const Duration(seconds: 10),
          () => 99,
        ).withTimeout(const Duration(milliseconds: 10));
        expect(result, isNull);
      });
    });

    group('withFallback', () {
      test('returns value on success', () async {
        final result = await Future.value(5).withFallback(0);
        expect(result, 5);
      });

      test('returns fallback on error', () async {
        final result =
            await Future<int>.error(Exception('oops')).withFallback(0);
        expect(result, 0);
      });
    });
  });
}
