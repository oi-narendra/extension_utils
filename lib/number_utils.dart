import 'dart:math';

extension NumberUtils on num {
  /// Returns `true` if the number is even, `false` otherwise.
  bool get isEven => this % 2 == 0;

  /// Returns `true` if the number is odd, `false` otherwise.
  bool get isOdd => this % 2 != 0;

  /// Returns `true` if the number is positive, `false` otherwise.
  bool get isPositive => this > 0;

  /// Returns `true` if the number is negative, `false` otherwise.
  bool get isNegative => this < 0;

  /// Returns `true` if the number is zero, `false` otherwise.
  bool get isZero => this == 0;

  /// Returns `true` if the number is an integer, `false` otherwise.
  bool get isInteger => this == toInt();

  /// Returns `true` if the number is a double, `false` otherwise.
  bool get isDouble => this == toDouble();

  /// Swap the sign of the number.
  num swapSign() => -this;

  /// Convert the number to a [String] with the specified [precision].
  /// If [precision] is not specified, the default is 2.

  String toPrecision([int precision = 2]) {
    var result = toStringAsFixed(precision);
    if (result.endsWith('.00')) {
      result = result.substring(0, result.length - 3);
    }
    return result;
  }

  /// Convert to currency string with specified delimiter and precision.
  /// If [delimiter] is not specified, the default is ','.
  /// If [precision] is not specified, the default is 2.

  String toCurrencyString([String delimiter = ',', int precision = 2]) {
    var result1 = toPrecision(precision);
    var parts = result1.split('.');
    var integer = parts[0];
    var decimal = parts[1];
    var result = '';
    var count = 0;
    for (var i = integer.length - 1; i >= 0; i--) {
      result = integer[i] + result;
      count++;
      if (count == 3 && i != 0) {
        result = delimiter + result;
        count = 0;
      }
    }
    return '$result.$decimal';
  }

  /// Check if the number is in the range [min] to [max].
  /// Returns `true` if the number is in the range, `false` otherwise.
  bool isInRange(num min, num max) => this >= min && this <= max;

  /// Check if the number starts with [prefix].
  /// Returns `true` if the number starts with [prefix], `false` otherwise.
  bool startsWith(num prefix) => toString().startsWith(prefix.toString());

  /// Check if the number ends with [suffix].
  /// Returns `true` if the number ends with [suffix], `false` otherwise.
  bool endsWith(num suffix) => toString().endsWith(suffix.toString());

  /// Check if the number contains [substring].
  /// Returns `true` if the number contains [substring], `false` otherwise.
  bool contains(num substring) => toString().contains(substring.toString());

  /// Get count of a [substring] in the number.
  /// Returns the count of [substring] in the number.

  int count(num substring) {
    var count = 0;
    var index = 0;
    while (true) {
      index = toString().indexOf(substring.toString(), index);
      if (index == -1) break;
      count++;
      index++;
    }
    return count;
  }

  /// get the index of all occurrences of [substring] in the number.

  List<int> indexesOf(num substring) {
    final indexes = <int>[];
    var index = 0;
    while (true) {
      index = toString().indexOf(substring.toString(), index);
      if (index == -1) break;
      indexes.add(index);
      index++;
    }
    return indexes;
  }

  /// Get the index of the first occurrence of [substring] in the number.
  int indexOfFirst(num substring) => toString().indexOf(substring.toString());

  /// Get the index of the last occurrence of [substring] in the number.
  /// Returns the index of the last occurrence of [substring] in the number.
  int indexOfLast(num substring) =>
      toString().lastIndexOf(substring.toString());

  /// sum of digits
  /// Returns the sum of digits in the number.
  num sumOfDigits() {
    num sum = 0;
    var number = this;
    while (number > 0) {
      sum += number % 10;
      number = (number / 10).floor();
    }
    return sum;
  }

  /// Get the digits after a [substring] in the number
  /// Returns the digits after a [substring] in the number
  num digitsAfter(num substring) {
    var index = toString().indexOf(substring.toString());
    if (index == -1) return 0;
    var result = toString().substring(index + 1);
    return int.parse(result);
  }

  /// Get the digits before a [substring] in the number
  /// Returns the digits before a [substring] in the number
  num digitsBefore(num substring) {
    var index = toString().indexOf(substring.toString());
    if (index == -1) return 0;
    var result = toString().substring(0, index);
    return int.parse(result);
  }

  /// Get the digits between [start] and [end] in the number
  /// Returns the digits between [start] and [end] in the number
  num digitsBetween(num start, num end) {
    var startIndex = toString().indexOf(start.toString());
    if (startIndex == -1) return 0;
    var endIndex = toString().indexOf(end.toString(), startIndex + 1);
    if (endIndex == -1) return 0;
    var result = toString().substring(startIndex + 1, endIndex);
    return int.parse(result);
  }

  /// Get the digits before the first occurrence of [substring] in the number
  /// Returns the digits before the first occurrence of [substring] in the number
  num digitsBeforeFirst(num substring) {
    var index = toString().indexOf(substring.toString());
    if (index == -1) return 0;
    var result = toString().substring(0, index);
    return int.parse(result);
  }

  /// Get the digits after the first occurrence of [substring] in the number
  /// Returns the digits after the first occurrence of [substring] in the number
  num digitsAfterFirst(num substring) {
    var index = toString().indexOf(substring.toString());
    if (index == -1) return 0;
    var result = toString().substring(index + 1);
    return int.parse(result);
  }

  /// Get the digits before the last occurrence of [substring] in the number
  /// Returns the digits before the last occurrence of [substring] in the number
  num digitsBeforeLast(num substring) {
    var index = toString().lastIndexOf(substring.toString());
    if (index == -1) return 0;
    var result = toString().substring(0, index);
    return int.parse(result);
  }

  /// Get the digits after the last occurrence of [substring] in the number
  /// Returns the digits after the last occurrence of [substring] in the number
  num digitsAfterLast(num substring) {
    var index = toString().lastIndexOf(substring.toString());
    if (index == -1) return 0;
    var result = toString().substring(index + 1);
    return int.parse(result);
  }

  /// Get the lorem ipsum text of [this] words.
  String loremIpsum() {
    var words = [
      'lorem',
      'ipsum',
      'dolor',
      'sit',
      'amet',
      'consectetur',
      'adipiscing',
      'elit',
      'sed',
      'do',
      'eiusmod',
      'tempor',
      'incididunt',
      'ut',
      'labore',
      'et',
      'dolore',
      'magna',
      'aliqua',
      'ut',
      'enim',
      'ad',
      'minim',
      'veniam',
      'quis',
      'nostrud',
      'exercitation',
      'ullamco',
      'laboris',
      'nisi',
      'ut',
      'aliquip',
      'ex',
      'ea',
      'commodo',
      'consequat',
      'duis',
      'aute',
      'irure',
      'dolor',
      'in',
      'reprehenderit',
      'in',
      'voluptate',
      'velit',
      'esse',
      'cillum',
      'dolore',
      'eu',
      'fugiat',
      'nulla',
      'pariatur',
      'excepteur',
      'sint',
      'occaecat',
      'cupidatat',
      'non',
      'proident',
      'sunt',
      'in',
      'culpa',
      'qui',
      'officia',
      'deserunt',
      'mollit',
      'anim',
      'id',
      'est',
      'laborum'
    ];

    var result = '';
    for (var i = 0; i < this; i++) {
      result += '${words[i % words.length]} ';
    }
    return result.trim();
  }

  /// Get list of random numbers.
  List<num> randomList({int min = 0, int max = 100}) {
    var result = <num>[];
    for (var i = 0; i < this; i++) {
      result.add(Random().nextInt(max - min) + min);
    }
    return result;
  }
}
