import 'dart:math' as math;

/// Extensions on [num] for real-world utility operations.
extension NumberUtils on num {
  // ─── Predicates ──────────────────────────────────────────────────────────────

  /// Returns `true` if this number is positive (> 0).
  bool get isPositive => this > 0;

  /// Returns `true` if this number is zero.
  bool get isZero => this == 0;

  /// Returns `true` if this number has no fractional part.
  bool get isInteger => this == truncate();

  /// Returns `true` if this number has a fractional part.
  bool get isDouble => this != truncate();

  /// Returns `true` if this number is prime.
  /// Only meaningful for positive integers.
  bool get isPrime {
    final n = toInt();
    if (n < 2) return false;
    if (n == 2) return true;
    if (n.isEven) return false;
    for (var i = 3; i * i <= n; i += 2) {
      if (n % i == 0) return false;
    }
    return true;
  }

  /// Returns `true` if this number is in the range [min]..[max] (inclusive).
  bool isInRange(num min, num max) => this >= min && this <= max;

  // ─── Arithmetic ──────────────────────────────────────────────────────────────

  /// Negates this number.
  num swapSign() => -this;

  /// Linear interpolation from this number to [to] by factor [t] (0..1).
  ///
  /// ```dart
  /// 0.lerp(100, 0.5) // 50.0
  /// ```
  double lerp(num to, double t) => this + (to - this) * t;

  /// Normalizes this number to the range 0..1 given [min] and [max].
  ///
  /// ```dart
  /// 50.normalize(0, 100) // 0.5
  /// ```
  double normalize(num min, num max) {
    if (max == min) return 0;
    return (this - min) / (max - min);
  }

  /// Returns the factorial of this number (must be a non-negative integer).
  ///
  /// ```dart
  /// 5.factorial() // 120
  /// ```
  int factorial() {
    final n = toInt();
    if (n < 0) throw ArgumentError('factorial requires a non-negative integer');
    if (n == 0 || n == 1) return 1;
    var result = 1;
    for (var i = 2; i <= n; i++) {
      result *= i;
    }
    return result;
  }

  /// Returns the sum of digits of this number (integer part only).
  ///
  /// ```dart
  /// 123.sumOfDigits() // 6
  /// ```
  int sumOfDigits() {
    var n = toInt().abs();
    var sum = 0;
    while (n > 0) {
      sum += n % 10;
      n ~/= 10;
    }
    return sum;
  }

  /// Returns the number of digits in the integer part.
  int get digitCount => toInt().abs().toString().length;

  /// Reverses the digits of this number.
  ///
  /// ```dart
  /// 1234.reversed // 4321
  /// ```
  int get reversed =>
      int.parse(toInt().abs().toString().split('').reversed.join()) *
      (this < 0 ? -1 : 1);

  // ─── Angle Conversion ────────────────────────────────────────────────────────

  /// Converts degrees to radians.
  double toRadians() => this * math.pi / 180;

  /// Converts radians to degrees.
  double toDegrees() => this * 180 / math.pi;

  // ─── Formatting ──────────────────────────────────────────────────────────────

  /// Converts to a string with [precision] decimal places, stripping trailing
  /// zeros (e.g. `1.50` → `'1.5'`, `1.00` → `'1'`).
  ///
  /// ```dart
  /// 1.5.toPrecision(2) // '1.5'
  /// 1.0.toPrecision(2) // '1'
  /// ```
  String toPrecision([int precision = 2]) {
    final s = toStringAsFixed(precision);
    if (!s.contains('.')) return s;
    return s.replaceAll(RegExp(r'\.?0+$'), '');
  }

  /// Converts to a currency-formatted string.
  ///
  /// ```dart
  /// 1234567.89.toCurrencyString() // '1,234,567.89'
  /// 1000.toCurrencyString(symbol: '\$') // '\$1,000'
  /// ```
  String toCurrencyString({
    String delimiter = ',',
    int precision = 2,
    String symbol = '',
  }) {
    final fixed = toStringAsFixed(precision);
    final parts = fixed.split('.');
    var integer = parts[0];
    final decimal = parts.length > 1 ? parts[1] : '';

    // Insert thousands delimiters
    final buf = StringBuffer();
    for (var i = 0; i < integer.length; i++) {
      if (i > 0 && (integer.length - i) % 3 == 0) buf.write(delimiter);
      buf.write(integer[i]);
    }
    integer = buf.toString();

    final hasDecimal = decimal.isNotEmpty && decimal != '0' * precision;
    final result = hasDecimal ? '$integer.$decimal' : integer;
    return '$symbol$result';
  }

  /// Returns this number as a percentage of [total], formatted to [precision]
  /// decimal places.
  ///
  /// ```dart
  /// 25.percentage(200) // '12.5%'
  /// ```
  String percentage(num total, {int precision = 1}) {
    if (total == 0) return '0%';
    return '${((this / total) * 100).toStringAsFixed(precision)}%';
  }

  /// Pads this number's string representation to [width] with [padChar].
  ///
  /// ```dart
  /// 7.pad(3) // '007'
  /// ```
  String pad(int width, {String padChar = '0'}) =>
      toString().padLeft(width, padChar);

  /// Returns the ordinal string for this number ("1st", "2nd", "3rd", etc.).
  ///
  /// ```dart
  /// 1.toOrdinal() // '1st'
  /// 11.toOrdinal() // '11th'
  /// 22.toOrdinal() // '22nd'
  /// ```
  String toOrdinal() {
    final n = toInt();
    if (n % 100 >= 11 && n % 100 <= 13) return '${n}th';
    switch (n % 10) {
      case 1:
        return '${n}st';
      case 2:
        return '${n}nd';
      case 3:
        return '${n}rd';
      default:
        return '${n}th';
    }
  }

  /// Converts this number to a Roman numeral string (1–3999).
  ///
  /// ```dart
  /// 2024.toRoman() // 'MMXXIV'
  /// ```
  String toRoman() {
    final n = toInt();
    if (n < 1 || n > 3999) throw RangeError('toRoman supports 1–3999');
    const vals = [1000, 900, 500, 400, 100, 90, 50, 40, 10, 9, 5, 4, 1];
    const syms = [
      'M',
      'CM',
      'D',
      'CD',
      'C',
      'XC',
      'L',
      'XL',
      'X',
      'IX',
      'V',
      'IV',
      'I'
    ];
    final buf = StringBuffer();
    var remaining = n;
    for (var i = 0; i < vals.length; i++) {
      while (remaining >= vals[i]) {
        buf.write(syms[i]);
        remaining -= vals[i];
      }
    }
    return buf.toString();
  }

  /// Converts this number to its binary string representation.
  ///
  /// ```dart
  /// 10.toBinary() // '1010'
  /// ```
  String toBinary() => toInt().toRadixString(2);

  /// Converts this number to its hexadecimal string representation.
  ///
  /// ```dart
  /// 255.toHex() // 'ff'
  /// ```
  String toHex({bool upperCase = false}) {
    final s = toInt().toRadixString(16);
    return upperCase ? s.toUpperCase() : s;
  }

  /// Converts this number to its octal string representation.
  ///
  /// ```dart
  /// 8.toOctal() // '10'
  /// ```
  String toOctal() => toInt().toRadixString(8);

  /// Rounds this number to [decimals] decimal places.
  ///
  /// ```dart
  /// 3.14159.roundTo(2) // 3.14
  /// ```
  double roundTo(int decimals) {
    final factor = math.pow(10, decimals);
    return (this * factor).round() / factor;
  }

  // ─── Random ──────────────────────────────────────────────────────────────────

  /// Returns a list of [this] random numbers in [min]..[max].
  List<num> randomList({int min = 0, int max = 100}) {
    final rng = math.Random();
    return List.generate(toInt(), (_) => rng.nextInt(max - min) + min);
  }

  // ─── Clamping ────────────────────────────────────────────────────────────────

  /// Clamps this number to the range [min]..[max].
  ///
  /// ```dart
  /// 150.clampTo(0, 100) // 100
  /// -5.clampTo(0, 100)  // 0
  /// ```
  num clampTo(num min, num max) => this < min ? min : (this > max ? max : this);

  // ─── File Size ───────────────────────────────────────────────────────────────

  /// Formats this number (bytes) as a human-readable file size string.
  ///
  /// ```dart
  /// 1048576.toFileSize()       // '1.0 MB'
  /// 1536.toFileSize()          // '1.5 KB'
  /// 512.toFileSize()           // '512 B'
  /// ```
  String toFileSize({int decimals = 1}) {
    const units = ['B', 'KB', 'MB', 'GB', 'TB', 'PB'];
    var value = toDouble();
    var unitIndex = 0;
    while (value >= 1024 && unitIndex < units.length - 1) {
      value /= 1024;
      unitIndex++;
    }
    final formatted = unitIndex == 0
        ? value.toStringAsFixed(0)
        : value.toStringAsFixed(decimals);
    return '$formatted ${units[unitIndex]}';
  }

  // ─── Duration ────────────────────────────────────────────────────────────────

  /// Converts this number (seconds) to a [Duration].
  ///
  /// ```dart
  /// 90.toDuration() // Duration(minutes: 1, seconds: 30)
  /// ```
  Duration toDuration() => Duration(microseconds: (toDouble() * 1e6).round());

  // ─── Compact ─────────────────────────────────────────────────────────────────

  /// Returns a compact string representation (K, M, B, T).
  ///
  /// ```dart
  /// 1500000.toCompact()   // '1.5M'
  /// 2300.toCompact()      // '2.3K'
  /// 999.toCompact()       // '999'
  /// ```
  String toCompact({int decimals = 1}) {
    final abs = this.abs();
    final sign = this < 0 ? '-' : '';
    if (abs >= 1e12) return '$sign${(abs / 1e12).toStringAsFixed(decimals)}T';
    if (abs >= 1e9) return '$sign${(abs / 1e9).toStringAsFixed(decimals)}B';
    if (abs >= 1e6) return '$sign${(abs / 1e6).toStringAsFixed(decimals)}M';
    if (abs >= 1e3) return '$sign${(abs / 1e3).toStringAsFixed(decimals)}K';
    return toString();
  }

  // ─── Number Theory ───────────────────────────────────────────────────────────

  /// Returns the greatest common divisor of this and [other].
  ///
  /// ```dart
  /// 12.gcd(8) // 4
  /// ```
  int gcd(int other) {
    var a = toInt().abs();
    var b = other.abs();
    while (b != 0) {
      final t = b;
      b = a % b;
      a = t;
    }
    return a;
  }

  /// Returns the least common multiple of this and [other].
  ///
  /// ```dart
  /// 4.lcm(6) // 12
  /// ```
  int lcm(int other) {
    final a = toInt().abs();
    final b = other.abs();
    if (a == 0 || b == 0) return 0;
    return (a ~/ gcd(b)) * b;
  }

  /// Returns `true` if this number is a Fibonacci number.
  ///
  /// ```dart
  /// 13.isFibonacci // true
  /// 14.isFibonacci // false
  /// ```
  bool get isFibonacci {
    bool isPerfectSquare(int n) {
      final s = math.sqrt(n).toInt();
      return s * s == n;
    }

    final n = toInt();
    if (n < 0) return false;
    return isPerfectSquare(5 * n * n + 4) || isPerfectSquare(5 * n * n - 4);
  }

  // ─── Words ───────────────────────────────────────────────────────────────────

  /// Converts this integer (0–999,999,999) to its English word representation.
  ///
  /// ```dart
  /// 42.toWords()      // 'forty-two'
  /// 1001.toWords()    // 'one thousand one'
  /// ```
  String toWords() {
    final n = toInt();
    if (n < 0) return 'negative ${(-n).toWords()}';
    if (n == 0) return 'zero';
    const ones = [
      '',
      'one',
      'two',
      'three',
      'four',
      'five',
      'six',
      'seven',
      'eight',
      'nine',
      'ten',
      'eleven',
      'twelve',
      'thirteen',
      'fourteen',
      'fifteen',
      'sixteen',
      'seventeen',
      'eighteen',
      'nineteen',
    ];
    const tens = [
      '',
      '',
      'twenty',
      'thirty',
      'forty',
      'fifty',
      'sixty',
      'seventy',
      'eighty',
      'ninety',
    ];
    String helper(int num) {
      if (num == 0) return '';
      if (num < 20) return ones[num];
      if (num < 100) {
        final t = tens[num ~/ 10];
        final o = ones[num % 10];
        return o.isEmpty ? t : '$t-$o';
      }
      final rest = helper(num % 100);
      return rest.isEmpty
          ? '${ones[num ~/ 100]} hundred'
          : '${ones[num ~/ 100]} hundred $rest';
    }

    final parts = <String>[];
    if (n >= 1000000000) parts.add('${helper(n ~/ 1000000000)} billion');
    if ((n ~/ 1000000) % 1000 != 0) {
      parts.add('${helper((n ~/ 1000000) % 1000)} million');
    }
    if ((n ~/ 1000) % 1000 != 0) {
      parts.add('${helper((n ~/ 1000) % 1000)} thousand');
    }
    if (n % 1000 != 0) parts.add(helper(n % 1000));
    return parts.join(' ');
  }

  // ─── Safe Arithmetic ─────────────────────────────────────────────────────────

  /// Divides this number by [divisor], returning [fallback] if divisor is zero.
  ///
  /// ```dart
  /// 10.safeDivide(2)  // 5.0
  /// 10.safeDivide(0)  // 0.0
  /// ```
  double safeDivide(num divisor, {double fallback = 0.0}) {
    if (divisor == 0) return fallback;
    return toDouble() / divisor.toDouble();
  }
}
