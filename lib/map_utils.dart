import 'package:extension_utils/string_utils.dart';
import 'package:flutter/foundation.dart';

extension MapUtils on Map {
  /// Returns `true` if the map is empty, `false` otherwise.
  bool get isEmpty => length == 0;

  /// Returns `true` if the map contains the specified [key] and [value], `false` otherwise.
  bool contains(Object key, Object value) =>
      containsKey(key) && this[key] == value;

  /// Returns `true` if the map contains the specified
  /// [key] and [value] and removes the entry, `false` otherwise.
  bool removeExact({required Object key, required Object value}) {
    if (containsKey(key) && this[key] == value) {
      remove(key);
      return true;
    }
    return false;
  }

  /// Add prefix to all keys in the map.
  /// Returns a new map with prefixed keys.
  Map<String, V> prefixKeys<V>(String prefix) {
    final map = <String, V>{};
    for (final key in keys) {
      map['$prefix$key'] = this[key] as V;
    }
    return map;
  }

  /// Add suffix to all keys in the map.
  /// Returns a new map with suffixed keys.
  Map<String, V> suffixKeys<V>(String suffix) {
    final map = <String, V>{};
    for (final key in keys) {
      map['$key$suffix'] = this[key] as V;
    }
    return map;
  }

  /// Add prefix to all values in the map.
  /// Returns a new map with prefixed values.
  Map<K, String> prefixValues<K>(String prefix) {
    final map = <K, String>{};
    for (final key in keys) {
      map[key as K] = '$prefix${this[key]}';
    }
    return map;
  }

  /// Add suffix to all values in the map.
  /// Returns a new map with suffixed values.
  Map<K, String> suffixValues<K>(String suffix) {
    final map = <K, String>{};
    for (final key in keys) {
      map[key as K] = '${this[key]}$suffix';
    }
    return map;
  }

  /// Capitalize all keys in the map.
  /// Returns a new map with capitalized keys.
  Map<String, V> capitalizeKeys<V>() {
    final map = <String, V>{};
    for (final key in keys) {
      map[key.toString().capitalize()] = this[key] as V;
    }
    return map;
  }

  /// Capitalize all values in the map.
  /// Returns a new map with capitalized values.
  Map<K, String> capitalizeValues<K>() {
    final map = <K, String>{};
    for (final key in keys) {
      map[key as K] = this[key].toString().capitalize();
    }
    return map;
  }

  /// Camel case all keys in the map.
  /// Returns a new map with camel cased keys.
  Map<String, V> camelCaseKeys<V>() {
    final map = <String, V>{};
    for (final key in keys) {
      map[key.toString().toCamelCase()] = this[key] as V;
    }
    return map;
  }

  /// Camel case all values in the map.
  /// Returns a new map with camel cased values.
  Map<K, String> camelCaseValues<K>() {
    final map = <K, String>{};
    for (final key in keys) {
      map[key as K] = this[key].toString().toCamelCase();
    }
    return map;
  }

  /// Snake case all keys in the map.
  /// Returns a new map with snake cased keys.
  Map<String, V> snakeCaseKeys<V>() {
    final map = <String, V>{};
    for (final key in keys) {
      map[key.toString().toSnakeCase()] = this[key] as V;
    }
    return map;
  }

  /// Snake case all values in the map.
  /// Returns a new map with snake cased values.

  Map<K, String> snakeCaseValues<K>() {
    final map = <K, String>{};
    for (final key in keys) {
      map[key as K] = this[key].toString().toSnakeCase();
    }
    return map;
  }

  /// Kebab case all keys in the map.
  /// Returns a new map with kebab cased keys.
  Map<String, V> kebabCaseKeys<V>() {
    final map = <String, V>{};
    for (final key in keys) {
      map[key.toString().toKebabCase()] = this[key] as V;
    }
    return map;
  }

  /// Kebab case all values in the map.
  /// Returns a new map with kebab cased values.
  Map<K, String> kebabCaseValues<K>() {
    final map = <K, String>{};
    for (final key in keys) {
      map[key as K] = this[key].toString().toKebabCase();
    }
    return map;
  }

  /// Split map into two maps based on the [predicate].
  /// Returns a list of two maps.
  List<Map<K, V>> partition<K, V>(bool Function(K key, V value) predicate) {
    final map1 = <K, V>{};
    final map2 = <K, V>{};
    for (final key in keys) {
      if (predicate(key as K, this[key] as V)) {
        map1[key] = this[key] as V;
      } else {
        map2[key] = this[key] as V;
      }
    }
    return [map1, map2];
  }

  /// Returns a new map with all entries that satisfy the given [predicate].
  /// The entries in the resulting map preserve the order of the original map.
  Map<K, V> filter<K, V>(bool Function(K key, V value) predicate) {
    final map = <K, V>{};
    for (final key in keys) {
      if (predicate(key as K, this[key] as V)) {
        map[key] = this[key] as V;
      }
    }
    return map;
  }

  /// Returns a new map with all entries that do not satisfy the given [predicate].
  /// The entries in the resulting map preserve the order of the original map.
  Map<K, V> reject<K, V>(bool Function(K key, V value) predicate) {
    final map = <K, V>{};
    for (final key in keys) {
      if (!predicate(key as K, this[key] as V)) {
        map[key] = this[key] as V;
      }
    }
    return map;
  }

  /// Filter null values from the map.
  /// Returns a new map with non-null values.
  Map<K, V> filterNull<K, V>() {
    final map = <K, V>{};
    for (final key in keys) {
      if (this[key] != null) {
        map[key as K] = this[key] as V;
      }
    }
    return map;
  }

  /// Filter empty values from the map.
  /// Returns a new map with non-empty values.
  Map<K, V> filterEmpty<K, V>() {
    final map = <K, V>{};
    for (final key in keys) {
      if (this[key] != null && this[key].toString().isNotEmpty) {
        map[key as K] = this[key] as V;
      }
    }
    return map;
  }

  /// Shift the first entry from the map.
  MapEntry<K, V> shift<K, V>() {
    final key = keys.first;
    final value = this[key];
    removeExact(key: key, value: value);
    return MapEntry(key, value);
  }

  /// Filter where the key is in the given [keys].
  /// Returns a new map with filtered entries.
  Map<K, V> filterKeys<K, V>(Iterable<K> keys) {
    final map = <K, V>{};
    for (final key in keys) {
      if (containsKey(key)) {
        map[key] = this[key] as V;
      }
    }
    return map;
  }

  /// Filter where the value is in the given [values].
  /// Returns a new map with filtered entries.
  Map<K, V> filterValues<K, V>(Iterable<V> values) {
    final map = <K, V>{};
    for (final key in keys) {
      if (values.contains(this[key])) {
        map[key as K] = this[key] as V;
      }
    }
    return map;
  }

  /// Filter where the key is not in the given [keys].
  /// Returns a new map with filtered entries.
  Map<K, V> rejectKeys<K, V>(Iterable<K> keys) {
    final map = <K, V>{};
    for (final key in keys) {
      if (!containsKey(key)) {
        map[key] = this[key] as V;
      }
    }
    return map;
  }

  /// Filter where the value is not in the given [values].
  /// Returns a new map with filtered entries.
  Map<K, V> rejectValues<K, V>(Iterable<V> values) {
    final map = <K, V>{};
    for (final key in keys) {
      if (!values.contains(this[key])) {
        map[key as K] = this[key] as V;
      }
    }
    return map;
  }

  /// Returns a new map with all entries that satisfy the given [predicate].
  /// The entries in the resulting map do not preserve the order of the original map.
  Map<K, V> filterNot<K, V>(bool Function(K key, V value) predicate) {
    final map = <K, V>{};
    for (final key in keys) {
      if (!predicate(key as K, this[key] as V)) {
        map[key] = this[key] as V;
      }
    }
    return map;
  }

  /// Returns a new map with all entries that do not satisfy the given [predicate].
  /// The entries in the resulting map do not
  /// preserve the order of the original map.
  Map<K, V> rejectNot<K, V>(bool Function(K key, V value) predicate) {
    final map = <K, V>{};
    for (final key in keys) {
      if (predicate(key as K, this[key] as V)) {
        map[key] = this[key] as V;
      }
    }
    return map;
  }

  /// debug print the map with [label] and [separator].
  /// [label] is the label for the map.
  /// [separator] is the separator between key and value.
  /// [indent] is the indent for each line.

  void printDebug<K, V>({
    String label = 'Map',
    String separator = ': ',
    String indent = '  ',
  }) {
    final sb = StringBuffer();
    sb.writeln('$label:');
    for (final key in keys) {
      sb.writeln('$indent$key$separator${this[key]}');
    }
    debugPrint(sb.toString());
  }

  /// Remove duplicate values from the map.
  /// Returns a new map with unique values.
  Map<K, V> uniqueValues<K, V>() {
    final map = <K, V>{};
    for (final key in keys) {
      if (!map.containsValue(this[key])) {
        map[key as K] = this[key] as V;
      }
    }
    return map;
  }
}
