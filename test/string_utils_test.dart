import 'package:flutter_test/flutter_test.dart';
import 'package:extension_utils/string_utils.dart';

void main() {
  group('StringUtils', () {
    // ─── Case Conversion ────────────────────────────────────────────────────
    group('capitalize', () {
      test('capitalizes first letter',
          () => expect('hello'.capitalize(), 'Hello'));
      test('empty string', () => expect(''.capitalize(), ''));
      test('already capitalized', () => expect('Hello'.capitalize(), 'Hello'));
      test('single char', () => expect('a'.capitalize(), 'A'));
    });

    group('uncapitalize', () {
      test('lowercases first letter',
          () => expect('Hello'.uncapitalize(), 'hello'));
      test('empty string', () => expect(''.uncapitalize(), ''));
    });

    group('titleCase', () {
      test('capitalizes each word',
          () => expect('hello world'.titleCase(), 'Hello World'));
      test('empty string', () => expect(''.titleCase(), ''));
      test('single word', () => expect('hello'.titleCase(), 'Hello'));
    });

    group('toCamelCase', () {
      test('snake_case to camelCase',
          () => expect('hello_world'.toCamelCase(), 'helloWorld'));
      test('spaces to camelCase',
          () => expect('hello world'.toCamelCase(), 'helloWorld'));
      test('PascalCase to camelCase',
          () => expect('HelloWorld'.toCamelCase(), 'helloworld'));
      test('empty string', () => expect(''.toCamelCase(), ''));
    });

    group('toPascalCase', () {
      test('snake_case to PascalCase',
          () => expect('hello_world'.toPascalCase(), 'HelloWorld'));
      test('spaces to PascalCase',
          () => expect('hello world'.toPascalCase(), 'HelloWorld'));
      test('empty string', () => expect(''.toPascalCase(), ''));
    });

    group('toSnakeCase', () {
      test('camelCase to snake_case',
          () => expect('helloWorld'.toSnakeCase(), 'hello_world'));
      test('spaces to snake_case',
          () => expect('hello world'.toSnakeCase(), 'hello_world'));
      test('empty string', () => expect(''.toSnakeCase(), ''));
    });

    group('toKebabCase', () {
      test('camelCase to kebab-case',
          () => expect('helloWorld'.toKebabCase(), 'hello-world'));
      test('empty string', () => expect(''.toKebabCase(), ''));
    });

    group('toDotCase', () {
      test('camelCase to dot.case',
          () => expect('helloWorld'.toDotCase(), 'hello.world'));
    });

    // ─── Validation ─────────────────────────────────────────────────────────
    group('isEmail', () {
      test('valid email', () => expect('user@example.com'.isEmail, isTrue));
      test('invalid email - no @',
          () => expect('userexample.com'.isEmail, isFalse));
      test('invalid email - no domain', () => expect('user@'.isEmail, isFalse));
      test('empty string', () => expect(''.isEmail, isFalse));
    });

    group('isDigits', () {
      test('all digits', () => expect('12345'.isDigits, isTrue));
      test('has letters', () => expect('123a5'.isDigits, isFalse));
      test('empty string', () => expect(''.isDigits, isFalse));
    });

    group('isAlpha', () {
      test('all alpha', () => expect('hello'.isAlpha, isTrue));
      test('has digits', () => expect('hello1'.isAlpha, isFalse));
      test('empty string', () => expect(''.isAlpha, isFalse));
    });

    group('isAlphanumeric', () {
      test('alphanumeric', () => expect('hello123'.isAlphanumeric, isTrue));
      test('has special chars', () => expect('hello!'.isAlphanumeric, isFalse));
    });

    group('isUrl', () {
      test(
          'valid https URL', () => expect('https://example.com'.isUrl, isTrue));
      test('valid http URL',
          () => expect('http://example.com/path?q=1'.isUrl, isTrue));
      test('no protocol', () => expect('example.com'.isUrl, isFalse));
      test('empty string', () => expect(''.isUrl, isFalse));
    });

    group('isPhoneNumber', () {
      test(
          'valid phone', () => expect('+1 800 555 1234'.isPhoneNumber, isTrue));
      test('E.164 format', () => expect('+61412345678'.isPhoneNumber, isTrue));
      test('too short', () => expect('123'.isPhoneNumber, isFalse));
    });

    group('isStrongPassword', () {
      test('strong password',
          () => expect('Passw0rd!'.isStrongPassword, isTrue));
      test('no uppercase', () => expect('passw0rd!'.isStrongPassword, isFalse));
      test('no special char',
          () => expect('Passw0rd'.isStrongPassword, isFalse));
      test('too short', () => expect('Pa1!'.isStrongPassword, isFalse));
    });

    group('isIPv4', () {
      test('valid IPv4', () => expect('192.168.1.1'.isIPv4, isTrue));
      test('invalid IPv4', () => expect('999.999.999.999'.isIPv4, isFalse));
      test('not an IP', () => expect('hello'.isIPv4, isFalse));
    });

    group('isHexColor', () {
      test('6-digit hex', () => expect('#FF0000'.isHexColor, isTrue));
      test('3-digit hex', () => expect('#F00'.isHexColor, isTrue));
      test('no hash', () => expect('FF0000'.isHexColor, isTrue));
      test('invalid', () => expect('#GGGGGG'.isHexColor, isFalse));
    });

    group('isPalindrome', () {
      test('palindrome', () => expect('racecar'.isPalindrome, isTrue));
      test('palindrome with spaces',
          () => expect('A man a plan a canal Panama'.isPalindrome, isTrue));
      test('not palindrome', () => expect('hello'.isPalindrome, isFalse));
      test('empty string', () => expect(''.isPalindrome, isFalse));
    });

    // ─── Transformation ─────────────────────────────────────────────────────
    group('toColor', () {
      test(
          'valid hex color',
          () => expect(
              ('#FF0000'.toColor()!.r * 255).round().clamp(0, 255), 255));
      test('3-digit hex',
          () => expect(('#F00'.toColor()!.r * 255).round().clamp(0, 255), 255));
      test('invalid hex', () => expect('notacolor'.toColor(), isNull));
    });

    group('toSlug', () {
      test('converts to slug',
          () => expect('Hello World! 123'.toSlug(), 'hello-world-123'));
      test('empty string', () => expect(''.toSlug(), ''));
    });

    group('reverse', () {
      test('reverses string', () => expect('hello'.reverse(), 'olleh'));
      test('empty string', () => expect(''.reverse(), ''));
    });

    group('stripHtml', () {
      test('removes HTML tags',
          () => expect('<p>Hello <b>World</b></p>'.stripHtml(), 'Hello World'));
      test('no tags', () => expect('Hello'.stripHtml(), 'Hello'));
    });

    group('initials', () {
      test('two words', () => expect('John Doe'.initials(), 'JD'));
      test('three words, max 2',
          () => expect('Mary Jane Watson'.initials(), 'MJ'));
      test('three words, max 3',
          () => expect('Mary Jane Watson'.initials(max: 3), 'MJW'));
      test('single word', () => expect('John'.initials(), 'J'));
    });

    group('mask', () {
      test(
          'masks middle',
          () => expect(
              '4111111111111111'.mask(keepFirst: 4), '4111********1111'));
      test('short string',
          () => expect('1234'.mask(keepFirst: 2, keepLast: 2), '1234'));
    });

    group('truncate', () {
      test('truncates long string',
          () => expect('Hello World'.truncate(5), 'Hello…'));
      test('short string unchanged', () => expect('Hi'.truncate(10), 'Hi'));
      test('custom ellipsis',
          () => expect('Hello World'.truncate(5, ellipsis: '...'), 'Hello...'));
    });

    group('equalsIgnoreCase', () {
      test(
          'same case', () => expect('Hello'.equalsIgnoreCase('Hello'), isTrue));
      test('different case',
          () => expect('HELLO'.equalsIgnoreCase('hello'), isTrue));
      test('different strings',
          () => expect('hello'.equalsIgnoreCase('world'), isFalse));
    });

    group('countOccurrences', () {
      test('counts occurrences',
          () => expect('banana'.countOccurrences('an'), 2));
      test('no occurrences', () => expect('hello'.countOccurrences('xyz'), 0));
      test('empty substring', () => expect('hello'.countOccurrences(''), 0));
    });

    group('repeat', () {
      test('repeats string', () => expect('ab'.repeat(3), 'ababab'));
      test('with separator',
          () => expect('ab'.repeat(3, separator: '-'), 'ab-ab-ab'));
      test('zero times', () => expect('ab'.repeat(0), ''));
    });

    group('wordCount', () {
      test('counts words', () => expect('hello world foo'.wordCount, 3));
      test('empty string', () => expect(''.wordCount, 0));
      test('extra spaces', () => expect('  hello   world  '.wordCount, 2));
    });

    group('between / before / after', () {
      test('between',
          () => expect('hello [world] foo'.between('[', ']'), 'world'));
      test('before', () => expect('hello world'.before(' '), 'hello'));
      test('after', () => expect('hello world'.after(' '), 'world'));
      test('beforeLast', () => expect('a/b/c'.beforeLast('/'), 'a/b'));
      test('afterLast', () => expect('a/b/c'.afterLast('/'), 'c'));
    });

    group('dropLeft / dropRight', () {
      test('dropLeft', () => expect('hello'.dropLeft(2), 'llo'));
      test('dropRight', () => expect('hello'.dropRight(2), 'hel'));
      test('dropLeft more than length', () => expect('hello'.dropLeft(10), ''));
      test('dropRight more than length',
          () => expect('hello'.dropRight(10), ''));
    });

    group('removePrefix / removeSuffix', () {
      test('removePrefix',
          () => expect('hello world'.removePrefix('hello '), 'world'));
      test('removeSuffix',
          () => expect('hello world'.removeSuffix(' world'), 'hello'));
      test('prefix not present',
          () => expect('hello'.removePrefix('xyz'), 'hello'));
    });

    group('format / formatMap', () {
      test(
          'format with positional args',
          () => expect('Hello {0}, you are {1}!'.format(['World', 'awesome']),
              'Hello World, you are awesome!'));
      test(
          'formatMap with named args',
          () => expect(
              'Hello {name}!'.formatMap({'name': 'World'}), 'Hello World!'));
    });

    group('toBase64 / fromBase64', () {
      test('roundtrip', () => expect('hello'.toBase64().fromBase64(), 'hello'));
    });

    group('toHtmlText', () {
      test(
          'escapes HTML',
          () => expect('<b>Hello & "World"</b>'.toHtmlText(),
              '&lt;b&gt;Hello &amp; &quot;World&quot;&lt;/b&gt;'));
    });
  });
}
