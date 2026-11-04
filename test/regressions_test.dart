import 'package:extension_utils/extension_utils.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('query parameter removal', () {
    for (final input in [
      'https://example.com?q=dart',
      'https://user:pass@example.com:8443/a%2Fb?q=one&q=two#part%20one',
      '/relative/path?q=',
      'relative?q=value#fragment',
    ]) {
      test('removes the last parameter from $input', () {
        final uri = Uri.parse(input);
        final result = uri.removeQueryParam('q');
        expect(result.hasQuery, isFalse);
        expect(result.scheme, uri.scheme);
        expect(result.authority, uri.authority);
        expect(result.path, uri.path);
        expect(result.fragment, uri.fragment);
        expect(result.hasFragment, uri.hasFragment);
      });
    }
    test('preserves repeated values for other parameters', () {
      final result = Uri.parse('https://example.com?tag=a&tag=b&q=search')
          .removeQueryParam('q');
      expect(result.queryParametersAll, {
        'tag': ['a', 'b']
      });
    });
    test('an absent parameter leaves the original URI unchanged', () {
      for (final input in [
        'https://example.com',
        'https://example.com?',
        '/path?tag=a&tag=b#part'
      ]) {
        expect(Uri.parse(input).removeQueryParam('missing').toString(), input);
      }
    });
  });

  group('calendar boundaries', () {
    for (final utc in [false, true]) {
      DateTime date(int y, int m, int d,
              [int h = 0, int min = 0, int sec = 0, int ms = 0]) =>
          utc
              ? DateTime.utc(y, m, d, h, min, sec, ms)
              : DateTime(y, m, d, h, min, sec, ms);
      test('preserves ${utc ? 'UTC' : 'local'} dates for all boundaries', () {
        final input = date(2024, 2, 29, 12);
        final expected = {
          input.startOfDay: date(2024, 2, 29),
          input.endOfDay: date(2024, 2, 29, 23, 59, 59, 999),
          input.startOfWeek: date(2024, 2, 26),
          input.endOfWeek: date(2024, 3, 3, 23, 59, 59, 999),
          input.startOfMonth: date(2024, 2, 1),
          input.endOfMonth: date(2024, 2, 29, 23, 59, 59, 999),
          input.startOfYear: date(2024, 1, 1),
          input.endOfYear: date(2024, 12, 31, 23, 59, 59, 999),
        };
        for (final entry in expected.entries) {
          expect(entry.key, entry.value);
          expect(entry.key.isUtc, utc);
        }
      });
      test('week boundaries cross years in ${utc ? 'UTC' : 'local'} time', () {
        final input = date(2025, 1, 1);
        expect(input.startOfWeek, date(2024, 12, 30));
        expect(input.endOfWeek, date(2025, 1, 5, 23, 59, 59, 999));
      });
    }
    test('week boundaries use calendar days across daylight saving', () {
      // CI also runs this file with TZ=Australia/Sydney.
      final sunday = DateTime(2024, 10, 6, 23, 30);
      expect(sunday.endOfWeek, DateTime(2024, 10, 6, 23, 59, 59, 999));
      final monday = DateTime(2024, 10, 7, 0, 30);
      expect(monday.startOfWeek, DateTime(2024, 10, 7));
      final beforeChange = DateTime(2024, 10, 2, 23, 30);
      expect(beforeChange.endOfWeek, DateTime(2024, 10, 6, 23, 59, 59, 999));
    });
  });

  group('Unicode reversal', () {
    for (final (input, expected) in [
      ('', ''),
      ('hello', 'olleh'),
      ('a😀', '😀a'),
      ('a👩🏽‍💻b', 'b👩🏽‍💻a'),
      ('a🇳🇵b', 'b🇳🇵a'),
      ('a e\u0301', 'e\u0301 a'),
      ('a👨‍👩‍👧‍👦b', 'b👨‍👩‍👧‍👦a'),
    ]) {
      test('reverses $input without splitting graphemes', () {
        expect(input.reverse(), expected);
        expect(input.reverse().reverse(), input);
      });
    }
  });
}
