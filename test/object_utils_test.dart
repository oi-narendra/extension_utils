import 'package:flutter_test/flutter_test.dart';
import 'package:extension_utils/object_utils.dart';

void main() {
  group('ObjectUtils', () {
    group('let', () {
      test('transforms value', () {
        expect('hello'.let((s) => s.toUpperCase()), 'HELLO');
      });
      test('works with null-returning block', () {
        expect(42.let((n) => n > 100 ? 'big' : null), isNull);
      });
      test('chains transformations', () {
        final result = 5.let((n) => n * 2).let((n) => n + 1);
        expect(result, 11);
      });
    });

    group('also', () {
      test('returns original value', () {
        final result = 'hello'.also((s) => s.toUpperCase());
        expect(result, 'hello');
      });
      test('executes side effect', () {
        var sideEffect = '';
        'world'.also((s) => sideEffect = s);
        expect(sideEffect, 'world');
      });
    });

    group('takeIf', () {
      test('returns value when predicate is true', () {
        expect(42.takeIf((n) => n > 0), 42);
      });
      test('returns null when predicate is false', () {
        expect(42.takeIf((n) => n > 100), isNull);
      });
    });

    group('takeUnless', () {
      test('returns null when predicate is true', () {
        expect(''.takeUnless((s) => s.isEmpty), isNull);
      });
      test('returns value when predicate is false', () {
        expect('hello'.takeUnless((s) => s.isEmpty), 'hello');
      });
    });
  });
}
