import 'package:extension_utils/string_utils.dart';

import 'model/pair.dart';

/// Extensions on [Map] for real-world utility operations.
extension MapUtils<K, V> on Map<K, V> {
  // ─── Safe Access ─────────────────────────────────────────────────────────────

  /// Returns the value for [key], or [defaultValue] if the key is absent.
  ///
  /// ```dart
  /// {'a': 1}.getOrDefault('b', 0) // 0
  /// ```
  V getOrDefault(K key, V defaultValue) => this[key] ?? defaultValue;

  /// Returns the value for [key]. If absent, computes it with [compute],
  /// stores it, and returns it.
  ///
  /// ```dart
  /// final cache = <String, int>{};
  /// cache.getOrPut('key', () => expensiveCompute()); // computes once
  /// ```
  V getOrPut(K key, V Function() compute) {
    if (!containsKey(key)) this[key] = compute();
    return this[key] as V;
  }

  // ─── Filtering ───────────────────────────────────────────────────────────────

  /// Returns a new map with entries satisfying [predicate].
  Map<K, V> filter(bool Function(K key, V value) predicate) =>
      Map.fromEntries(entries.where((e) => predicate(e.key, e.value)));

  /// Returns a new map with entries NOT satisfying [predicate].
  Map<K, V> reject(bool Function(K key, V value) predicate) =>
      Map.fromEntries(entries.where((e) => !predicate(e.key, e.value)));

  /// Returns a new map with only the specified [keys].
  Map<K, V> filterKeys(Iterable<K> keys) => {
        for (final k in keys)
          if (containsKey(k)) k: this[k] as V
      };

  /// Returns a new map excluding the specified [keys].
  Map<K, V> rejectKeys(Iterable<K> keys) =>
      Map.fromEntries(entries.where((e) => !keys.contains(e.key)));

  /// Returns a new map keeping only entries whose value is in [values].
  Map<K, V> filterValues(Iterable<V> values) =>
      Map.fromEntries(entries.where((e) => values.contains(e.value)));

  /// Returns a new map excluding entries whose value is in [values].
  Map<K, V> rejectValues(Iterable<V> values) =>
      Map.fromEntries(entries.where((e) => !values.contains(e.value)));

  /// Returns a new map with null values removed.
  Map<K, V> filterNull() =>
      Map.fromEntries(entries.where((e) => e.value != null));

  /// Returns a new map with null and empty-string values removed.
  Map<K, V> filterEmpty() => Map.fromEntries(
        entries.where((e) => e.value != null && e.value.toString().isNotEmpty),
      );

  // ─── Transformation ──────────────────────────────────────────────────────────

  /// Returns a new map with keys transformed by [f].
  Map<K2, V> mapKeys<K2>(K2 Function(K key) f) =>
      {for (final e in entries) f(e.key): e.value};

  /// Returns a new map with values transformed by [f].
  Map<K, V2> mapValues<V2>(V2 Function(V value) f) =>
      {for (final e in entries) e.key: f(e.value)};

  /// Returns a new map with keys and values swapped.
  /// If duplicate values exist, later entries win.
  Map<V, K> invertMap() => {for (final e in entries) e.value: e.key};

  /// Merges this map with [other]. For duplicate keys, [resolve] determines
  /// the winner (defaults to [other]'s value).
  Map<K, V> mergeWith(
    Map<K, V> other, {
    V Function(V existing, V incoming)? resolve,
  }) {
    final result = Map<K, V>.from(this);
    for (final e in other.entries) {
      result[e.key] = (resolve != null && result.containsKey(e.key))
          ? resolve(result[e.key] as V, e.value)
          : e.value;
    }
    return result;
  }

  /// Removes duplicate values, keeping the first occurrence.
  Map<K, V> uniqueValues() {
    final seen = <V>{};
    return Map.fromEntries(entries.where((e) => seen.add(e.value)));
  }

  // ─── Key Casing ──────────────────────────────────────────────────────────────

  /// Returns a new map with all string keys prefixed by [prefix].
  Map<String, V> prefixKeys(String prefix) =>
      {for (final e in entries) '$prefix${e.key}': e.value};

  /// Returns a new map with all string keys suffixed by [suffix].
  Map<String, V> suffixKeys(String suffix) =>
      {for (final e in entries) '${e.key}$suffix': e.value};

  /// Returns a new map with all string keys capitalized.
  Map<String, V> capitalizeKeys() =>
      {for (final e in entries) e.key.toString().capitalize(): e.value};

  /// Returns a new map with all string keys converted to camelCase.
  Map<String, V> camelCaseKeys() =>
      {for (final e in entries) e.key.toString().toCamelCase(): e.value};

  /// Returns a new map with all string keys converted to snake_case.
  Map<String, V> snakeCaseKeys() =>
      {for (final e in entries) e.key.toString().toSnakeCase(): e.value};

  /// Returns a new map with all string keys converted to kebab-case.
  Map<String, V> kebabCaseKeys() =>
      {for (final e in entries) e.key.toString().toKebabCase(): e.value};

  // ─── Value Casing ────────────────────────────────────────────────────────────

  /// Returns a new map with all values prefixed by [prefix].
  Map<K, String> prefixValues(String prefix) =>
      {for (final e in entries) e.key: '$prefix${e.value}'};

  /// Returns a new map with all values suffixed by [suffix].
  Map<K, String> suffixValues(String suffix) =>
      {for (final e in entries) e.key: '${e.value}$suffix'};

  /// Returns a new map with all values capitalized.
  Map<K, String> capitalizeValues() =>
      {for (final e in entries) e.key: e.value.toString().capitalize()};

  /// Returns a new map with all values converted to camelCase.
  Map<K, String> camelCaseValues() =>
      {for (final e in entries) e.key: e.value.toString().toCamelCase()};

  /// Returns a new map with all values converted to snake_case.
  Map<K, String> snakeCaseValues() =>
      {for (final e in entries) e.key: e.value.toString().toSnakeCase()};

  /// Returns a new map with all values converted to kebab-case.
  Map<K, String> kebabCaseValues() =>
      {for (final e in entries) e.key: e.value.toString().toKebabCase()};

  // ─── Partition ───────────────────────────────────────────────────────────────

  /// Splits this map into two maps based on [predicate].
  /// First map: entries where predicate is `true`.
  /// Second map: entries where predicate is `false`.
  Pair<Map<K, V>, Map<K, V>> partition(
    bool Function(K key, V value) predicate,
  ) {
    final yes = <K, V>{}, no = <K, V>{};
    for (final e in entries) {
      (predicate(e.key, e.value) ? yes : no)[e.key] = e.value;
    }
    return Pair(yes, no);
  }

  // ─── Mutation ────────────────────────────────────────────────────────────────

  /// Removes and returns the first entry in the map.
  MapEntry<K, V> shift() {
    final entry = entries.first;
    remove(entry.key);
    return entry;
  }

  /// Returns `true` if this map contains [key] with exactly [value].
  bool contains(K key, V value) => containsKey(key) && this[key] == value;

  /// Removes the entry with [key] only if its value equals [value].
  /// Returns `true` if removed.
  bool removeExact({required K key, required V value}) {
    if (containsKey(key) && this[key] == value) {
      remove(key);
      return true;
    }
    return false;
  }

  // ─── Serialization ───────────────────────────────────────────────────────────

  /// Converts this map to a URL query string.
  ///
  /// ```dart
  /// {'page': 1, 'q': 'hello'}.toQueryString() // 'page=1&q=hello'
  /// ```
  String toQueryString() => entries
      .map((e) =>
          '${Uri.encodeQueryComponent(e.key.toString())}=${Uri.encodeQueryComponent(e.value.toString())}')
      .join('&');

  /// Flattens nested maps to dot-notation keys.
  ///
  /// ```dart
  /// {'a': {'b': {'c': 1}}}.flatten() // {'a.b.c': 1}
  /// ```
  Map<String, dynamic> flatten({String separator = '.'}) {
    final result = <String, dynamic>{};
    void flattenHelper(Map<dynamic, dynamic> map, String prefix) {
      for (final e in map.entries) {
        final key =
            prefix.isEmpty ? e.key.toString() : '$prefix$separator${e.key}';
        if (e.value is Map) {
          flattenHelper(e.value as Map, key);
        } else {
          result[key] = e.value;
        }
      }
    }

    flattenHelper(this, '');
    return result;
  }

  /// Safely retrieves a deeply nested value using a list of [path] keys.
  ///
  /// ```dart
  /// {'user': {'address': {'city': 'NY'}}}.deepGet(['user','address','city'])
  /// // 'NY'
  /// ```
  dynamic deepGet(List<String> path) {
    dynamic current = this;
    for (final key in path) {
      if (current is Map && current.containsKey(key)) {
        current = current[key];
      } else {
        return null;
      }
    }
    return current;
  }

  // ─── Deep Operations ──────────────────────────────────────────────────────────

  /// Recursively merges [other] into this map.
  /// For duplicate keys, if both values are Maps they are merged recursively;
  /// otherwise [other]'s value wins.
  ///
  /// ```dart
  /// {'a': {'x': 1}}.deepMerge({'a': {'y': 2}}) // {'a': {'x': 1, 'y': 2}}
  /// ```
  Map<K, V> deepMerge(Map<K, V> other) {
    final result = Map<K, V>.from(this);
    for (final e in other.entries) {
      if (result.containsKey(e.key) && result[e.key] is Map && e.value is Map) {
        result[e.key] = (result[e.key] as Map).deepMerge(e.value as Map) as V;
      } else {
        result[e.key] = e.value;
      }
    }
    return result;
  }

  /// Sets a deeply nested value at [path], creating intermediate maps as needed.
  ///
  /// ```dart
  /// <String, dynamic>{}.deepSet(['user', 'name'], 'Alice')
  /// // {'user': {'name': 'Alice'}}
  /// ```
  Map<String, dynamic> deepSet(List<String> path, dynamic value) {
    if (path.isEmpty) return this as Map<String, dynamic>;
    final result = Map<String, dynamic>.from(this as Map);
    Map<String, dynamic> current = result;
    for (var i = 0; i < path.length - 1; i++) {
      final key = path[i];
      if (current[key] is! Map) {
        current[key] = <String, dynamic>{};
      }
      current = Map<String, dynamic>.from(current[key] as Map);
      result[path[i]] = current;
    }
    current[path.last] = value;
    return result;
  }

  // ─── Compact / Rename / Diff ───────────────────────────────────────────────────

  /// Returns a new map with null values removed.
  ///
  /// ```dart
  /// {'a': 1, 'b': null, 'c': 3}.compact() // {'a': 1, 'c': 3}
  /// ```
  Map<K, V> compact() => Map.fromEntries(entries.where((e) => e.value != null));

  /// Returns a new map with the key [from] renamed to [to].
  ///
  /// ```dart
  /// {'old': 1}.renameKey('old', 'new') // {'new': 1}
  /// ```
  Map<K, V> renameKey(K from, K to) {
    if (!containsKey(from)) return Map.from(this);
    final result = Map<K, V>.from(this);
    result[to] = result.remove(from) as V;
    return result;
  }

  /// Returns entries in this map whose values differ from [other].
  /// Includes keys present in this map but absent in [other].
  ///
  /// ```dart
  /// {'a': 1, 'b': 2}.diff({'a': 1, 'b': 3}) // {'b': 3}
  /// ```
  Map<K, V> diff(Map<K, V> other) {
    final result = <K, V>{};
    for (final e in other.entries) {
      if (!containsKey(e.key) || this[e.key] != e.value) {
        result[e.key] = e.value;
      }
    }
    return result;
  }

  // ─── Pick / Omit ───────────────────────────────────────────────────────────────

  /// Returns a new map containing only the specified [keys].
  ///
  /// ```dart
  /// {'a': 1, 'b': 2, 'c': 3}.pick(['a', 'c']) // {'a': 1, 'c': 3}
  /// ```
  Map<K, V> pick(List<K> keys) => filterKeys(keys);

  /// Returns a new map with the specified [keys] removed.
  ///
  /// ```dart
  /// {'a': 1, 'b': 2, 'c': 3}.omit(['b']) // {'a': 1, 'c': 3}
  /// ```
  Map<K, V> omit(List<K> keys) => rejectKeys(keys);
}

/// Parses a URL query string into a `Map<String, String>`.
///
/// ```dart
/// mapFromQueryString('page=1&q=hello') // {'page': '1', 'q': 'hello'}
/// ```
Map<String, String> mapFromQueryString(String query) {
  if (query.isEmpty) return {};
  final q = query.startsWith('?') ? query.substring(1) : query;
  return Map.fromEntries(
    q.split('&').where((p) => p.isNotEmpty).map((pair) {
      final idx = pair.indexOf('=');
      if (idx == -1) {
        return MapEntry(Uri.decodeQueryComponent(pair), '');
      }
      return MapEntry(
        Uri.decodeQueryComponent(pair.substring(0, idx)),
        Uri.decodeQueryComponent(pair.substring(idx + 1)),
      );
    }),
  );
}
