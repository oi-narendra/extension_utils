import 'package:flutter_test/flutter_test.dart';
import 'package:extension_utils/list_utils.dart';
import 'package:extension_utils/model/pair.dart';

void main() {
  group('ListUtils', () {
    // ─── Safe Accessors ─────────────────────────────────────────────────────
    group('second / third / penultimate', () {
      test('second', () => expect([1, 2, 3].second, 2));
      test('second null when too short', () => expect([1].second, isNull));
      test('third', () => expect([1, 2, 3].third, 3));
      test('third null when too short', () => expect([1, 2].third, isNull));
      test('penultimate', () => expect([1, 2, 3, 4].penultimate, 3));
      test('penultimate null when too short',
          () => expect([1].penultimate, isNull));
    });

    // ─── Remove ─────────────────────────────────────────────────────────────
    group('removeFirst', () {
      test('removes first occurrence', () {
        final list = [1, 2, 1, 3];
        list.removeFirst(1);
        expect(list, [2, 1, 3]);
      });
      test('no-op if not found', () {
        final list = [1, 2, 3];
        list.removeFirst(5);
        expect(list, [1, 2, 3]);
      });
    });

    group('removeLast', () {
      test('removes last occurrence', () {
        final list = [1, 2, 1, 3];
        list.removeLastOccurrence(1);
        expect(list, [1, 2, 3]);
      });
    });

    group('removeAll', () {
      test('removes all occurrences', () {
        final list = [1, 2, 1, 3, 1];
        list.removeAll(1);
        expect(list, [2, 3]);
      });
    });

    // ─── Aggregation ────────────────────────────────────────────────────────
    group('sumBy', () {
      test('sums by selector', () => expect([1, 2, 3].sumBy((e) => e), 6));
      test('empty list', () => expect(<int>[].sumBy((e) => e), 0));
    });

    group('averageBy', () {
      test('averages by selector',
          () => expect([1, 2, 3].averageBy((e) => e), 2.0));
      test('empty list', () => expect(<int>[].averageBy((e) => e), 0.0));
    });

    group('average', () {
      test('average of nums', () => expect([1.0, 2.0, 3.0].average, 2.0));
      test('empty list', () => expect(<double>[].average, 0.0));
    });

    group('median', () {
      test('odd count', () => expect([3.0, 1.0, 2.0].median, 2.0));
      test('even count', () => expect([1.0, 2.0, 3.0, 4.0].median, 2.5));
      test('empty list', () => expect(<double>[].median, 0.0));
    });

    group('mode', () {
      test('returns most frequent', () => expect([1, 2, 2, 3].mode, 2));
      test('empty list', () => expect(<int>[].mode, isNull));
    });

    group('frequencies', () {
      test(
          'counts occurrences',
          () => expect(
              ['a', 'b', 'a', 'c'].frequencies(), {'a': 2, 'b': 1, 'c': 1}));
      test('empty list', () => expect(<String>[].frequencies(), {}));
    });

    // ─── Transformation ─────────────────────────────────────────────────────
    group('partition', () {
      test('splits by predicate', () {
        final result = [1, 2, 3, 4, 5].partition((e) => e.isEven);
        expect(result.first, [2, 4]);
        expect(result.second, [1, 3, 5]);
      });
    });

    group('chunk', () {
      test(
          'chunks evenly',
          () => expect([1, 2, 3, 4].chunk(2), [
                [1, 2],
                [3, 4]
              ]));
      test(
          'last chunk smaller',
          () => expect([1, 2, 3, 4, 5].chunk(2), [
                [1, 2],
                [3, 4],
                [5]
              ]));
    });

    group('windowed', () {
      test(
          'sliding window',
          () => expect([1, 2, 3, 4].windowed(2), [
                [1, 2],
                [2, 3],
                [3, 4]
              ]));
      test(
          'with step',
          () => expect([1, 2, 3, 4].windowed(2, step: 2), [
                [1, 2],
                [3, 4]
              ]));
    });

    group('zip', () {
      test('zips two lists', () {
        final result = [1, 2, 3].zip(['a', 'b', 'c']);
        expect(result.map((p) => p.first).toList(), [1, 2, 3]);
        expect(result.map((p) => p.second).toList(), ['a', 'b', 'c']);
      });
      test('stops at shorter list', () {
        final result = [1, 2, 3].zip(['a', 'b']);
        expect(result.length, 2);
      });
    });

    group('toPairs', () {
      test('consecutive pairs', () {
        final result = [1, 2, 3].toPairs();
        expect(result.length, 2);
        expect(result[0], Pair(1, 2));
        expect(result[1], Pair(2, 3));
      });
      test('less than 2 elements', () => expect([1].toPairs(), []));
    });

    group('flatten', () {
      test(
          'flattens nested list',
          () => expect(
              [
                [1, 2],
                [3, 4]
              ].flatten<int>(),
              [1, 2, 3, 4]));
    });

    group('distinctBy', () {
      test('distinct by key', () {
        final result = [1, 2, 3, 4].distinctBy((e) => e.isEven);
        expect(result.length, 2);
      });
    });

    group('sortedBy', () {
      test('sorts ascending',
          () => expect([3, 1, 2].sortedBy((e) => e), [1, 2, 3]));
    });

    group('sortedByDescending', () {
      test('sorts descending',
          () => expect([3, 1, 2].sortedByDescending((e) => e), [3, 2, 1]));
    });

    group('groupBy', () {
      test('groups by key', () {
        final result = [1, 2, 3, 4].groupBy((e) => e.isEven ? 'even' : 'odd');
        expect(result['even'], [2, 4]);
        expect(result['odd'], [1, 3]);
      });
    });

    group('toMap', () {
      test('converts to map', () {
        final result = [1, 2, 3].toMap((e) => e, (e) => e * 2);
        expect(result, {1: 2, 2: 4, 3: 6});
      });
    });

    group('compact', () {
      test('removes nulls and empty strings', () {
        final list = <dynamic>[
          1,
          null,
          '',
          'hello',
          [],
          [1]
        ];
        expect(list.compact(), [
          1,
          'hello',
          [1]
        ]);
      });
    });

    // ─── Reordering ─────────────────────────────────────────────────────────
    group('rotate', () {
      test('rotates left',
          () => expect([1, 2, 3, 4, 5].rotate(2), [3, 4, 5, 1, 2]));
      test('rotate by 0', () => expect([1, 2, 3].rotate(0), [1, 2, 3]));
      test('empty list', () => expect(<int>[].rotate(2), []));
    });

    group('swap', () {
      test('swaps elements', () {
        final list = [1, 2, 3];
        list.swap(0, 2);
        expect(list, [3, 2, 1]);
      });
    });

    group('move', () {
      test('moves element', () {
        final list = [1, 2, 3, 4];
        list.move(0, 3);
        expect(list, [2, 3, 4, 1]);
      });
    });

    // ─── Random ─────────────────────────────────────────────────────────────
    group('random', () {
      test('returns element from list', () {
        final list = [1, 2, 3];
        expect(list, contains(list.random(seed: 42)));
      });
      test('throws on empty list',
          () => expect(() => <int>[].random(), throwsStateError));
    });

    group('sample', () {
      test('returns n elements',
          () => expect([1, 2, 3, 4, 5].sample(3).length, 3));
      test('all elements if n >= length',
          () => expect([1, 2, 3].sample(5).length, 3));
    });

    // ─── String Joining ──────────────────────────────────────────────────────
    group('joinToString', () {
      test('joins with separator',
          () => expect([1, 2, 3].joinToString(', '), '1, 2, 3'));
      test(
          'with prefix and suffix',
          () => expect([1, 2, 3].joinToString(', ', prefix: '[', suffix: ']'),
              '[1, 2, 3]'));
      test(
          'with transform',
          () => expect([1, 2, 3].joinToString(', ', transform: (e) => 'x$e'),
              'x1, x2, x3'));
    });
  });
}
