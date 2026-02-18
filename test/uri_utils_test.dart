import 'package:flutter_test/flutter_test.dart';
import 'package:extension_utils/uri_utils.dart';

void main() {
  group('UriUtils', () {
    group('appendPath', () {
      test('appends segment to path', () {
        final uri = Uri.parse('https://api.example.com/v1').appendPath('users');
        expect(uri.toString(), 'https://api.example.com/v1/users');
      });
      test('handles trailing slash on base', () {
        final uri =
            Uri.parse('https://api.example.com/v1/').appendPath('users');
        expect(uri.toString(), 'https://api.example.com/v1/users');
      });
      test('handles leading slash on segment', () {
        final uri =
            Uri.parse('https://api.example.com/v1').appendPath('/users');
        expect(uri.toString(), 'https://api.example.com/v1/users');
      });
    });

    group('withQueryParam', () {
      test('adds new query param', () {
        final uri =
            Uri.parse('https://example.com').withQueryParam('q', 'dart');
        expect(uri.queryParameters['q'], 'dart');
      });
      test('replaces existing param', () {
        final uri =
            Uri.parse('https://example.com?page=1').withQueryParam('page', '2');
        expect(uri.queryParameters['page'], '2');
      });
    });

    group('withQueryParams', () {
      test('merges multiple params', () {
        final uri = Uri.parse('https://example.com?a=1')
            .withQueryParams({'b': '2', 'c': '3'});
        expect(uri.queryParameters, containsPair('a', '1'));
        expect(uri.queryParameters, containsPair('b', '2'));
        expect(uri.queryParameters, containsPair('c', '3'));
      });
    });

    group('removeQueryParam', () {
      test('removes existing param', () {
        final uri = Uri.parse('https://example.com?page=1&q=dart')
            .removeQueryParam('q');
        expect(uri.queryParameters.containsKey('q'), isFalse);
        expect(uri.queryParameters['page'], '1');
      });
    });

    group('isSecure', () {
      test('https is secure',
          () => expect(Uri.parse('https://example.com').isSecure, isTrue));
      test('http is not secure',
          () => expect(Uri.parse('http://example.com').isSecure, isFalse));
    });

    group('hasQueryParams', () {
      test('true when params exist', () {
        expect(Uri.parse('https://example.com?q=1').hasQueryParams, isTrue);
      });
      test('false when no params', () {
        expect(Uri.parse('https://example.com').hasQueryParams, isFalse);
      });
    });

    group('isAbsolute', () {
      test('absolute URI',
          () => expect(Uri.parse('https://example.com').isAbsolute, isTrue));
      test('relative URI',
          () => expect(Uri.parse('/path/to/page').isAbsolute, isFalse));
    });
  });
}
