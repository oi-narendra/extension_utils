/// Kotlin-style scope function extensions on any [Object].
///
/// These are inspired by Kotlin's `let`, `also`, `takeIf`, and `takeUnless`
/// and are useful for chaining operations without intermediate variables.
extension ObjectUtils<T> on T {
  // ─── Transform ───────────────────────────────────────────────────────────────

  /// Calls [block] with this value and returns the result.
  ///
  /// Useful for transforming a value inline without a temporary variable.
  ///
  /// ```dart
  /// 'hello'.let((s) => s.toUpperCase()) // 'HELLO'
  /// user.let((u) => u.name)             // user.name
  /// ```
  R let<R>(R Function(T) block) => block(this);

  // ─── Side Effects ────────────────────────────────────────────────────────────

  /// Calls [block] with this value for a side effect, then returns this value.
  ///
  /// Useful for logging, debugging, or mutation without breaking a chain.
  ///
  /// ```dart
  /// fetchUser()
  ///   .also((u) => print('Fetched: ${u.name}'))
  ///   .also((u) => analytics.track(u));
  /// ```
  T also(void Function(T) block) {
    block(this);
    return this;
  }

  // ─── Conditional ─────────────────────────────────────────────────────────────

  /// Returns this value if [predicate] is `true`, otherwise `null`.
  ///
  /// ```dart
  /// score.takeIf((s) => s >= 60) // score or null
  /// ```
  T? takeIf(bool Function(T) predicate) => predicate(this) ? this : null;

  /// Returns this value if [predicate] is `false`, otherwise `null`.
  ///
  /// ```dart
  /// name.takeUnless((n) => n.isEmpty) // name or null
  /// ```
  T? takeUnless(bool Function(T) predicate) => predicate(this) ? null : this;
}
