/// Extensions on [bool] for real-world utility operations.
extension BoolUtils on bool {
  // ─── Toggle ──────────────────────────────────────────────────────────────────

  /// Returns the logical negation of this value.
  ///
  /// ```dart
  /// true.toggled  // false
  /// false.toggled // true
  /// ```
  bool get toggled => !this;

  // ─── String Representations ──────────────────────────────────────────────────

  /// Returns `'Yes'` or `'No'`.
  ///
  /// ```dart
  /// true.toYesNo()  // 'Yes'
  /// false.toYesNo() // 'No'
  /// ```
  String toYesNo() => this ? 'Yes' : 'No';

  /// Returns `'On'` or `'Off'`.
  ///
  /// ```dart
  /// true.toOnOff()  // 'On'
  /// false.toOnOff() // 'Off'
  /// ```
  String toOnOff() => this ? 'On' : 'Off';

  /// Returns `'Enabled'` or `'Disabled'`.
  ///
  /// ```dart
  /// true.toEnabledDisabled()  // 'Enabled'
  /// false.toEnabledDisabled() // 'Disabled'
  /// ```
  String toEnabledDisabled() => this ? 'Enabled' : 'Disabled';

  // ─── Conditional Callbacks ───────────────────────────────────────────────────

  /// Returns [value] if this is `true`, otherwise `null`.
  ///
  /// ```dart
  /// isAdmin.ifTrue('Admin Panel') // 'Admin Panel' or null
  /// ```
  T? ifTrue<T>(T value) => this ? value : null;

  /// Returns [value] if this is `false`, otherwise `null`.
  ///
  /// ```dart
  /// hasError.ifFalse('All good!') // 'All good!' or null
  /// ```
  T? ifFalse<T>(T value) => this ? null : value;

  /// Calls [onTrue] if `true`, [onFalse] if `false`, and returns the result.
  ///
  /// ```dart
  /// isLoggedIn.when(
  ///   onTrue: () => 'Welcome back!',
  ///   onFalse: () => 'Please log in',
  /// )
  /// ```
  T when<T>({
    required T Function() onTrue,
    required T Function() onFalse,
  }) =>
      this ? onTrue() : onFalse();
}
