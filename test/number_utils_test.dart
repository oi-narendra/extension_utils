import 'package:flutter_test/flutter_test.dart';
import 'package:extension_utils/number_utils.dart';

void main() {
  group('NumberUtils', () {
    // ─── Predicates ─────────────────────────────────────────────────────────
    group('isPositive', () {
      test('positive', () => expect(5.isPositive, isTrue));
      test('zero', () => expect(0.isPositive, isFalse));
      test('negative', () => expect((-3).isPositive, isFalse));
    });

    group('isZero', () {
      test('zero', () => expect(0.isZero, isTrue));
      test('non-zero', () => expect(1.isZero, isFalse));
    });

    group('isInteger', () {
      test('integer', () => expect(3.0.isInteger, isTrue));
      test('double', () => expect(3.5.isInteger, isFalse));
    });

    group('isPrime', () {
      test('2 is prime', () => expect(2.isPrime, isTrue));
      test('3 is prime', () => expect(3.isPrime, isTrue));
      test('4 is not prime', () => expect(4.isPrime, isFalse));
      test('17 is prime', () => expect(17.isPrime, isTrue));
      test('1 is not prime', () => expect(1.isPrime, isFalse));
      test('0 is not prime', () => expect(0.isPrime, isFalse));
    });

    group('isInRange', () {
      test('in range', () => expect(5.isInRange(1, 10), isTrue));
      test('at boundary', () => expect(1.isInRange(1, 10), isTrue));
      test('out of range', () => expect(11.isInRange(1, 10), isFalse));
    });

    // ─── Arithmetic ─────────────────────────────────────────────────────────
    group('swapSign', () {
      test('positive to negative', () => expect(5.swapSign(), -5));
      test('negative to positive', () => expect((-5).swapSign(), 5));
    });

    group('lerp', () {
      test('midpoint', () => expect(0.lerp(100, 0.5), 50.0));
      test('start', () => expect(0.lerp(100, 0.0), 0.0));
      test('end', () => expect(0.lerp(100, 1.0), 100.0));
    });

    group('normalize', () {
      test('midpoint', () => expect(50.normalize(0, 100), 0.5));
      test('min', () => expect(0.normalize(0, 100), 0.0));
      test('max', () => expect(100.normalize(0, 100), 1.0));
      test('same min max', () => expect(5.normalize(5, 5), 0.0));
    });

    group('factorial', () {
      test('0! = 1', () => expect(0.factorial(), 1));
      test('1! = 1', () => expect(1.factorial(), 1));
      test('5! = 120', () => expect(5.factorial(), 120));
      test('negative throws',
          () => expect(() => (-1).factorial(), throwsArgumentError));
    });

    group('sumOfDigits', () {
      test('123 -> 6', () => expect(123.sumOfDigits(), 6));
      test('0 -> 0', () => expect(0.sumOfDigits(), 0));
    });

    group('digitCount', () {
      test('single digit', () => expect(5.digitCount, 1));
      test('three digits', () => expect(123.digitCount, 3));
    });

    group('reversed', () {
      test('reverses digits', () => expect(1234.reversed, 4321));
      test('negative', () => expect((-1234).reversed, -4321));
    });

    // ─── Angle Conversion ────────────────────────────────────────────────────
    group('toRadians / toDegrees', () {
      test('180 degrees = pi radians',
          () => expect(180.toRadians(), closeTo(3.14159, 0.001)));
      test('pi radians = 180 degrees',
          () => expect(3.14159.toDegrees(), closeTo(180, 0.01)));
    });

    // ─── Formatting ─────────────────────────────────────────────────────────
    group('toPrecision', () {
      test('strips trailing zeros', () => expect(1.0.toPrecision(), '1'));
      test(
          'keeps significant decimals', () => expect(1.5.toPrecision(), '1.5'));
      test('rounds', () => expect(1.545.roundTo(2), 1.55));
    });

    group('toCurrencyString', () {
      test('formats with commas',
          () => expect(1234567.89.toCurrencyString(), '1,234,567.89'));
      test('with symbol',
          () => expect(1000.0.toCurrencyString(symbol: '\$'), '\$1,000'));
      test('whole number', () => expect(1000.0.toCurrencyString(), '1,000'));
    });

    group('percentage', () {
      test('25 of 200 = 12.5%', () => expect(25.percentage(200), '12.5%'));
      test('zero total', () => expect(25.percentage(0), '0%'));
    });

    group('pad', () {
      test('pads with zeros', () => expect(7.pad(3), '007'));
      test('no padding needed', () => expect(1234.pad(3), '1234'));
    });

    group('toOrdinal', () {
      test('1st', () => expect(1.toOrdinal(), '1st'));
      test('2nd', () => expect(2.toOrdinal(), '2nd'));
      test('3rd', () => expect(3.toOrdinal(), '3rd'));
      test('4th', () => expect(4.toOrdinal(), '4th'));
      test('11th (special case)', () => expect(11.toOrdinal(), '11th'));
      test('21st', () => expect(21.toOrdinal(), '21st'));
      test('22nd', () => expect(22.toOrdinal(), '22nd'));
    });

    group('toRoman', () {
      test('1 = I', () => expect(1.toRoman(), 'I'));
      test('4 = IV', () => expect(4.toRoman(), 'IV'));
      test('9 = IX', () => expect(9.toRoman(), 'IX'));
      test('2024 = MMXXIV', () => expect(2024.toRoman(), 'MMXXIV'));
      test('out of range throws',
          () => expect(() => 0.toRoman(), throwsRangeError));
    });

    group('toBinary / toHex / toOctal', () {
      test('10 in binary', () => expect(10.toBinary(), '1010'));
      test('255 in hex', () => expect(255.toHex(), 'ff'));
      test('255 in hex uppercase',
          () => expect(255.toHex(upperCase: true), 'FF'));
      test('8 in octal', () => expect(8.toOctal(), '10'));
    });

    group('roundTo', () {
      test('rounds to 2 decimals', () => expect(3.14159.roundTo(2), 3.14));
      test('rounds to 0 decimals', () => expect(3.7.roundTo(0), 4.0));
    });
  });
}
