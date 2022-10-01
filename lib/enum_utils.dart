extension EnumUtils on Enum {
  /// A when function for [Enum]s.
  // It takes a [Map] of [Enum]s to functions, and returns the result of
  /// calling the function corresponding to the [Enum] of the object.

  R when<R>(Map<Enum, R Function()> map) {
    return map[this]!();
  }

  /// A when or else function for [Enum]s.
  /// It takes a [Map] of [Enum]s to functions, and returns the result of
  /// calling the function corresponding to the [Enum] of the object.

  R whenOrElse<R>(Map<Enum, R Function()> map, {required R Function() orElse}) {
    if (map.containsKey(this)) {
      return map[this]!();
    } else {
      return orElse();
    }
  }
}
