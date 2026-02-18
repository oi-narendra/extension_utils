/// Extensions on [DateTime] for real-world utility operations.
extension DateTimeUtils on DateTime {
  // ─── Relative Predicates ─────────────────────────────────────────────────────

  /// Returns `true` if this date is today.
  bool get isToday => isSameDay(DateTime.now());

  /// Returns `true` if this date is yesterday.
  bool get isYesterday =>
      isSameDay(DateTime.now().subtract(const Duration(days: 1)));

  /// Returns `true` if this date is tomorrow.
  bool get isTomorrow => isSameDay(DateTime.now().add(const Duration(days: 1)));

  /// Returns `true` if this date is in the past.
  bool get isPast => isBefore(DateTime.now());

  /// Returns `true` if this date is in the future.
  bool get isFuture => isAfter(DateTime.now());

  // ─── Comparison ──────────────────────────────────────────────────────────────

  /// Returns `true` if this date is on the same calendar day as [other].
  bool isSameDay(DateTime other) =>
      year == other.year && month == other.month && day == other.day;

  /// Returns `true` if this date is in the same month and year as [other].
  bool isSameMonth(DateTime other) =>
      year == other.year && month == other.month;

  /// Returns `true` if this date is in the same year as [other].
  bool isSameYear(DateTime other) => year == other.year;

  /// Returns `true` if this date is in the same hour as [other].
  bool isSameHour(DateTime other) => isSameDay(other) && hour == other.hour;

  /// Returns `true` if this date is in the same minute as [other].
  bool isSameMinute(DateTime other) =>
      isSameHour(other) && minute == other.minute;

  /// Returns `true` if this date is in the same second as [other].
  bool isSameSecond(DateTime other) =>
      isSameMinute(other) && second == other.second;

  /// Returns `true` if this date is between [start] and [end] (inclusive).
  bool isBetween(DateTime start, DateTime end) =>
      (isAfter(start) || isAtSameMomentAs(start)) &&
      (isBefore(end) || isAtSameMomentAs(end));

  /// Returns `true` if this date is at least [days] days ahead of [other].
  bool isAheadByDays(DateTime other, int days) =>
      difference(other).inDays >= days;

  /// Returns `true` if this date is at least [days] days behind [other].
  bool isBehindByDays(DateTime other, int days) =>
      difference(other).inDays <= -days;

  // ─── Time of Day ─────────────────────────────────────────────────────────────

  /// Returns `true` if the time is morning (06:00–11:59).
  bool get isMorning => hour >= 6 && hour < 12;

  /// Returns `true` if the time is afternoon (12:00–17:59).
  bool get isAfternoon => hour >= 12 && hour < 18;

  /// Returns `true` if the time is evening (18:00–22:59).
  bool get isEvening => hour >= 18 && hour < 23;

  /// Returns `true` if the time is night (23:00–05:59).
  bool get isNight => hour >= 23 || hour < 6;

  // ─── Week / Weekend ──────────────────────────────────────────────────────────

  /// Returns `true` if this date falls on a weekend (Saturday or Sunday).
  bool get isWeekend =>
      weekday == DateTime.saturday || weekday == DateTime.sunday;

  /// Returns `true` if this date falls on a weekday.
  bool get isWeekday => !isWeekend;

  /// Returns the number of days until the next Saturday (0 if already weekend).
  int daysUntilWeekend() {
    if (isWeekend) return 0;
    return DateTime.saturday - weekday;
  }

  // ─── Boundaries ──────────────────────────────────────────────────────────────

  /// Returns midnight (00:00:00.000) of this date.
  DateTime get startOfDay => DateTime(year, month, day);

  /// Returns the last moment (23:59:59.999) of this date.
  DateTime get endOfDay => DateTime(year, month, day, 23, 59, 59, 999);

  /// Returns the Monday of this date's week.
  DateTime get startOfWeek =>
      subtract(Duration(days: weekday - DateTime.monday)).startOfDay;

  /// Returns the Sunday of this date's week (end of week).
  DateTime get endOfWeek =>
      add(Duration(days: DateTime.sunday - weekday)).endOfDay;

  /// Returns the first day of this date's month.
  DateTime get startOfMonth => DateTime(year, month);

  /// Returns the last moment of this date's month.
  DateTime get endOfMonth =>
      DateTime(year, month + 1).subtract(const Duration(milliseconds: 1));

  /// Returns the first day of this date's year.
  DateTime get startOfYear => DateTime(year);

  /// Returns the last moment of this date's year.
  DateTime get endOfYear =>
      DateTime(year + 1).subtract(const Duration(milliseconds: 1));

  // ─── Calendar Info ───────────────────────────────────────────────────────────

  /// Returns `true` if this year is a leap year.
  bool get isLeapYear {
    if (year % 4 != 0) return false;
    if (year % 100 != 0) return true;
    if (year % 400 != 0) return false;
    return true;
  }

  /// Returns the quarter of the year (1–4).
  ///
  /// ```dart
  /// DateTime(2024, 5, 1).quarterOfYear // 2
  /// ```
  int get quarterOfYear => ((month - 1) ~/ 3) + 1;

  /// Returns the ISO 8601 week number (1–53).
  int get weekOfYear {
    final dayOfYear = difference(DateTime(year)).inDays + 1;
    final woy = (dayOfYear - weekday + 10) ~/ 7;
    if (woy < 1) return _weeksInYear(year - 1);
    if (woy > _weeksInYear(year)) return 1;
    return woy;
  }

  int _weeksInYear(int y) {
    final p = (y + y ~/ 4 - y ~/ 100 + y ~/ 400) % 7;
    return p == 4 || (p - 1) == 3 ? 53 : 52;
  }

  /// Returns the age in whole years from this date to now.
  ///
  /// ```dart
  /// DateTime(1990, 5, 15).age // 33 (in 2024)
  /// ```
  int get age {
    final now = DateTime.now();
    var years = now.year - year;
    if (now.month < month || (now.month == month && now.day < day)) {
      years--;
    }
    return years;
  }

  /// Returns the season for this date (Northern Hemisphere).
  String get season {
    if ((month == 3 && day >= 20) ||
        month == 4 ||
        month == 5 ||
        (month == 6 && day < 21)) {
      return 'Spring';
    }
    if ((month == 6 && day >= 21) ||
        month == 7 ||
        month == 8 ||
        (month == 9 && day < 23)) {
      return 'Summer';
    }
    if ((month == 9 && day >= 23) ||
        month == 10 ||
        month == 11 ||
        (month == 12 && day < 21)) {
      return 'Autumn';
    }
    return 'Winter';
  }

  // ─── Arithmetic ──────────────────────────────────────────────────────────────

  /// Returns the number of days until [other] (negative if [other] is past).
  int daysUntil(DateTime other) => other.difference(this).inDays;

  /// Returns the number of hours until [other].
  int hoursUntil(DateTime other) => other.difference(this).inHours;

  /// Returns the number of days until the end of the year.
  int daysUntilEndOfYear() => endOfYear.difference(startOfDay).inDays;

  /// Adds [n] working days (Mon–Fri) to this date.
  ///
  /// ```dart
  /// DateTime(2024, 1, 5).addWorkdays(3) // 2024-01-10 (skips weekend)
  /// ```
  DateTime addWorkdays(int n) {
    var result = this;
    var remaining = n.abs();
    final direction = n >= 0 ? 1 : -1;
    while (remaining > 0) {
      result = result.add(Duration(days: direction));
      if (result.isWeekday) remaining--;
    }
    return result;
  }

  /// Returns the next occurrence of [weekday] (1=Mon … 7=Sun) after this date.
  DateTime nextWeekday(int targetWeekday) {
    var result = add(const Duration(days: 1));
    while (result.weekday != targetWeekday) {
      result = result.add(const Duration(days: 1));
    }
    return result;
  }

  // ─── Formatting ──────────────────────────────────────────────────────────────

  /// Returns a human-readable relative time string.
  ///
  /// ```dart
  /// someDate.timeAgo() // '3 hours ago' / 'just now' / 'in 2 days'
  /// ```
  String timeAgo({DateTime? from}) {
    final now = from ?? DateTime.now();
    final diff = now.difference(this);
    final future = diff.isNegative;
    final abs = diff.abs();

    String result;
    if (abs.inSeconds < 60) {
      result = 'just now';
    } else if (abs.inMinutes < 60) {
      final m = abs.inMinutes;
      result = '$m ${m == 1 ? 'minute' : 'minutes'}';
    } else if (abs.inHours < 24) {
      final h = abs.inHours;
      result = '$h ${h == 1 ? 'hour' : 'hours'}';
    } else if (abs.inDays < 7) {
      final d = abs.inDays;
      result = '$d ${d == 1 ? 'day' : 'days'}';
    } else if (abs.inDays < 30) {
      final w = abs.inDays ~/ 7;
      result = '$w ${w == 1 ? 'week' : 'weeks'}';
    } else if (abs.inDays < 365) {
      final mo = abs.inDays ~/ 30;
      result = '$mo ${mo == 1 ? 'month' : 'months'}';
    } else {
      final y = abs.inDays ~/ 365;
      result = '$y ${y == 1 ? 'year' : 'years'}';
    }

    if (result == 'just now') return result;
    return future ? 'in $result' : '$result ago';
  }

  /// Formats this date using a simple pattern.
  ///
  /// Supported tokens: `yyyy`, `yy`, `MM`, `M`, `dd`, `d`,
  /// `HH`, `H`, `mm`, `ss`, `EEE` (weekday abbr), `EEEE` (weekday full),
  /// `MMM` (month abbr), `MMMM` (month full).
  ///
  /// ```dart
  /// DateTime(2024, 3, 5).format('dd MMM yyyy') // '05 Mar 2024'
  /// ```
  String format(String pattern) {
    const weekdayAbbr = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    const weekdayFull = [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday',
    ];
    const monthAbbr = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    const monthFull = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];

    // Scan the pattern left-to-right, matching the longest token first.
    final tokenRe = RegExp(
      r'yyyy|yy|MMMM|MMM|MM|M|dd|d|HH|H|mm|ss|EEEE|EEE|.',
    );
    return pattern.replaceAllMapped(tokenRe, (m) {
      switch (m[0]) {
        case 'yyyy':
          return year.toString().padLeft(4, '0');
        case 'yy':
          return (year % 100).toString().padLeft(2, '0');
        case 'MMMM':
          return monthFull[month - 1];
        case 'MMM':
          return monthAbbr[month - 1];
        case 'MM':
          return month.toString().padLeft(2, '0');
        case 'M':
          return month.toString();
        case 'dd':
          return day.toString().padLeft(2, '0');
        case 'd':
          return day.toString();
        case 'HH':
          return hour.toString().padLeft(2, '0');
        case 'H':
          return hour.toString();
        case 'mm':
          return minute.toString().padLeft(2, '0');
        case 'ss':
          return second.toString().padLeft(2, '0');
        case 'EEEE':
          return weekdayFull[weekday - 1];
        case 'EEE':
          return weekdayAbbr[weekday - 1];
        default:
          return m[0]!;
      }
    });
  }

  /// Returns a UTC ISO 8601 string suitable for API payloads.
  String get toUtcIso8601 => toUtc().toIso8601String();
}
