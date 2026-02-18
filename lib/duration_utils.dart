/// Extensions on [Duration] for real-world utility operations.
extension DurationUtils on Duration {
  // ─── Predicates ──────────────────────────────────────────────────────────────

  /// Returns `true` if this duration is zero.
  bool get isZero => this == Duration.zero;

  /// Returns `true` if this duration is negative.
  bool get isNegative => inMicroseconds < 0;

  // ─── Derived Units ───────────────────────────────────────────────────────────

  /// Returns the number of whole weeks in this duration.
  int get inWeeks => inDays ~/ 7;

  // ─── DateTime Arithmetic ─────────────────────────────────────────────────────

  /// Returns a [DateTime] that is this duration before now.
  ///
  /// ```dart
  /// const Duration(hours: 2).ago // DateTime 2 hours ago
  /// ```
  DateTime get ago => DateTime.now().subtract(this);

  /// Returns a [DateTime] that is this duration after now.
  ///
  /// ```dart
  /// const Duration(days: 3).fromNow // DateTime 3 days from now
  /// ```
  DateTime get fromNow => DateTime.now().add(this);

  // ─── Formatting ──────────────────────────────────────────────────────────────

  /// Returns a human-readable string, e.g. `"1h 23m 45s"`, `"45s"`, `"2d 3h"`.
  ///
  /// ```dart
  /// const Duration(hours: 1, minutes: 23, seconds: 45).formatted
  /// // '1h 23m 45s'
  /// ```
  String get formatted {
    final abs = this.abs();
    final prefix = isNegative ? '-' : '';
    final parts = <String>[];
    if (abs.inDays > 0) {
      parts.add('${abs.inDays}d');
    }
    if (abs.inHours.remainder(24) > 0) {
      parts.add('${abs.inHours.remainder(24)}h');
    }
    if (abs.inMinutes.remainder(60) > 0) {
      parts.add('${abs.inMinutes.remainder(60)}m');
    }
    if (abs.inSeconds.remainder(60) > 0 || parts.isEmpty) {
      parts.add('${abs.inSeconds.remainder(60)}s');
    }
    return '$prefix${parts.join(' ')}';
  }

  /// Returns a zero-padded `HH:MM:SS` string (e.g. `"01:23:45"`).
  ///
  /// Useful for video players and stopwatches.
  String toHhMmSs() {
    final abs = this.abs();
    final h = abs.inHours.toString().padLeft(2, '0');
    final m = abs.inMinutes.remainder(60).toString().padLeft(2, '0');
    final s = abs.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '${isNegative ? '-' : ''}$h:$m:$s';
  }

  /// Returns a zero-padded `MM:SS` string (e.g. `"23:45"`).
  ///
  /// Useful for short timers and music players.
  String toMmSs() {
    final abs = this.abs();
    final m = abs.inMinutes.toString().padLeft(2, '0');
    final s = abs.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '${isNegative ? '-' : ''}$m:$s';
  }

  // ─── Arithmetic ─────────────────────────────────────────────────────────────────

  /// Multiplies this duration by [factor] and returns a new [Duration].
  ///
  /// Note: Dart's built-in `Duration * int` operator only accepts integers.
  /// Use this method for fractional multiplication.
  ///
  /// ```dart
  /// const Duration(hours: 1).multipliedBy(1.5) // Duration(hours: 1, minutes: 30)
  /// ```
  Duration multipliedBy(double factor) =>
      Duration(microseconds: (inMicroseconds * factor).round());

  /// Divides this duration by [factor] and returns a new [Duration].
  ///
  /// ```dart
  /// const Duration(hours: 2).dividedBy(4) // Duration(minutes: 30)
  /// ```
  Duration dividedBy(double factor) {
    if (factor == 0) throw ArgumentError('Cannot divide Duration by zero');
    return Duration(microseconds: (inMicroseconds / factor).round());
  }

  /// Returns this duration as a percentage (0.0–1.0+) of [total].
  ///
  /// ```dart
  /// const Duration(minutes: 30).percentageOf(const Duration(hours: 1)) // 0.5
  /// ```
  double percentageOf(Duration total) {
    if (total.inMicroseconds == 0) return 0;
    return inMicroseconds / total.inMicroseconds;
  }

  /// Returns a human-readable countdown string, e.g. `"2d 3h 45m 10s"`.
  /// Omits zero-value units except seconds.
  ///
  /// ```dart
  /// const Duration(days: 2, hours: 3).toCountdown() // '2d 3h 0m 0s'
  /// ```
  String toCountdown() {
    final abs = this.abs();
    final d = abs.inDays;
    final h = abs.inHours.remainder(24);
    final m = abs.inMinutes.remainder(60);
    final s = abs.inSeconds.remainder(60);
    final parts = <String>[];
    if (d > 0) parts.add('${d}d');
    if (d > 0 || h > 0) parts.add('${h}h');
    parts.add('${m}m');
    parts.add('${s}s');
    return '${isNegative ? '-' : ''}${parts.join(' ')}';
  }
}
