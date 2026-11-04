import 'dart:async';

/// Runs the latest callback after [delay] without another call to [run].
///
/// Keep one instance per operation and dispose it with its owner. Callbacks are
/// invoked without awaiting them; this does not cancel work already started.
class Debouncer {
  /// Creates a debouncer. Zero delay schedules on the next event-loop turn.
  Debouncer({required this.delay}) {
    if (delay.isNegative) throw ArgumentError.value(delay, 'delay');
  }

  /// Quiet period before invoking the latest callback.
  final Duration delay;
  Timer? _timer;
  void Function()? _callback;
  bool _disposed = false;

  /// Whether a callback is waiting to run.
  bool get isPending => _callback != null;

  /// Replaces any pending callback. Throws [StateError] after disposal.
  void run(void Function() callback) {
    if (_disposed) throw StateError('Debouncer is disposed');
    cancel();
    _callback = callback;
    _timer = Timer(delay, flush);
  }

  /// Runs the pending callback immediately, once. Does nothing if none exists.
  /// Synchronous callback errors propagate to the caller.
  void flush() {
    final callback = _callback;
    cancel();
    callback?.call();
  }

  /// Discards the pending callback. The instance can be reused.
  void cancel() {
    _timer?.cancel();
    _timer = null;
    _callback = null;
  }

  /// Cancels pending work and prevents future calls to [run]. Safe to repeat.
  void dispose() {
    cancel();
    _disposed = true;
  }
}

/// Runs the first callback immediately, ignoring calls during [interval].
///
/// There is no trailing invocation. Callbacks are not awaited, so this limits
/// start frequency, not concurrent asynchronous work.
class Throttler {
  /// Creates a throttler. Zero interval allows every call.
  Throttler({required this.interval}) {
    if (interval.isNegative) throw ArgumentError.value(interval, 'interval');
  }

  /// Cooldown measured from the start of an accepted call.
  final Duration interval;
  Timer? _timer;
  bool _disposed = false;

  /// Whether calls are currently being ignored.
  bool get isActive => _timer?.isActive ?? false;

  /// Runs [callback] and returns true, or returns false during the cooldown.
  /// Throws [StateError] after disposal. Synchronous callback errors propagate;
  /// the cooldown remains active even if the callback throws.
  bool run(void Function() callback) {
    if (_disposed) throw StateError('Throttler is disposed');
    if (isActive) return false;
    if (interval > Duration.zero) {
      _timer = Timer(interval, () => _timer = null);
    }
    callback();
    return true;
  }

  /// Ends the cooldown so the next call can run immediately.
  void cancel() {
    _timer?.cancel();
    _timer = null;
  }

  /// Ends the cooldown and prevents future calls to [run]. Safe to repeat.
  void dispose() {
    cancel();
    _disposed = true;
  }
}
