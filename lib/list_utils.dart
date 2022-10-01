import 'model/pair.dart';

/// Extension methods for [List]s.

extension ListUtils<T> on List<T> {
  /// Remove the first occurrence of [item] from the list.
  void removeFirst(T item) {
    final index = indexOf(item);
    if (index == -1) return;
    removeAt(index);
  }

  /// Remove the last occurrence of [item] from the list.
  void removeLast(T item) {
    final index = lastIndexOf(item);
    if (index == -1) return;
    removeAt(index);
  }

  /// Remove all occurrences of [item] from the list.
  void removeAll(T item) {
    while (contains(item)) {
      remove(item);
    }
  }

  /// Remove all occurrences of [List] [items] from the list.
  void removeAllList(List<T> items) {
    for (final item in items) {
      removeAll(item);
    }
  }

  /// Remove all occurrences of [Set] [items] from the list.
  void removeAllSet(Set<T> items) {
    for (final item in items) {
      removeAll(item);
    }
  }

  /// Remove all occurrences of [Iterable] [items] from the list.
  void removeAllIterable(Iterable<T> items) {
    for (final item in items) {
      removeAll(item);
    }
  }

  /// Remove all occurrences of [Map] [items] keys from the list.

  void removeAllMapKeys(Map<T, dynamic> items) {
    for (final item in items.keys) {
      removeAll(item);
    }
  }

  /// Remove all occurrences of [Map] [items] values from the list.

  void removeAllMapValues(Map<T, dynamic> items) {
    for (final item in items.values) {
      removeAll(item);
    }
  }

  /// Remove first [n] occurrences of [item] from the list.
  ///  If [n] is negative, remove from end of list.

  void removeN(T item, int n) {
    if (n == 0) return;
    if (n > 0) {
      for (var i = 0; i < n; i++) {
        removeFirst(item);
      }
    } else {
      for (var i = 0; i < -n; i++) {
        removeLast(item);
      }
    }
  }

  /// Remove first [n] occurrences of [List] [items] from the list.
  ///  If [n] is negative, remove from end of list.
  void removeNList(List<T> items, int n) {
    if (n == 0) return;
    if (n > 0) {
      for (var i = 0; i < n; i++) {
        removeAllList(items);
      }
    } else {
      for (var i = 0; i < -n; i++) {
        removeAllList(items.reversed.toList());
      }
    }
  }

  /// Get the first occurrence of [item] from the list.
  /// Returns `null` if the item was not found.

  T? getFirst(T item) {
    final index = indexOf(item);
    if (index == -1) return null;
    return this[index];
  }

  /// Get the last occurrence of [item] from the list.
  /// Returns `null` if the item was not found.

  T? getLast(T item) {
    final index = lastIndexOf(item);
    if (index == -1) return null;
    return this[index];
  }

  /// Sum by [f] of all elements in the list.
  /// Returns `0` if the list is empty and [f] returns `null`.

  num sumBy(num Function(T) f) {
    num sum = 0;
    for (final item in this) {
      final value = f(item);
      sum += value;
    }
    return sum;
  }

  /// Split the list into chunks of size [n].
  /// Returns a list of chunks.

  List<List<T>> chunk(int n) {
    final chunks = <List<T>>[];
    for (var i = 0; i < length; i += n) {
      chunks.add(sublist(i, i + n));
    }
    return chunks;
  }

  /// Split the list into two lists based on [f].
  /// Returns a list of two lists of [T].
  /// The first list contains all elements for which [f] returns `true`.
  /// The second list contains all elements for which [f] returns `false`.

  Pair<List<T>, List<T>> partition(bool Function(T) f) {
    final list1 = <T>[];
    final list2 = <T>[];
    for (final item in this) {
      if (f(item)) {
        list1.add(item);
      } else {
        list2.add(item);
      }
    }
    return Pair(list1, list2);
  }

  /// Check if the list contains all elements of [List] [items].
  /// Returns `true` if the list contains all elements of [items], `false` otherwise.

  bool containsAllList(List<T> items) {
    for (final item in items) {
      if (!contains(item)) return false;
    }
    return true;
  }

  /// Merge the list with [List] [items].
  /// Returns a new list with all elements of the list and [items].

  List<T> mergeList(List<T> items, {bool unique = false}) {
    final list = <T>[];
    list.addAll(this);
    if (unique) {
      for (final item in items) {
        if (!list.contains(item)) list.add(item);
      }
    } else {
      list.addAll(items);
    }
    return list;
  }

  /// Convert the list to a [Map] with [key] and [value] functions.
  /// Returns a new [Map] with the keys and values returned by [key] and [value].

  Map<K, V> toMap<K, V>(K Function(T) key, V Function(T) value) {
    final map = <K, V>{};
    for (final item in this) {
      map[key(item)] = value(item);
    }
    return map;
  }

  /// Distinct the list by [f].
  /// Returns a new list with distinct elements based on [f].

  List<T> distinctBy(dynamic Function(T) f) {
    final list = <T>[];
    for (final item in this) {
      if (!list.any((e) => f(e) == f(item))) list.add(item);
    }
    return list;
  }

  /// Remove null or empty elements from the list.
  /// Returns a new list with null or empty elements removed.

  List<T> compact() {
    final list = <T>[];
    for (final item in this) {
      if (item == null) {
        continue;
      } else if (item is String) {
        if (item.isNotEmpty) {
          list.add(item);
        }
      } else if (item is Iterable) {
        if (item.isNotEmpty) {
          list.add(item);
        }
      } else if (item is Map) {
        if (item.isNotEmpty) {
          list.add(item);
        }
      } else {
        list.add(item);
      }
    }
    return list;
  }

  /// Clear and add all elements of [List] [items] to the list.
  void clearAndAddAll(List<T> items) {
    if (isEmpty && items.isEmpty) return;
    clear();
    addAll(items);
  }

  /// Sort the list by [f].
  /// Returns a new list sorted by [f].

  List<T> sortedBy(dynamic Function(T) f) {
    final list = <T>[];
    list.addAll(this);
    list.sort((a, b) {
      final valueA = f(a);
      final valueB = f(b);
      if (valueA == null) {
        if (valueB == null) {
          return 0;
        } else {
          return 1;
        }
      } else if (valueB == null) {
        return -1;
      } else if (valueA is num) {
        return valueA.compareTo(valueB);
      } else if (valueA is String) {
        return valueA.compareTo(valueB);
      } else if (valueA is bool) {
        return valueA == valueB ? 0 : (valueA ? 1 : -1);
      } else if (valueA is DateTime) {
        return valueA.compareTo(valueB);
      } else if (valueA is Comparable) {
        return valueA.compareTo(valueB);
      } else {
        return 0;
      }
    });
    return list;
  }

  // Sort the list by [f] descending.
  /// Returns a new list sorted by [f] descending.

  List<T> sortedByDescending(dynamic Function(T) f) {
    final list = <T>[];
    list.addAll(this);
    list.sort((a, b) {
      final valueA = f(a);
      final valueB = f(b);
      if (valueA == null) {
        if (valueB == null) {
          return 0;
        } else {
          return -1;
        }
      } else if (valueB == null) {
        return 1;
      } else if (valueA is num) {
        return valueA.compareTo(valueB);
      } else if (valueA is String) {
        return valueA.compareTo(valueB);
      } else if (valueA is bool) {
        return valueA == valueB ? 0 : (valueA ? -1 : 1);
      } else if (valueA is DateTime) {
        return valueA.compareTo(valueB);
      } else if (valueA is Comparable) {
        return valueA.compareTo(valueB);
      } else {
        return 0;
      }
    });
    return list;
  }

  /// Group the list by [f].
  /// Returns a [Map] with the keys and values returned by [f].

  Map<K, List<T>> groupBy<K>(K Function(T) f) {
    final map = <K, List<T>>{};
    for (final item in this) {
      final key = f(item);
      if (map.containsKey(key)) {
        map[key]!.add(item);
      } else {
        map[key] = [item];
      }
    }
    return map;
  }

  /// Join to [String] with [separator], [prefix] and [suffix], and [transform] function.
  /// Returns a [String] with the elements joined by [separator], [prefix] and [suffix], and transformed by [transform].
  /// If [transform] is `null`, the elements are converted to [String] with `toString()`.

  String joinToString(
    String separator, {
    String prefix = '',
    String suffix = '',
    String Function(T)? transform,
  }) {
    final buffer = StringBuffer();
    buffer.write(prefix);
    for (var i = 0; i < length; i++) {
      if (i > 0) buffer.write(separator);
      buffer.write(transform == null ? this[i].toString() : transform(this[i]));
    }
    buffer.write(suffix);
    return buffer.toString();
  }

  /// Take while [f] is true.
  /// Returns a new list with the elements taken while [f] is true.

  List<T> takeWhile(bool Function(T) f) {
    final list = <T>[];
    for (final item in this) {
      if (f(item)) {
        list.add(item);
      } else {
        break;
      }
    }
    return list;
  }

  /// Take if [f] is true.
  ///  Returns a new list with the elements taken if [f] is true.

  List<T> takeIf(bool Function(T) f) {
    final list = <T>[];
    for (final item in this) {
      if (f(item)) {
        list.add(item);
      }
    }
    return list;
  }
}
