/// Extensions on [Future] for real-world utility operations.
extension FutureUtils<T> on Future<T> {
  // ─── Timeout ─────────────────────────────────────────────────────────────────

  /// Completes with [fallback] if this future does not resolve within [timeout].
  /// Returns `null` as fallback if not specified.
  ///
  /// ```dart
  /// fetchData().withTimeout(Duration(seconds: 5), fallback: defaultValue)
  /// ```
  Future<T?> withTimeout(Duration timeout, {T? fallback}) async {
    try {
      return await this.timeout(timeout);
    } on Object {
      return fallback;
    }
  }

  // ─── Fallback ────────────────────────────────────────────────────────────────

  /// Returns [fallback] if this future throws any error.
  ///
  /// ```dart
  /// riskyOperation().withFallback(defaultValue)
  /// ```
  Future<T> withFallback(T fallback) => catchError((Object _) => fallback);
}

/// Retries [factory] up to [times] additional times on failure.
/// An optional [delay] is awaited between attempts.
///
/// Because a [Future] cannot be "replayed" once created, this top-level
/// function accepts a factory that creates a new [Future] on each attempt.
///
/// ```dart
/// final result = await retryFuture(() => fetchData(), times: 3,
///     delay: Duration(seconds: 1));
/// ```
Future<T> retryFuture<T>(
  Future<T> Function() factory, {
  int times = 3,
  Duration delay = Duration.zero,
}) async {
  var attempts = 0;
  while (true) {
    try {
      return await factory();
    } catch (e) {
      if (attempts >= times) rethrow;
      attempts++;
      if (delay > Duration.zero) await Future<void>.delayed(delay);
    }
  }
}
