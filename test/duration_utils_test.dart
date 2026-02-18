import 'package:flutter_test/flutter_test.dart';
import 'package:extension_utils/duration_utils.dart';

void main() {
  group('DurationUtils', () {
    // ─── Predicates ─────────────────────────────────────────────────────────
    group('isZero', () {
      test('zero duration', () => expect(Duration.zero.isZero, isTrue));
      test('non-zero duration',
          () => expect(const Duration(seconds: 1).isZero, isFalse));
    });

    group('isNegative', () {
      test('negative duration',
          () => expect(const Duration(seconds: -1).isNegative, isTrue));
      test('positive duration',
          () => expect(const Duration(seconds: 1).isNegative, isFalse));
    });

    // ─── Derived Units ───────────────────────────────────────────────────────
    group('inWeeks', () {
      test('14 days = 2 weeks',
          () => expect(const Duration(days: 14).inWeeks, 2));
      test('10 days = 1 week',
          () => expect(const Duration(days: 10).inWeeks, 1));
    });

    // ─── DateTime Arithmetic ─────────────────────────────────────────────────
    group('ago', () {
      test('returns past datetime', () {
        final result = const Duration(hours: 1).ago;
        expect(result.isBefore(DateTime.now()), isTrue);
      });
    });

    group('fromNow', () {
      test('returns future datetime', () {
        final result = const Duration(hours: 1).fromNow;
        expect(result.isAfter(DateTime.now()), isTrue);
      });
    });

    // ─── Formatting ──────────────────────────────────────────────────────────
    group('formatted', () {
      test(
          'hours, minutes, seconds',
          () => expect(
              const Duration(hours: 1, minutes: 23, seconds: 45).formatted,
              '1h 23m 45s'));
      test('days and hours',
          () => expect(const Duration(days: 2, hours: 3).formatted, '2d 3h'));
      test('only seconds',
          () => expect(const Duration(seconds: 30).formatted, '30s'));
      test('zero duration', () => expect(Duration.zero.formatted, '0s'));
      test(
          'negative duration',
          () => expect(
              const Duration(hours: -1, minutes: -30).formatted, '-1h 30m'));
    });

    group('toHhMmSs', () {
      test(
          'formats correctly',
          () => expect(
              const Duration(hours: 1, minutes: 23, seconds: 45).toHhMmSs(),
              '01:23:45'));
      test('zero duration', () => expect(Duration.zero.toHhMmSs(), '00:00:00'));
      test('negative duration',
          () => expect(const Duration(hours: -1).toHhMmSs(), '-01:00:00'));
    });

    group('toMmSs', () {
      test(
          'formats correctly',
          () => expect(
              const Duration(minutes: 3, seconds: 45).toMmSs(), '03:45'));
      test(
          'over an hour',
          () => expect(
              const Duration(hours: 1, minutes: 5, seconds: 10).toMmSs(),
              '65:10'));
      test('zero duration', () => expect(Duration.zero.toMmSs(), '00:00'));
    });
  });
}
