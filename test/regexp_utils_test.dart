import 'package:flutter_test/flutter_test.dart';
import 'package:extension_utils/regexp_utils.dart';

void main() {
  group('RegExpPatterns', () {
    group('email', () {
      test('valid emails match', () {
        expect(RegExpPatterns.email.hasMatch('user@example.com'), isTrue);
        expect(RegExpPatterns.email.hasMatch('user.name+tag@sub.domain.io'),
            isTrue);
      });
      test('invalid emails do not match', () {
        expect(RegExpPatterns.email.hasMatch('not-an-email'), isFalse);
        expect(RegExpPatterns.email.hasMatch('@domain.com'), isFalse);
      });
    });

    group('url', () {
      test('valid URLs match', () {
        expect(RegExpPatterns.url.hasMatch('https://flutter.dev'), isTrue);
        expect(
            RegExpPatterns.url.hasMatch('http://example.com/path?q=1'), isTrue);
      });
      test('invalid URLs do not match', () {
        expect(RegExpPatterns.url.hasMatch('ftp://example.com'), isFalse);
        expect(RegExpPatterns.url.hasMatch('not a url'), isFalse);
      });
    });

    group('uuid', () {
      test('valid UUID v4 matches', () {
        expect(
          RegExpPatterns.uuid.hasMatch('550e8400-e29b-41d4-a716-446655440000'),
          isTrue,
        );
      });
      test('invalid UUID does not match', () {
        expect(RegExpPatterns.uuid.hasMatch('not-a-uuid'), isFalse);
      });
    });

    group('hexColor', () {
      test('valid hex colors match', () {
        expect(RegExpPatterns.hexColor.hasMatch('#FF0000'), isTrue);
        expect(RegExpPatterns.hexColor.hasMatch('#FFF'), isTrue);
        expect(RegExpPatterns.hexColor.hasMatch('FF0000'), isTrue);
      });
      test('invalid hex colors do not match', () {
        expect(RegExpPatterns.hexColor.hasMatch('#GGGGGG'), isFalse);
        expect(RegExpPatterns.hexColor.hasMatch('#12345'), isFalse);
      });
    });

    group('ipv4', () {
      test('valid IPv4 matches', () {
        expect(RegExpPatterns.ipv4.hasMatch('192.168.1.1'), isTrue);
        expect(RegExpPatterns.ipv4.hasMatch('255.255.255.0'), isTrue);
      });
      test('invalid IPv4 does not match', () {
        expect(RegExpPatterns.ipv4.hasMatch('999.0.0.1'), isFalse);
        expect(RegExpPatterns.ipv4.hasMatch('192.168.1'), isFalse);
      });
    });

    group('digits', () {
      test('only digits match',
          () => expect(RegExpPatterns.digits.hasMatch('12345'), isTrue));
      test('mixed does not match',
          () => expect(RegExpPatterns.digits.hasMatch('123a5'), isFalse));
    });

    group('alpha', () {
      test('only letters match',
          () => expect(RegExpPatterns.alpha.hasMatch('Hello'), isTrue));
      test('digits do not match',
          () => expect(RegExpPatterns.alpha.hasMatch('Hello1'), isFalse));
    });

    group('alphanumeric', () {
      test(
          'letters and digits match',
          () =>
              expect(RegExpPatterns.alphanumeric.hasMatch('Hello123'), isTrue));
      test(
          'special chars do not match',
          () =>
              expect(RegExpPatterns.alphanumeric.hasMatch('Hello!'), isFalse));
    });

    group('strongPassword', () {
      test('strong password matches', () {
        expect(RegExpPatterns.strongPassword.hasMatch('P@ssw0rd!'), isTrue);
      });
      test('weak password does not match', () {
        expect(RegExpPatterns.strongPassword.hasMatch('password'), isFalse);
        expect(RegExpPatterns.strongPassword.hasMatch('short1A!'), isTrue);
        expect(
            RegExpPatterns.strongPassword.hasMatch('nouppercase1!'), isFalse);
      });
    });

    group('slug', () {
      test('valid slugs match', () {
        expect(RegExpPatterns.slug.hasMatch('hello-world'), isTrue);
        expect(RegExpPatterns.slug.hasMatch('flutter-3-dart'), isTrue);
      });
      test('invalid slugs do not match', () {
        expect(RegExpPatterns.slug.hasMatch('Hello World'), isFalse);
        expect(RegExpPatterns.slug.hasMatch('hello--world'), isFalse);
      });
    });

    group('semver', () {
      test('valid semver matches', () {
        expect(RegExpPatterns.semver.hasMatch('1.0.0'), isTrue);
        expect(RegExpPatterns.semver.hasMatch('2.3.4-beta.1'), isTrue);
        expect(RegExpPatterns.semver.hasMatch('1.0.0+build.1'), isTrue);
      });
      test('invalid semver does not match', () {
        expect(RegExpPatterns.semver.hasMatch('1.0'), isFalse);
        expect(RegExpPatterns.semver.hasMatch('v1.0.0'), isFalse);
      });
    });
  });
}
