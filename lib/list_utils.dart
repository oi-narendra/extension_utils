import 'dart:math' as math;

import 'model/pair.dart';

/// Extensions on [List] for real-world utility operations.
extension ListUtils<T> on List<T> {
  // ─── Safe Accessors ──────────────────────────────────────────────────────────

  /// Returns the second element, or `null` if the list has fewer than 2 items.
  T? get second => length >= 2 ? this[1] : null;

  /// Returns the third element, or `null` if the list has fewer than 3 items.
  T? get third => length >= 3 ? this[2] : null;

  /// Returns the second-to-last element, or `null` if the list has fewer than
  /// 2 items.
  T? get penultimate => length >= 2 ? this[length - 2] : null;

  // ─── Remove ──────────────────────────────────────────────────────────────────

  /// Removes the first occurrence of [item] from the list.
  void removeFirst(T item) {
    final i = indexOf(item);
    if (i != -1) removeAt(i);
  }

  /// Removes the last occurrence of [item] from the list.
  void removeLastOccurrence(T item) {
    final i = lastIndexOf(item);
    if (i != -1) removeAt(i);
  }

  /// Removes all occurrences of [item] from the list.
  void removeAll(T item) => removeWhere((e) => e == item);

  /// Removes the first [n] occurrences of [item] (or last if [n] is negative).
  void removeN(T item, int n) {
    if (n == 0) return;
    if (n > 0) {
      for (var i = 0; i < n; i++) {
        removeFirst(item);
      }
    } else {
      for (var i = 0; i < -n; i++) {
        removeLastOccurrence(item);
      }
    }
  }

  // ─── Aggregation ─────────────────────────────────────────────────────────────

  /// Sums the list by applying [f] to each element.
  num sumBy(num Function(T) f) => fold<num>(0, (acc, e) => acc + f(e));

  /// Returns the average of the list by applying [f] to each element.
  /// Returns `0` if the list is empty.
  double averageBy(num Function(T) f) => isEmpty ? 0 : sumBy(f) / length;

  // ─── Statistics (on List<num>) ───────────────────────────────────────────────

  /// Returns the average of a `List<num>`. Returns `0` if empty.
  double get average {
    if (isEmpty) return 0;
    if (this is! List<num>) {
      throw UnsupportedError('average is only supported on List<num>');
    }
    return (this as List<num>).fold<double>(0.0, (acc, e) => acc + e) / length;
  }

  /// Returns the median of a `List<num>`. Returns `0` if empty.
  double get median {
    if (isEmpty) return 0;
    if (this is! List<num>) {
      throw UnsupportedError('median is only supported on List<num>');
    }
    final sorted = List<num>.from(this as List<num>)..sort();
    final mid = sorted.length ~/ 2;
    return sorted.length.isOdd
        ? sorted[mid].toDouble()
        : (sorted[mid - 1] + sorted[mid]) / 2;
  }

  /// Returns the most frequently occurring element, or `null` if empty.
  T? get mode {
    if (isEmpty) return null;
    final freq = <T, int>{};
    for (final e in this) {
      freq[e] = (freq[e] ?? 0) + 1;
    }
    return freq.entries.reduce((a, b) => a.value >= b.value ? a : b).key;
  }

  /// Returns a map of each element to its occurrence count.
  ///
  /// ```dart
  /// ['a','b','a','c'].frequencies() // {'a': 2, 'b': 1, 'c': 1}
  /// ```
  Map<T, int> frequencies() {
    final freq = <T, int>{};
    for (final e in this) {
      freq[e] = (freq[e] ?? 0) + 1;
    }
    return freq;
  }

  // ─── Transformation ──────────────────────────────────────────────────────────

  /// Splits the list into a [Pair] based on [predicate].
  /// First list: elements where predicate is `true`.
  /// Second list: elements where predicate is `false`.
  Pair<List<T>, List<T>> partition(bool Function(T) predicate) {
    final yes = <T>[], no = <T>[];
    for (final e in this) {
      (predicate(e) ? yes : no).add(e);
    }
    return Pair(yes, no);
  }

  /// Splits the list into chunks of [size].
  ///
  /// ```dart
  /// [1,2,3,4,5].chunk(2) // [[1,2],[3,4],[5]]
  /// ```
  List<List<T>> chunk(int size) {
    assert(size > 0, 'chunk size must be > 0');
    final chunks = <List<T>>[];
    for (var i = 0; i < length; i += size) {
      chunks.add(sublist(i, (i + size).clamp(0, length)));
    }
    return chunks;
  }

  /// Returns a sliding window of [size] over the list.
  ///
  /// ```dart
  /// [1,2,3,4].windowed(2) // [[1,2],[2,3],[3,4]]
  /// ```
  List<List<T>> windowed(int size, {int step = 1}) {
    assert(size > 0 && step > 0);
    final result = <List<T>>[];
    for (var i = 0; i + size <= length; i += step) {
      result.add(sublist(i, i + size));
    }
    return result;
  }

  /// Zips this list with [other] into a list of [Pair]s.
  /// Stops at the shorter list.
  ///
  /// ```dart
  /// [1,2,3].zip(['a','b','c']) // [(1,'a'),(2,'b'),(3,'c')]
  /// ```
  List<Pair<T, U>> zip<U>(List<U> other) {
    final len = math.min(length, other.length);
    return List.generate(len, (i) => Pair(this[i], other[i]));
  }

  /// Returns consecutive pairs of elements.
  ///
  /// ```dart
  /// [1,2,3,4].toPairs() // [(1,2),(2,3),(3,4)]
  /// ```
  List<Pair<T, T>> toPairs() {
    if (length < 2) return [];
    return List.generate(length - 1, (i) => Pair(this[i], this[i + 1]));
  }

  /// Flattens a `List<List<R>>` into a `List<R>`.
  ///
  /// ```dart
  /// [[1,2],[3,4]].flatten<int>() // [1,2,3,4]
  /// ```
  List<R> flatten<R>() {
    if (this is! List<List<R>>) {
      throw UnsupportedError('flatten<R> requires a List<List<R>>');
    }
    return (this as List<List<R>>).expand((e) => e).toList();
  }

  /// Returns a new list with distinct elements based on [key].
  ///
  /// ```dart
  /// users.distinctBy((u) => u.id)
  /// ```
  List<T> distinctBy<K>(K Function(T) key) {
    final seen = <K>{};
    return where((e) => seen.add(key(e))).toList();
  }

  /// Returns a new list sorted ascending by [key].
  List<T> sortedBy<K extends Comparable<dynamic>>(K Function(T) key) {
    final copy = [...this];
    copy.sort((a, b) => key(a).compareTo(key(b)));
    return copy;
  }

  /// Returns a new list sorted descending by [key].
  List<T> sortedByDescending<K extends Comparable<dynamic>>(K Function(T) key) {
    final copy = [...this];
    copy.sort((a, b) => key(b).compareTo(key(a)));
    return copy;
  }

  /// Groups elements by [key], returning a `Map<K, List<T>>`.
  Map<K, List<T>> groupBy<K>(K Function(T) key) {
    final map = <K, List<T>>{};
    for (final e in this) {
      (map[key(e)] ??= []).add(e);
    }
    return map;
  }

  /// Converts this list to a `Map<K, V>` using [key] and [value] selectors.
  Map<K, V> toMap<K, V>(K Function(T) key, V Function(T) value) =>
      {for (final e in this) key(e): value(e)};

  /// Merges this list with [other]. If [unique] is `true`, duplicates are
  /// excluded.
  List<T> mergeList(List<T> other, {bool unique = false}) {
    if (!unique) return [...this, ...other];
    final result = [...this];
    for (final e in other) {
      if (!result.contains(e)) result.add(e);
    }
    return result;
  }

  /// Removes null and empty (String/Iterable/Map) elements.
  List<T> compact() => where((e) {
        if (e == null) return false;
        if (e is String) return e.isNotEmpty;
        if (e is Iterable) return e.isNotEmpty;
        if (e is Map) return e.isNotEmpty;
        return true;
      }).toList();

  /// Clears this list and adds all elements from [items].
  void clearAndAddAll(List<T> items) {
    clear();
    addAll(items);
  }

  // ─── Reordering ──────────────────────────────────────────────────────────────

  /// Rotates the list left by [n] positions (negative = right rotation).
  ///
  /// ```dart
  /// [1,2,3,4,5].rotate(2) // [3,4,5,1,2]
  /// ```
  List<T> rotate(int n) {
    if (isEmpty) return [];
    final offset = n % length;
    if (offset == 0) return [...this];
    return [...sublist(offset), ...sublist(0, offset)];
  }

  /// Swaps elements at indices [i] and [j] in place.
  void swap(int i, int j) {
    final tmp = this[i];
    this[i] = this[j];
    this[j] = tmp;
  }

  /// Moves the element at [from] to [to], shifting other elements.
  void move(int from, int to) {
    final item = removeAt(from);
    insert(to, item);
  }

  /// Inserts [item] at [index], clamped to valid range.
  void insertAt(int index, T item) {
    insert(index.clamp(0, length), item);
  }

  // ─── Random ──────────────────────────────────────────────────────────────────

  /// Returns a random element from the list.
  /// Throws [StateError] if the list is empty.
  T random({int? seed}) {
    if (isEmpty) throw StateError('Cannot pick from an empty list');
    return this[math.Random(seed).nextInt(length)];
  }

  /// Returns [n] random elements without replacement.
  List<T> sample(int n, {int? seed}) {
    if (n >= length) return [...this]..shuffle(math.Random(seed));
    final copy = [...this]..shuffle(math.Random(seed));
    return copy.take(n).toList();
  }

  // ─── Checks ──────────────────────────────────────────────────────────────────

  /// Returns `true` if this list contains all elements of [items].
  bool containsAllList(List<T> items) => items.every(contains);

  // ─── String Joining ──────────────────────────────────────────────────────────

  /// Joins elements to a string with [separator], optional [prefix]/[suffix],
  /// and optional [transform].
  String joinToString(
    String separator, {
    String prefix = '',
    String suffix = '',
    String Function(T)? transform,
  }) {
    final buf = StringBuffer(prefix);
    for (var i = 0; i < length; i++) {
      if (i > 0) buf.write(separator);
      buf.write(transform != null ? transform(this[i]) : this[i]);
    }
    buf.write(suffix);
    return buf.toString();
  }
}
