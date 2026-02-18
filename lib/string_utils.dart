import 'dart:convert';

import 'package:flutter/material.dart';

/// Extensions on [String] for real-world utility operations.
extension StringUtils on String {
  // ─── Case Conversion ────────────────────────────────────────────────────────

  /// Returns a new string with the first character in upper case.
  ///
  /// ```dart
  /// 'hello'.capitalize() // 'Hello'
  /// ```
  String capitalize() {
    if (isEmpty) return '';
    return '${this[0].toUpperCase()}${substring(1)}';
  }

  /// Returns a new string with the first character in lower case.
  ///
  /// ```dart
  /// 'Hello'.uncapitalize() // 'hello'
  /// ```
  String uncapitalize() {
    if (isEmpty) return '';
    return '${this[0].toLowerCase()}${substring(1)}';
  }

  /// Capitalizes the first character of each word.
  ///
  /// ```dart
  /// 'hello world'.titleCase() // 'Hello World'
  /// ```
  String titleCase() {
    if (isEmpty) return '';
    return split(' ').map((w) => w.capitalize()).join(' ');
  }

  /// Converts a camelCase or PascalCase string to snake_case.
  ///
  /// ```dart
  /// 'helloWorld'.toSnakeCase() // 'hello_world'
  /// ```
  String toSnakeCase() {
    if (isEmpty) return '';
    return replaceAllMapped(
      RegExp(r'(?<=[a-z0-9])([A-Z])'),
      (m) => '_${m[1]}',
    ).replaceAll(RegExp(r'[\s\-]+'), '_').toLowerCase();
  }

  /// Converts a string to camelCase.
  ///
  /// ```dart
  /// 'hello_world'.toCamelCase() // 'helloWorld'
  /// 'Hello World'.toCamelCase() // 'helloWorld'
  /// ```
  String toCamelCase() {
    if (isEmpty) return '';
    final words = trim().split(RegExp(r'[\s_\-]+'));
    if (words.isEmpty) return '';
    return words.first.toLowerCase() +
        words.skip(1).map((w) => w.capitalize()).join();
  }

  /// Converts a string to PascalCase.
  ///
  /// ```dart
  /// 'hello_world'.toPascalCase() // 'HelloWorld'
  /// ```
  String toPascalCase() {
    if (isEmpty) return '';
    return trim().split(RegExp(r'[\s_\-]+')).map((w) => w.capitalize()).join();
  }

  /// Converts a string to kebab-case.
  ///
  /// ```dart
  /// 'helloWorld'.toKebabCase() // 'hello-world'
  /// ```
  String toKebabCase() {
    if (isEmpty) return '';
    return replaceAllMapped(
      RegExp(r'(?<=[a-z0-9])([A-Z])'),
      (m) => '-${m[1]}',
    ).replaceAll(RegExp(r'[\s_]+'), '-').toLowerCase();
  }

  /// Converts a string to Train-Case.
  ///
  /// ```dart
  /// 'hello world'.toTrainCase() // 'Hello-World'
  /// ```
  String toTrainCase() {
    if (isEmpty) return '';
    return split(RegExp(r'[\s_\-]+')).map((w) => w.capitalize()).join('-');
  }

  /// Converts a string to dot.case.
  ///
  /// ```dart
  /// 'hello world'.toDotCase() // 'hello.world'
  /// ```
  String toDotCase() {
    if (isEmpty) return '';
    return toSnakeCase().replaceAll('_', '.');
  }

  /// Converts a camelized string to all lower case separated by underscores.
  ///
  /// ```dart
  /// 'helloWorld'.underscore() // '_hello_world'
  /// ```
  String underscore() {
    if (isEmpty) return '';
    return replaceAllMapped(RegExp(r'([A-Z])'), (m) => '_${m[1]}')
        .toLowerCase();
  }

  /// Converts a string into a human-readable form by inserting spaces before
  /// uppercase letters and lowercasing the result.
  ///
  /// ```dart
  /// 'helloWorld'.humanize() // 'hello world'
  /// ```
  String humanize() {
    if (isEmpty) return '';
    return replaceAllMapped(RegExp(r'([A-Z])'), (m) => ' ${m[1]}')
        .trim()
        .toLowerCase();
  }

  // ─── Validation ─────────────────────────────────────────────────────────────

  /// Returns `true` if this is a valid email address.
  bool get isEmail =>
      RegExp(r'^[a-zA-Z0-9._%+\-]+@[a-zA-Z0-9.\-]+\.[a-zA-Z]{2,}$')
          .hasMatch(this);

  /// Returns `true` if this string contains only digits (0–9).
  bool get isDigits => isNotEmpty && RegExp(r'^[0-9]+$').hasMatch(this);

  /// Returns `true` if this string contains only alphabetic characters.
  bool get isAlpha => isNotEmpty && RegExp(r'^[a-zA-Z]+$').hasMatch(this);

  /// Returns `true` if this string contains only alphanumeric characters.
  bool get isAlphanumeric =>
      isNotEmpty && RegExp(r'^[a-zA-Z0-9]+$').hasMatch(this);

  /// Returns `true` if this is a valid `http://` or `https://` URL.
  bool get isUrl =>
      RegExp(r'^https?://[^\s/$.?#].[^\s]*$', caseSensitive: false)
          .hasMatch(this);

  /// Returns `true` if this is a valid phone number (E.164 and common formats).
  bool get isPhoneNumber => RegExp(r'^\+?[\d\s\-().]{7,15}$').hasMatch(this);

  /// Returns `true` if this is a valid hexadecimal color (`#RGB` or `#RRGGBB`).
  bool get isHexColor =>
      RegExp(r'^#?([a-fA-F0-9]{6}|[a-fA-F0-9]{3})$').hasMatch(this);

  /// Returns `true` if this is a valid IPv4 address.
  bool get isIPv4 => RegExp(
        r'^((25[0-5]|2[0-4]\d|[01]?\d\d?)\.){3}(25[0-5]|2[0-4]\d|[01]?\d\d?)$',
      ).hasMatch(this);

  /// Returns `true` if this is a valid IPv6 address.
  bool get isIPv6 => RegExp(
        r'^(([0-9a-fA-F]{1,4}:){7}[0-9a-fA-F]{1,4}|::1|::)$',
      ).hasMatch(this);

  /// Returns `true` if this is a strong password:
  /// at least 8 characters, one uppercase, one lowercase, one digit,
  /// one special character.
  bool get isStrongPassword =>
      length >= 8 &&
      RegExp(r'[A-Z]').hasMatch(this) &&
      RegExp(r'[a-z]').hasMatch(this) &&
      RegExp(r'[0-9]').hasMatch(this) &&
      RegExp(r'[!@#\$%^&*(),.?":{}|<>]').hasMatch(this);

  /// Returns `true` if this string is a palindrome (case-insensitive).
  bool get isPalindrome {
    if (isEmpty) return false;
    final clean = toLowerCase().replaceAll(RegExp(r'[^a-z0-9]'), '');
    return clean == clean.split('').reversed.join();
  }

  // ─── Transformation ──────────────────────────────────────────────────────────

  /// Converts a hex color string to a [Color].
  /// Returns `null` if the string is not a valid hex color.
  Color? toColor() {
    if (!isHexColor) return null;
    var hex = replaceAll('#', '');
    if (hex.length == 3) {
      hex = hex.split('').map((c) => '$c$c').join();
    }
    return Color(int.parse('FF$hex', radix: 16));
  }

  /// Converts this string to a URL-friendly slug.
  ///
  /// ```dart
  /// 'Hello World! 123'.toSlug() // 'hello-world-123'
  /// ```
  String toSlug() {
    if (isEmpty) return '';
    return toLowerCase()
        .replaceAll(RegExp(r'[^\w\s\-]'), '')
        .trim()
        .replaceAll(RegExp(r'[\s_]+'), '-');
  }

  /// Reverses this string.
  ///
  /// ```dart
  /// 'hello'.reverse() // 'olleh'
  /// ```
  String reverse() => split('').reversed.join();

  /// Removes all HTML tags from this string.
  ///
  /// ```dart
  /// '<p>Hello <b>World</b></p>'.stripHtml() // 'Hello World'
  /// ```
  String stripHtml() => replaceAll(RegExp(r'<[^>]*>'), '');

  /// Removes all whitespace (including internal spaces) from this string.
  ///
  /// ```dart
  /// 'hello world'.removeWhitespace() // 'helloworld'
  /// ```
  String removeWhitespace() => replaceAll(RegExp(r'\s+'), '');

  /// Repeats this string [times] times, joined by [separator].
  ///
  /// ```dart
  /// 'ab'.repeat(3, separator: '-') // 'ab-ab-ab'
  /// ```
  String repeat(int times, {String separator = ''}) {
    if (times <= 0) return '';
    return List.filled(times, this).join(separator);
  }

  /// Returns initials from a name string (up to [max] characters).
  ///
  /// ```dart
  /// 'John Doe'.initials()        // 'JD'
  /// 'Mary Jane Watson'.initials(max: 3) // 'MJW'
  /// ```
  String initials({int max = 2}) {
    if (isEmpty) return '';
    final words = trim().split(RegExp(r'\s+'));
    return words
        .take(max)
        .map((w) => w.isNotEmpty ? w[0].toUpperCase() : '')
        .join();
  }

  /// Masks this string, keeping [keepFirst] characters at the start and
  /// [keepLast] at the end, replacing the rest with [maskChar].
  ///
  /// Useful for credit cards, phone numbers, etc.
  ///
  /// ```dart
  /// '4111111111111111'.mask(keepFirst: 4, keepLast: 4) // '4111********1111'
  /// ```
  String mask({int keepFirst = 0, int keepLast = 4, String maskChar = '*'}) {
    if (length <= keepFirst + keepLast) return this;
    final start = substring(0, keepFirst);
    final end = substring(length - keepLast);
    final masked = maskChar * (length - keepFirst - keepLast);
    return '$start$masked$end';
  }

  /// Truncates this string to [maxLength] characters, appending [ellipsis]
  /// if truncation occurs.
  ///
  /// ```dart
  /// 'Hello World'.truncate(7) // 'Hello W…'
  /// ```
  String truncate(int maxLength, {String ellipsis = '…'}) {
    if (length <= maxLength) return this;
    return '${substring(0, maxLength)}$ellipsis';
  }

  /// Returns `true` if this string equals [other], ignoring case.
  bool equalsIgnoreCase(String other) => toLowerCase() == other.toLowerCase();

  /// Returns `true` if this string contains [other], ignoring case.
  bool containsIgnoreCase(String other) =>
      toLowerCase().contains(other.toLowerCase());

  /// Counts the number of non-overlapping occurrences of [substring].
  ///
  /// ```dart
  /// 'banana'.countOccurrences('an') // 2
  /// ```
  int countOccurrences(String substring) {
    if (isEmpty || substring.isEmpty) return 0;
    var count = 0;
    var index = 0;
    while (true) {
      index = indexOf(substring, index);
      if (index == -1) break;
      count++;
      index += substring.length;
    }
    return count;
  }

  /// Returns the number of words in this string.
  int get wordCount {
    if (isEmpty) return 0;
    return trim().split(RegExp(r'\s+')).where((w) => w.isNotEmpty).length;
  }

  /// Returns the number of vowels in this string.
  int get vowelCount =>
      toLowerCase().split('').where((c) => 'aeiou'.contains(c)).length;

  // ─── Substring Utilities ─────────────────────────────────────────────────────

  /// Returns the substring between [start] and [end] delimiters.
  String between(String start, String end) {
    if (isEmpty) return '';
    final si = indexOf(start);
    if (si == -1) return '';
    final ei = indexOf(end, si + start.length);
    if (ei == -1) return '';
    return substring(si + start.length, ei);
  }

  /// Returns the substring before the first occurrence of [pattern].
  String before(String pattern) {
    if (isEmpty) return '';
    final i = indexOf(pattern);
    return i == -1 ? '' : substring(0, i);
  }

  /// Returns the substring after the first occurrence of [pattern].
  String after(String pattern) {
    if (isEmpty) return '';
    final i = indexOf(pattern);
    return i == -1 ? '' : substring(i + pattern.length);
  }

  /// Returns the substring before the last occurrence of [pattern].
  String beforeLast(String pattern) {
    if (isEmpty) return '';
    final i = lastIndexOf(pattern);
    return i == -1 ? '' : substring(0, i);
  }

  /// Returns the substring after the last occurrence of [pattern].
  String afterLast(String pattern) {
    if (isEmpty) return '';
    final i = lastIndexOf(pattern);
    return i == -1 ? '' : substring(i + pattern.length);
  }

  // ─── Prefix / Suffix ─────────────────────────────────────────────────────────

  /// Removes [prefix] from the start of this string if present.
  String removePrefix(String prefix) =>
      startsWith(prefix) ? substring(prefix.length) : this;

  /// Removes [suffix] from the end of this string if present.
  String removeSuffix(String suffix) =>
      endsWith(suffix) ? substring(0, length - suffix.length) : this;

  /// Prepends [other] to this string.
  String prepend(String other) => '$other$this';

  /// Appends [other] to this string.
  String append(String other) => '$this$other';

  // ─── Drop ────────────────────────────────────────────────────────────────────

  /// Drops the last [n] characters. Returns empty string if [n] >= length.
  String dropRight(int n) {
    if (n <= 0) return this;
    if (n >= length) return '';
    return substring(0, length - n);
  }

  /// Drops the first [n] characters. Returns empty string if [n] >= length.
  String dropLeft(int n) {
    if (n <= 0) return this;
    if (n >= length) return '';
    return substring(n);
  }

  /// Drops characters from the left while [condition] is true.
  String dropLeftWhile(bool Function(String char) condition) {
    var i = 0;
    while (i < length && condition(this[i])) {
      i++;
    }
    return substring(i);
  }

  /// Drops characters from the right while [condition] is true.
  String dropRightWhile(bool Function(String char) condition) {
    var i = length - 1;
    while (i >= 0 && condition(this[i])) {
      i--;
    }
    return substring(0, i + 1);
  }

  // ─── Replace Utilities ───────────────────────────────────────────────────────

  /// Replaces everything after the first occurrence of [pattern].
  String replaceAfterFirst(String pattern, String replacement) {
    final i = indexOf(pattern);
    if (i == -1) return this;
    return substring(0, i + pattern.length) + replacement;
  }

  /// Replaces everything after the last occurrence of [pattern].
  String replaceAfterLast(String pattern, String replacement) {
    final i = lastIndexOf(pattern);
    if (i == -1) return this;
    return substring(0, i + pattern.length) + replacement;
  }

  /// Replaces everything before the first occurrence of [pattern].
  String replaceBeforeFirst(String pattern, String replacement) {
    final i = indexOf(pattern);
    if (i == -1) return this;
    return replacement + substring(i);
  }

  /// Replaces everything before the last occurrence of [pattern].
  String replaceBeforeLast(String pattern, String replacement) {
    final i = lastIndexOf(pattern);
    if (i == -1) return this;
    return replacement + substring(i);
  }

  // ─── Formatting ──────────────────────────────────────────────────────────────

  /// Formats this string using positional placeholders `{0}`, `{1}`, etc.
  ///
  /// ```dart
  /// 'Hello {0}, you are {1}!'.format(['World', 'awesome'])
  /// // 'Hello World, you are awesome!'
  /// ```
  String format(List<Object> args) {
    return replaceAllMapped(RegExp(r'\{(\d+)\}'), (m) {
      final i = int.parse(m.group(1)!);
      if (i < 0 || i >= args.length) {
        throw ArgumentError(
            'Index $i out of range for args of length ${args.length}');
      }
      return args[i].toString();
    });
  }

  /// Formats this string using named placeholders `{key}`.
  ///
  /// ```dart
  /// 'Hello {name}!'.formatMap({'name': 'World'}) // 'Hello World!'
  /// ```
  String formatMap(Map<String, Object> args) {
    return replaceAllMapped(RegExp(r'\{(\w+)\}'), (m) {
      final key = m.group(1)!;
      if (!args.containsKey(key)) throw ArgumentError('Key "$key" not found');
      return args[key]!.toString();
    });
  }

  // ─── Encoding ────────────────────────────────────────────────────────────────

  /// Encodes this string to a UTF-8 byte list.
  List<int> toBytes() => utf8.encode(this);

  /// Encodes this string to Base64.
  String toBase64() => base64.encode(utf8.encode(this));

  /// Decodes a Base64-encoded string back to a plain string.
  String fromBase64() => utf8.decode(base64.decode(this));

  /// Escapes backslashes and double-quotes.
  String escape() => replaceAll(r'\', r'\\').replaceAll('"', r'\"');

  /// Escapes HTML special characters (`<`, `>`, `&`, `"`, `'`).
  String toHtmlText() => replaceAll('&', '&amp;')
      .replaceAll('<', '&lt;')
      .replaceAll('>', '&gt;')
      .replaceAll('"', '&quot;')
      .replaceAll("'", '&#39;');

  // ─── Inflection ──────────────────────────────────────────────────────────────

  /// Naively pluralizes this string by appending 's'.
  String pluralize() => '${this}s';

  /// Converts this string to a table name (pluralized snake_case).
  String tableize() => pluralize().underscore();

  /// Converts this string to a foreign key name.
  String foreignKey() =>
      '${uncapitalize().replaceAll(RegExp(r'[^a-zA-Z0-9]'), '')}_id';

  /// Converts this string to a constant name (UPPER_SNAKE_CASE).
  String constantize() =>
      toUpperCase().replaceAll(RegExp(r'[^a-zA-Z0-9]'), '_');

  /// Converts this string to a sequence name.
  String sequenceize() => '${underscore()}_seq';

  /// Converts this string to a path name.
  String pathize() => underscore().replaceAll('_', '/');

  /// Converts this string to a variable name (camelCase, no special chars).
  String variablize() => uncapitalize().replaceAll(RegExp(r'[^a-zA-Z0-9]'), '');
}
