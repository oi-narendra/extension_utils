library string_utilities;

import 'dart:convert';

import 'package:flutter/material.dart';

extension StringUtilities on String? {
  /// Returns a string with the first character in upper case.
  String capitalize() {
    if (this == null) {
      throw ArgumentError('string: $this');
    }
    if (this!.isEmpty) {
      return '';
    }
    return '${this![0].toUpperCase()}${this?.substring(1)}';
  }

  /// Returns a string with the first character in lower case.
  String uncapitalize() {
    if (this == null) {
      throw ArgumentError('string: $this');
    }
    if (this!.isEmpty) {
      return '';
    }
    return '${this![0].toLowerCase()}${this?.substring(1)}';
  }

  /// Capitalizes the first character of each word in a string.
  String titleCase() {
    if (this == null) {
      throw ArgumentError('string: $this');
    }
    if (this!.isEmpty) {
      return '';
    }
    return this!.split(' ').map((word) => word.capitalize()).join(' ');
  }

  /// Converts a camelized string into all lower case separated by underscores.
  String underscore() {
    if (this == null) {
      throw ArgumentError('string: $this');
    }
    if (this!.isEmpty) {
      return '';
    }
    return this!
        .replaceAllMapped(RegExp(r'([A-Z])'), (match) => '_${match[1]}')
        .toLowerCase();
  }

  /// Converts a string into a variable name.
  String variablize() {
    if (this == null) {
      throw ArgumentError('string: $this');
    }
    if (this!.isEmpty) {
      return '';
    }
    return this!.uncapitalize().replaceAll(RegExp(r'[^a-zA-Z0-9]'), '');
  }

  /// Converts a string into a constant name.
  String constantize() {
    if (this == null) {
      throw ArgumentError('string: $this');
    }
    if (this!.isEmpty) {
      return '';
    }
    return this!.toUpperCase().replaceAll(RegExp(r'[^a-zA-Z0-9]'), '_');
  }

  /// Converts a string into a human-readable form.
  String humanize() {
    if (this == null) {
      throw ArgumentError('string: $this');
    }
    if (this!.isEmpty) {
      return '';
    }
    return this!
        .replaceAllMapped(RegExp(r'([A-Z])'), (match) => ' ${match[1]}')
        .trim()
        .toLowerCase();
  }

  /// Convert a string into plural form.
  String pluralize() {
    if (this == null) {
      throw ArgumentError('string: $this');
    }
    if (this!.isEmpty) {
      return '';
    }
    return '${this!}s';
  }

  /// Converts a string into a table name.
  String tableize() {
    if (this == null) {
      throw ArgumentError('string: $this');
    }
    if (this!.isEmpty) {
      return '';
    }
    return this!.pluralize().underscore();
  }

  /// Converts a string into a foreign key name.
  String foreignKey() {
    if (this == null) {
      throw ArgumentError('string: $this');
    }
    if (this!.isEmpty) {
      return '';
    }
    return '${this!.variablize()}_id';
  }

  /// Converts a string into a sequence name.
  String sequenceize() {
    if (this == null) {
      throw ArgumentError('string: $this');
    }
    if (this!.isEmpty) {
      return '';
    }
    return '${this!.underscore()}_seq';
  }

  /// Converts a string into a path name.
  String pathize() {
    if (this == null) {
      throw ArgumentError('string: $this');
    }
    if (this!.isEmpty) {
      return '';
    }
    return this!.underscore().replaceAll('_', '/');
  }

  /// Check if a string is a palindrome.
  bool isPalindrome() {
    if (this == null) {
      throw ArgumentError('string: $this');
    }
    if (this!.isEmpty) {
      return false;
    }
    return this!.toLowerCase() == this!.toLowerCase().split('').reversed.join();
  }

  /// Check if a string is a valid email address.
  bool isEmail() {
    if (this == null) {
      throw ArgumentError('string: $this');
    }
    if (this!.isEmpty) {
      return false;
    }
    return RegExp(r'^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$')
        .hasMatch(this!);
  }

  /// Check if a string contains only digits.
  bool isDigits() {
    if (this == null) {
      throw ArgumentError('string: $this');
    }
    if (this!.isEmpty) {
      return false;
    }
    return RegExp(r'^[0-9]+$').hasMatch(this!);
  }

  /// Check if a string is a valid hexadecimal color.
  bool isHexColor() {
    if (this == null) {
      throw ArgumentError('string: $this');
    }
    if (this!.isEmpty) {
      return false;
    }
    return RegExp(r'^#?([a-fA-F0-9]{6}|[a-fA-F0-9]{3})$').hasMatch(this!);
  }

  /// Convert to color from hex string.
  /// Returns null if the string is not a valid hex color.

  Color? toColor() {
    if (this == null) {
      throw ArgumentError('string: $this');
    }
    if (this!.isEmpty) {
      return null;
    }
    if (!this!.isHexColor()) {
      return null;
    }
    var hexColor = this!.replaceAll('#', '');
    if (hexColor.length == 3) {
      hexColor = hexColor.split('').map((e) => '$e$e').join();
    }
    return Color(int.parse('FF$hexColor', radix: 16));
  }

  /// Get the number of words in a string.
  int wordCount() {
    if (this == null) {
      throw ArgumentError('string: $this');
    }
    if (this!.isEmpty) {
      return 0;
    }
    return this!.split(RegExp(r'\s+')).length;
  }

  /// Get the number of characters in a string.
  int charCount() {
    if (this == null) {
      throw ArgumentError('string: $this');
    }
    if (this!.isEmpty) {
      return 0;
    }
    return this!.length;
  }

  /// Get the number of vowels in a string.
  int vowelCount() {
    if (this == null) {
      throw ArgumentError('string: $this');
    }
    if (this!.isEmpty) {
      return 0;
    }
    return this!.toLowerCase().split(RegExp(r'[aeiou]')).length - 1;
  }

  /// Get the number of consonants in a string.
  int consonantCount() {
    if (this == null) {
      throw ArgumentError('string: $this');
    }
    if (this!.isEmpty) {
      return 0;
    }
    return this!.toLowerCase().split(RegExp(r'[^aeiou]')).length - 1;
  }

  /// Get the number of syllables in a string.
  int syllableCount() {
    if (this == null) {
      throw ArgumentError('string: $this');
    }
    if (this!.isEmpty) {
      return 0;
    }
    return this!.toLowerCase().split(RegExp(r'[aeiouy]+')).length;
  }

  /// Get the number of sentences in a string.
  int sentenceCount() {
    if (this == null) {
      throw ArgumentError('string: $this');
    }
    if (this!.isEmpty) {
      return 0;
    }
    return this!.split(RegExp(r'[.!?]+')).length;
  }

  /// Get the substring of a string between two strings.
  String between(String start, String end) {
    if (this == null) {
      throw ArgumentError('string: $this');
    }
    if (this!.isEmpty) {
      return '';
    }
    final startIndex = this!.indexOf(start);
    if (startIndex == -1) {
      return '';
    }
    final endIndex = this!.indexOf(end, startIndex + start.length);
    if (endIndex == -1) {
      return '';
    }
    return this!.substring(startIndex + start.length, endIndex);
  }

  /// Get the substring of a string before a string.
  String before(String string) {
    if (this == null) {
      throw ArgumentError('string: $this');
    }
    if (this!.isEmpty) {
      return '';
    }
    final index = this!.indexOf(string);
    if (index == -1) {
      return '';
    }
    return this!.substring(0, index);
  }

  /// Get the substring of a string after a string.
  String after(String string) {
    if (this == null) {
      throw ArgumentError('string: $this');
    }
    if (this!.isEmpty) {
      return '';
    }
    final index = this!.indexOf(string);
    if (index == -1) {
      return '';
    }
    return this!.substring(index + string.length);
  }

  /// Get the substring of a string before the last occurrence of a string.
  String beforeLast(String string) {
    if (this == null) {
      throw ArgumentError('string: $this');
    }
    if (this!.isEmpty) {
      return '';
    }
    final index = this!.lastIndexOf(string);
    if (index == -1) {
      return '';
    }
    return this!.substring(0, index);
  }

  /// Get the substring of a string after the last occurrence of a string.
  String afterLast(String string) {
    if (this == null) {
      throw ArgumentError('string: $this');
    }
    if (this!.isEmpty) {
      return '';
    }
    final index = this!.lastIndexOf(string);
    if (index == -1) {
      return '';
    }
    return this!.substring(index + string.length);
  }

  /// Get the substring of a string between the first occurrence of two strings.
  String betweenFirst(String start, String end) {
    if (this == null) {
      throw ArgumentError('string: $this');
    }
    if (this!.isEmpty) {
      return '';
    }
    final startIndex = this!.indexOf(start);
    if (startIndex == -1) {
      return '';
    }
    final endIndex = this!.indexOf(end, startIndex + start.length);
    if (endIndex == -1) {
      return '';
    }
    return this!.substring(startIndex + start.length, endIndex);
  }

  /// Get the substring of a string between the last occurrence of two strings.
  String betweenLast(String start, String end) {
    if (this == null) {
      throw ArgumentError('string: $this');
    }
    if (this!.isEmpty) {
      return '';
    }
    final startIndex = this!.lastIndexOf(start);
    if (startIndex == -1) {
      return '';
    }
    final endIndex = this!.lastIndexOf(end, startIndex + start.length);
    if (endIndex == -1) {
      return '';
    }
    return this!.substring(startIndex + start.length, endIndex);
  }

  /// Get the substring of a string before the first occurrence of a string.
  String beforeFirst(String string) {
    if (this == null) {
      throw ArgumentError('string: $this');
    }
    if (this!.isEmpty) {
      return '';
    }
    final index = this!.indexOf(string);
    if (index == -1) {
      return '';
    }
    return this!.substring(0, index);
  }

  /// Get the substring of a string after the first occurrence of a string.
  String afterFirst(String string) {
    if (this == null) {
      throw ArgumentError('string: $this');
    }
    if (this!.isEmpty) {
      return '';
    }
    final index = this!.indexOf(string);
    if (index == -1) {
      return '';
    }
    return this!.substring(index + string.length);
  }

  /// Check if a string starts with a substring.
  bool startsWith(String string) {
    if (this == null) {
      throw ArgumentError('string: $this');
    }
    if (this!.isEmpty) {
      return false;
    }
    return this!.startsWith(string);
  }

  /// Check if a string ends with a substring.
  bool endsWith(String string) {
    if (this == null) {
      throw ArgumentError('string: $this');
    }
    if (this!.isEmpty) {
      return false;
    }
    return this!.endsWith(string);
  }

  /// Check if a string contains a substring.
  bool containsIgnoreCase(String string) {
    if (this == null) {
      throw ArgumentError('string: $this');
    }
    if (this!.isEmpty) {
      return false;
    }
    return this!.toLowerCase().contains(string.toLowerCase());
  }

  /// Drop last n characters from a string.
  String dropRight(int n) {
    if (this == null) {
      throw ArgumentError('string: $this');
    }
    if (this!.isEmpty) {
      return '';
    }
    if (n < 0) {
      throw ArgumentError('n: $n');
    }
    if (n > this!.length) {
      return '';
    }
    return this!.substring(0, this!.length - n);
  }

  /// Drop first n characters from a string.
  String dropLeft(int n) {
    if (this == null) {
      throw ArgumentError('string: $this');
    }
    if (this!.isEmpty) {
      return '';
    }
    if (n < 0) {
      throw ArgumentError('n: $n');
    }
    if (n > this!.length) {
      return '';
    }
    return this!.substring(n);
  }

  /// Drop left while the condition is met.
  String dropLeftWhile(bool Function(String) condition) {
    if (this == null) {
      throw ArgumentError('string: $this');
    }
    if (this!.isEmpty) {
      return '';
    }
    var index = 0;
    while (index < this!.length && condition(this![index])) {
      index++;
    }
    return this!.substring(index);
  }

  /// Drop right while the condition is met.
  String dropRightWhile(bool Function(String) condition) {
    if (this == null) {
      throw ArgumentError('string: $this');
    }
    if (this!.isEmpty) {
      return '';
    }
    var index = this!.length - 1;
    while (index >= 0 && condition(this![index])) {
      index--;
    }
    return this!.substring(0, index + 1);
  }

  /// Remve prefix from a string.
  String removePrefix(String prefix) {
    if (this == null) {
      throw ArgumentError('string: $this');
    }
    if (this!.isEmpty) {
      return '';
    }
    if (this!.startsWith(prefix)) {
      return this!.substring(prefix.length);
    }
    return this!;
  }

  /// Remve suffix from a string.
  String removeSuffix(String suffix) {
    if (this == null) {
      throw ArgumentError('string: $this');
    }
    if (this!.isEmpty) {
      return '';
    }
    if (this!.endsWith(suffix)) {
      return this!.substring(0, this!.length - suffix.length);
    }
    return this!;
  }

  /// Remve prefix and suffix from a string.
  String remove(String string) {
    if (this == null) {
      throw ArgumentError('string: $this');
    }
    if (this!.isEmpty) {
      return '';
    }
    return this!.removePrefix(string).removeSuffix(string);
  }

  /// Replace after the first occurrence of a string.
  String replaceAfterFirst(String string, String replacement) {
    if (this == null) {
      throw ArgumentError('string: $this');
    }
    if (this!.isEmpty) {
      return '';
    }
    final index = this!.indexOf(string);
    if (index == -1) {
      return this!;
    }
    return this!.substring(0, index + string.length) + replacement;
  }

  /// Replace after the last occurrence of a string.
  String replaceAfterLast(String string, String replacement) {
    if (this == null) {
      throw ArgumentError('string: $this');
    }
    if (this!.isEmpty) {
      return '';
    }
    final index = this!.lastIndexOf(string);
    if (index == -1) {
      return this!;
    }
    return this!.substring(0, index + string.length) + replacement;
  }

  /// Replace before the first occurrence of a string.
  String replaceBeforeFirst(String string, String replacement) {
    if (this == null) {
      throw ArgumentError('string: $this');
    }
    if (this!.isEmpty) {
      return '';
    }
    final index = this!.indexOf(string);
    if (index == -1) {
      return this!;
    }
    return replacement + this!.substring(index);
  }

  /// Replace before the last occurrence of a string.
  String replaceBeforeLast(String string, String replacement) {
    if (this == null) {
      throw ArgumentError('string: $this');
    }
    if (this!.isEmpty) {
      return '';
    }
    final index = this!.lastIndexOf(string);
    if (index == -1) {
      return this!;
    }
    return replacement + this!.substring(index);
  }

  /// Replace range of characters.
  String replaceRange(int start, int end, String replacement) {
    if (this == null) {
      throw ArgumentError('string: $this');
    }
    if (this!.isEmpty) {
      return '';
    }
    if (start < 0) {
      throw ArgumentError('start: $start');
    }
    if (end < 0) {
      throw ArgumentError('end: $end');
    }
    if (start > end) {
      throw ArgumentError('start: $start, end: $end');
    }
    if (start > this!.length) {
      throw ArgumentError('start: $start, length: ${this!.length}');
    }
    if (end > this!.length) {
      throw ArgumentError('end: $end, length: ${this!.length}');
    }
    return this!.substring(0, start) + replacement + this!.substring(end);
  }

  /// Convert string to bytes.
  List<int> toBytes() {
    if (this == null) {
      throw ArgumentError('string: $this');
    }
    return utf8.encode(this!);
  }

  /// Prepend a string.
  String prepend(String string) {
    if (this == null) {
      throw ArgumentError('string: $this');
    }
    return string + this!;
  }

  /// Append a string.
  String append(String string) {
    if (this == null) {
      throw ArgumentError('string: $this');
    }
    return this! + string;
  }

  /// Format a string.
  String format(List<Object> args) {
    if (this == null) {
      throw ArgumentError('string: $this');
    }
    return this!.replaceAllMapped(RegExp(r'\{(\d+)\}'), (match) {
      final index = int.parse(match.group(1)!);
      if (index < 0 || index >= args.length) {
        throw ArgumentError('index: $index, length: ${args.length}');
      }
      return args[index].toString();
    });
  }

  /// Format a string.
  String formatMap(Map<String, Object> args) {
    if (this == null) {
      throw ArgumentError('string: $this');
    }
    return this!.replaceAllMapped(RegExp(r'\{(\w+)\}'), (match) {
      final key = match.group(1)!;
      if (!args.containsKey(key)) {
        throw ArgumentError('key: $key');
      }
      return args[key]!.toString();
    });
  }

  /// Convert string to camel case.
  String toCamelCase() {
    if (this == null) {
      throw ArgumentError('string: $this');
    }
    return this!.splitMapJoin(RegExp(r'[_\s]+'),
        onMatch: (match) => match.group(0)!.toUpperCase(),
        onNonMatch: (nonMatch) =>
            nonMatch[0].toUpperCase() + nonMatch.substring(1));
  }

  /// Convert string to pascal case.
  String toPascalCase() {
    if (this == null) {
      throw ArgumentError('string: $this');
    }
    return this!.splitMapJoin(RegExp(r'[_\s]+'),
        onMatch: (match) => match.group(0)!.toUpperCase(),
        onNonMatch: (nonMatch) =>
            nonMatch[0].toUpperCase() + nonMatch.substring(1).toLowerCase());
  }

  /// Convert string to snake case.
  String toSnakeCase() {
    if (this == null) {
      throw ArgumentError('string: $this');
    }
    return this!.splitMapJoin(RegExp(r'[_\s]+'),
        onMatch: (match) => match.group(0)!.toLowerCase(),
        onNonMatch: (nonMatch) =>
            nonMatch[0].toLowerCase() +
            nonMatch.substring(1).replaceAllMapped(RegExp(r'[A-Z]'),
                (match) => '_${match.group(0)!.toLowerCase()}'));
  }

  /// Convert string to kebab case.
  String toKebabCase() {
    if (this == null) {
      throw ArgumentError('string: $this');
    }
    return this!.splitMapJoin(RegExp(r'[_\s]+'),
        onMatch: (match) => match.group(0)!.toLowerCase(),
        onNonMatch: (nonMatch) =>
            nonMatch[0].toLowerCase() +
            nonMatch.substring(1).replaceAllMapped(RegExp(r'[A-Z]'),
                (match) => '-${match.group(0)!.toLowerCase()}'));
  }

  /// Convert string to train case.
  String toTrainCase() {
    if (this == null) {
      throw ArgumentError('string: $this');
    }
    return this!.splitMapJoin(RegExp(r'[_\s]+'),
        onMatch: (match) => match.group(0)!.toUpperCase(),
        onNonMatch: (nonMatch) =>
            nonMatch[0].toUpperCase() +
            nonMatch.substring(1).replaceAllMapped(RegExp(r'[A-Z]'),
                (match) => '-${match.group(0)!.toUpperCase()}'));
  }

  /// Convert string to dot case.
  String toDotCase() {
    if (this == null) {
      throw ArgumentError('string: $this');
    }
    return this!.splitMapJoin(RegExp(r'[_\s]+'),
        onMatch: (match) => match.group(0)!.toLowerCase(),
        onNonMatch: (nonMatch) =>
            nonMatch[0].toLowerCase() +
            nonMatch.substring(1).replaceAllMapped(RegExp(r'[A-Z]'),
                (match) => '.${match.group(0)!.toLowerCase()}'));
  }

  /// Escape a string.
  String escape() {
    if (this == null) {
      throw ArgumentError('string: $this');
    }
    return this!.replaceAllMapped(RegExp(r'([\\"])'), (match) {
      final char = match.group(1)!;
      if (char == r'\') {
        return r'\\';
      } else if (char == '"') {
        return r'\"';
      } else {
        return char;
      }
    });
  }

  /// Convert to HTML Text.
  String toHtmlText() {
    if (this == null) {
      throw ArgumentError('string: $this');
    }
    return this!.replaceAllMapped(RegExp(r'([<>&])'), (match) {
      final char = match.group(1)!;
      if (char == '<') {
        return '&lt;';
      } else if (char == '>') {
        return '&gt;';
      } else if (char == '&') {
        return '&amp;';
      } else {
        return char;
      }
    });
  }

  // Convert to base64.
  String toBase64() {
    if (this == null) {
      throw ArgumentError('string: $this');
    }
    return base64.encode(utf8.encode(this!));
  }
}
