/// Extensions on [Iterable] for real-world utility operations.
///
/// These work on any [Iterable] — [List], [Set], generator sequences, etc.
extension IterableUtils<T> on Iterable<T> {
  // ─── Safe Access ─────────────────────────────────────────────────────────────

  /// Returns the first element, or `null` if the iterable is empty.
  T? get firstOrNull => isEmpty ? null : first;

  /// Returns the last element, or `null` if the iterable is empty.
  T? get lastOrNull => isEmpty ? null : last;

  /// Returns the single element, or `null` if empty or has more than one.
  T? get singleOrNull {
    final it = iterator;
    if (!it.moveNext()) return null;
    final result = it.current;
    if (it.moveNext()) return null;
    return result;
  }

  // ─── Counting ────────────────────────────────────────────────────────────────

  /// Returns the number of elements satisfying [predicate].
  int count(bool Function(T) predicate) =>
      fold(0, (acc, e) => predicate(e) ? acc + 1 : acc);

  /// Returns `true` if no elements satisfy [predicate].
  bool none(bool Function(T) predicate) => !any(predicate);

  // ─── Aggregation ─────────────────────────────────────────────────────────────

  /// Returns the sum of [f] applied to each element.
  num sumBy(num Function(T) f) => fold<num>(0, (acc, e) => acc + f(e));

  /// Returns the average of [f] applied to each element. Returns `0` if empty.
  double averageBy(num Function(T) f) => isEmpty ? 0 : sumBy(f) / length;

  /// Returns the element with the maximum value of [f], or `null` if empty.
  T? maxBy<R extends Comparable<dynamic>>(R Function(T) f) {
    if (isEmpty) return null;
    return reduce((a, b) => f(a).compareTo(f(b)) >= 0 ? a : b);
  }

  /// Returns the element with the minimum value of [f], or `null` if empty.
  T? minBy<R extends Comparable<dynamic>>(R Function(T) f) {
    if (isEmpty) return null;
    return reduce((a, b) => f(a).compareTo(f(b)) <= 0 ? a : b);
  }

  // ─── Indexed Iteration ───────────────────────────────────────────────────────

  /// Calls [f] for each element with its index.
  void forEachIndexed(void Function(int index, T element) f) {
    var i = 0;
    for (final e in this) {
      f(i++, e);
    }
  }

  /// Maps each element with its index.
  Iterable<R> mapIndexed<R>(R Function(int index, T element) f) sync* {
    var i = 0;
    for (final e in this) {
      yield f(i++, e);
    }
  }

  /// Filters elements with their index.
  Iterable<T> whereIndexed(bool Function(int index, T element) f) sync* {
    var i = 0;
    for (final e in this) {
      if (f(i++, e)) yield e;
    }
  }

  // ─── Transformation ──────────────────────────────────────────────────────────

  /// Maps each element to an [Iterable] and flattens the result.
  ///
  /// ```dart
  /// ['hello', 'world'].flatMap((s) => s.split(''))
  /// // ['h','e','l','l','o','w','o','r','l','d']
  /// ```
  Iterable<R> flatMap<R>(Iterable<R> Function(T) f) => expand(f);

  /// Splits the iterable into chunks of [size].
  ///
  /// ```dart
  /// [1,2,3,4,5].chunked(2) // [[1,2],[3,4],[5]]
  /// ```
  Iterable<List<T>> chunked(int size) sync* {
    assert(size > 0, 'chunk size must be > 0');
    var chunk = <T>[];
    for (final e in this) {
      chunk.add(e);
      if (chunk.length == size) {
        yield chunk;
        chunk = [];
      }
    }
    if (chunk.isNotEmpty) yield chunk;
  }

  /// Returns distinct elements by [key].
  ///
  /// ```dart
  /// users.distinctBy((u) => u.id)
  /// ```
  Iterable<T> distinctBy<K>(K Function(T) key) sync* {
    final seen = <K>{};
    for (final e in this) {
      if (seen.add(key(e))) yield e;
    }
  }

  // ─── Grouping / Indexing ─────────────────────────────────────────────────────

  /// Groups elements by [key], returning a `Map<K, List<T>>`.
  ///
  /// ```dart
  /// words.groupBy((w) => w[0]) // {'h': ['hello'], 'w': ['world']}
  /// ```
  Map<K, List<T>> groupBy<K>(K Function(T) key) {
    final map = <K, List<T>>{};
    for (final e in this) {
      (map[key(e)] ??= []).add(e);
    }
    return map;
  }

  /// Indexes elements by [key], returning a `Map<K, T>`.
  /// If multiple elements share a key, the last one wins.
  ///
  /// ```dart
  /// users.associateBy((u) => u.id) // {1: User(1), 2: User(2)}
  /// ```
  Map<K, T> associateBy<K>(K Function(T) key) =>
      {for (final e in this) key(e): e};

  /// Returns a map of each element to the result of [value].
  Map<T, V> associateWith<V>(V Function(T) value) =>
      {for (final e in this) e: value(e)};
}
