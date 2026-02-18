import 'package:flutter_test/flutter_test.dart';
import 'package:extension_utils/iterable_utils.dart';

void main() {
  group('IterableUtils', () {
    // ─── Safe Access ────────────────────────────────────────────────────────
    group('firstOrNull / lastOrNull / singleOrNull', () {
      test('firstOrNull on non-empty', () => expect([1, 2, 3].firstOrNull, 1));
      test('firstOrNull on empty', () => expect(<int>[].firstOrNull, isNull));
      test('lastOrNull on non-empty', () => expect([1, 2, 3].lastOrNull, 3));
      test('lastOrNull on empty', () => expect(<int>[].lastOrNull, isNull));
      test('singleOrNull on single', () => expect([42].singleOrNull, 42));
      test('singleOrNull on empty', () => expect(<int>[].singleOrNull, isNull));
      test('singleOrNull on multiple',
          () => expect([1, 2].singleOrNull, isNull));
    });

    // ─── Counting ───────────────────────────────────────────────────────────
    group('count', () {
      test('counts matching elements',
          () => expect([1, 2, 3, 4, 5].count((e) => e.isEven), 2));
      test('empty iterable', () => expect(<int>[].count((e) => e.isEven), 0));
    });

    group('none', () {
      test('none match', () => expect([1, 3, 5].none((e) => e.isEven), isTrue));
      test(
          'some match', () => expect([1, 2, 3].none((e) => e.isEven), isFalse));
      test('empty iterable',
          () => expect(<int>[].none((e) => e.isEven), isTrue));
    });

    // ─── Aggregation ────────────────────────────────────────────────────────
    group('sumBy', () {
      test('sums by selector', () => expect([1, 2, 3].sumBy((e) => e), 6));
      test('empty iterable', () => expect(<int>[].sumBy((e) => e), 0));
    });

    group('averageBy', () {
      test('averages by selector',
          () => expect([1, 2, 3].averageBy((e) => e), 2.0));
      test('empty iterable', () => expect(<int>[].averageBy((e) => e), 0.0));
    });

    group('maxBy / minBy', () {
      test('maxBy', () => expect([3, 1, 4, 1, 5].maxBy((e) => e), 5));
      test('minBy', () => expect([3, 1, 4, 1, 5].minBy((e) => e), 1));
      test('maxBy on empty', () => expect(<int>[].maxBy((e) => e), isNull));
      test('minBy on empty', () => expect(<int>[].minBy((e) => e), isNull));
    });

    // ─── Indexed Iteration ──────────────────────────────────────────────────
    group('forEachIndexed', () {
      test('provides correct indices', () {
        final indices = <int>[];
        [10, 20, 30].forEachIndexed((i, _) => indices.add(i));
        expect(indices, [0, 1, 2]);
      });
    });

    group('mapIndexed', () {
      test(
          'maps with index',
          () => expect([10, 20, 30].mapIndexed((i, e) => '$i:$e').toList(),
              ['0:10', '1:20', '2:30']));
    });

    group('whereIndexed', () {
      test(
          'filters with index',
          () => expect(
              [10, 20, 30, 40].whereIndexed((i, _) => i.isEven).toList(),
              [10, 30]));
    });

    // ─── Transformation ─────────────────────────────────────────────────────
    group('flatMap', () {
      test(
          'maps and flattens',
          () => expect(['hello', 'world'].flatMap((s) => s.split('')).toList(),
              ['h', 'e', 'l', 'l', 'o', 'w', 'o', 'r', 'l', 'd']));
    });

    group('chunked', () {
      test(
          'even chunks',
          () => expect([1, 2, 3, 4].chunked(2).toList(), [
                [1, 2],
                [3, 4]
              ]));
      test(
          'last chunk smaller',
          () => expect([1, 2, 3, 4, 5].chunked(2).toList(), [
                [1, 2],
                [3, 4],
                [5]
              ]));
      test(
          'chunk size > length',
          () => expect([1, 2].chunked(5).toList(), [
                [1, 2]
              ]));
      test('empty iterable', () => expect(<int>[].chunked(2).toList(), []));
    });

    group('distinctBy', () {
      test('distinct by key', () {
        final result = [1, 2, 3, 4].distinctBy((e) => e.isEven).toList();
        expect(result.length, 2);
      });
      test('preserves first occurrence', () {
        final result =
            ['apple', 'ant', 'banana'].distinctBy((s) => s[0]).toList();
        expect(result, ['apple', 'banana']);
      });
    });

    // ─── Grouping / Indexing ─────────────────────────────────────────────────
    group('groupBy', () {
      test('groups by key', () {
        final result = [1, 2, 3, 4].groupBy((e) => e.isEven ? 'even' : 'odd');
        expect(result['even'], [2, 4]);
        expect(result['odd'], [1, 3]);
      });
    });

    group('associateBy', () {
      test('indexes by key', () {
        final result = ['a', 'bb', 'ccc'].associateBy((s) => s.length);
        expect(result[1], 'a');
        expect(result[2], 'bb');
        expect(result[3], 'ccc');
      });
    });

    group('associateWith', () {
      test('maps to values', () {
        final result = [1, 2, 3].associateWith((e) => e * e);
        expect(result, {1: 1, 2: 4, 3: 9});
      });
    });
  });
}
