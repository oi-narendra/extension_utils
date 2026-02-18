/// Extensions on [Enum] for pattern-matching style dispatch.
extension EnumUtils on Enum {
  /// Calls the function corresponding to this enum value in [map] and returns
  /// the result.
  ///
  /// Throws [ArgumentError] if this enum value is not in [map].
  ///
  /// ```dart
  /// enum Status { active, inactive, pending }
  ///
  /// final label = status.when({
  ///   Status.active: () => 'Active',
  ///   Status.inactive: () => 'Inactive',
  ///   Status.pending: () => 'Pending',
  /// });
  /// ```
  R when<R>(Map<Enum, R Function()> map) {
    final fn = map[this];
    if (fn == null) throw ArgumentError('No case for enum value: $this');
    return fn();
  }

  /// Like [when], but returns [orElse] if this enum value is not in [map].
  ///
  /// ```dart
  /// final label = status.whenOrElse(
  ///   {Status.active: () => 'Active'},
  ///   orElse: () => 'Unknown',
  /// );
  /// ```
  R whenOrElse<R>(
    Map<Enum, R Function()> map, {
    required R Function() orElse,
  }) =>
      map.containsKey(this) ? map[this]!() : orElse();

  /// Returns the enum name as a human-readable title case string.
  ///
  /// ```dart
  /// Status.activeUser.label // 'Active User'
  /// ```
  String get label {
    // Split camelCase name into words
    final words = name.replaceAllMapped(
      RegExp(r'([A-Z])'),
      (m) => ' ${m[1]}',
    );
    return words.trim().split(' ').map((w) {
      if (w.isEmpty) return '';
      return '${w[0].toUpperCase()}${w.substring(1).toLowerCase()}';
    }).join(' ');
  }
}
