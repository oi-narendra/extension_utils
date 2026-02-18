import 'package:flutter_test/flutter_test.dart';
import 'package:extension_utils/map_utils.dart';


void main() {
  group('MapUtils', () {
    // ─── Safe Access ────────────────────────────────────────────────────────
    group('getOrDefault', () {
      test('returns value when key exists',
          () => expect({'a': 1}.getOrDefault('a', 0), 1));
      test('returns default when key absent',
          () => expect({'a': 1}.getOrDefault('b', 0), 0));
    });

    group('getOrPut', () {
      test('returns existing value', () {
        final map = {'a': 1};
        expect(map.getOrPut('a', () => 99), 1);
        expect(map['a'], 1);
      });
      test('computes and stores missing value', () {
        final map = <String, int>{};
        expect(map.getOrPut('a', () => 42), 42);
        expect(map['a'], 42);
      });
    });

    // ─── Filtering ──────────────────────────────────────────────────────────
    group('filter', () {
      test(
          'filters by predicate',
          () => expect({'a': 1, 'b': 2, 'c': 3}.filter((k, v) => v > 1),
              {'b': 2, 'c': 3}));
    });

    group('reject', () {
      test(
          'rejects by predicate',
          () => expect(
              {'a': 1, 'b': 2, 'c': 3}.reject((k, v) => v > 1), {'a': 1}));
    });

    group('filterKeys', () {
      test(
          'keeps only specified keys',
          () => expect({'a': 1, 'b': 2, 'c': 3}.filterKeys(['a', 'c']),
              {'a': 1, 'c': 3}));
    });

    group('rejectKeys', () {
      test(
          'removes specified keys',
          () => expect(
              {'a': 1, 'b': 2, 'c': 3}.rejectKeys(['b']), {'a': 1, 'c': 3}));
    });

    group('filterNull', () {
      test(
          'removes null values',
          () => expect(
              {'a': 1, 'b': null, 'c': 3}.filterNull(), {'a': 1, 'c': 3}));
    });

    group('filterEmpty', () {
      test(
          'removes null and empty string values',
          () => expect({'a': 'hello', 'b': '', 'c': null}.filterEmpty(),
              {'a': 'hello'}));
    });

    // ─── Transformation ─────────────────────────────────────────────────────
    group('mapKeys', () {
      test(
          'transforms keys',
          () => expect({'a': 1, 'b': 2}.mapKeys((k) => k.toUpperCase()),
              {'A': 1, 'B': 2}));
    });

    group('mapValues', () {
      test(
          'transforms values',
          () => expect(
              {'a': 1, 'b': 2}.mapValues((v) => v * 2), {'a': 2, 'b': 4}));
    });

    group('invertMap', () {
      test('swaps keys and values',
          () => expect({'a': 1, 'b': 2}.invertMap(), {1: 'a', 2: 'b'}));
    });

    group('mergeWith', () {
      test(
          'merges maps, other wins by default',
          () => expect({'a': 1, 'b': 2}.mergeWith({'b': 99, 'c': 3}),
              {'a': 1, 'b': 99, 'c': 3}));
      test('with custom resolve', () {
        final result = {'a': 1, 'b': 2}.mergeWith(
          {'b': 99},
          resolve: (existing, incoming) => existing + incoming,
        );
        expect(result['b'], 101);
      });
    });

    group('uniqueValues', () {
      test('removes duplicate values', () {
        final result = {'a': 1, 'b': 2, 'c': 1}.uniqueValues();
        expect(result.values.toSet().length, result.length);
      });
    });

    // ─── Key/Value Casing ───────────────────────────────────────────────────
    group('camelCaseKeys', () {
      test('converts keys to camelCase',
          () => expect({'hello_world': 1}.camelCaseKeys(), {'helloWorld': 1}));
    });

    group('snakeCaseKeys', () {
      test('converts keys to snake_case',
          () => expect({'helloWorld': 1}.snakeCaseKeys(), {'hello_world': 1}));
    });

    // ─── Partition ──────────────────────────────────────────────────────────
    group('partition', () {
      test('splits map by predicate', () {
        final result = {'a': 1, 'b': 2, 'c': 3}.partition((k, v) => v.isEven);
        expect(result.first, {'b': 2});
        expect(result.second, {'a': 1, 'c': 3});
      });
    });

    // ─── Mutation ───────────────────────────────────────────────────────────
    group('shift', () {
      test('removes and returns first entry', () {
        final map = {'a': 1, 'b': 2};
        final entry = map.shift();
        expect(entry.key, 'a');
        expect(map.containsKey('a'), isFalse);
      });
    });

    group('contains', () {
      test('true when key+value match',
          () => expect({'a': 1}.contains('a', 1), isTrue));
      test('false when value differs',
          () => expect({'a': 1}.contains('a', 2), isFalse));
    });

    group('removeExact', () {
      test('removes when key+value match', () {
        final map = {'a': 1, 'b': 2};
        expect(map.removeExact(key: 'a', value: 1), isTrue);
        expect(map.containsKey('a'), isFalse);
      });
      test('does not remove when value differs', () {
        final map = {'a': 1};
        expect(map.removeExact(key: 'a', value: 99), isFalse);
        expect(map.containsKey('a'), isTrue);
      });
    });

    // ─── Serialization ──────────────────────────────────────────────────────
    group('toQueryString', () {
      test('converts to query string', () {
        final result = {'page': '1', 'q': 'hello world'}.toQueryString();
        expect(result, contains('page=1'));
        expect(result, contains('q=hello+world'));
      });
    });

    group('flatten', () {
      test('flattens nested map', () {
        final result = {
          'a': {
            'b': {'c': 1}
          }
        }.flatten();
        expect(result, {'a.b.c': 1});
      });
      test('flat map unchanged', () {
        final result = {'a': 1, 'b': 2}.flatten();
        expect(result, {'a': 1, 'b': 2});
      });
    });

    group('deepGet', () {
      test('gets nested value', () {
        final map = {
          'user': {
            'address': {'city': 'NY'}
          }
        };
        expect(map.deepGet(['user', 'address', 'city']), 'NY');
      });
      test('returns null for missing path', () {
        final map = {
          'user': {'name': 'John'}
        };
        expect(map.deepGet(['user', 'address', 'city']), isNull);
      });
    });
  });
}
