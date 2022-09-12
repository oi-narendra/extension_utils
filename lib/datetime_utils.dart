extension DateTimeUtils on DateTime {
  /// Returns `true` if the date is today, `false` otherwise.
  bool get isToday => isSameDay(DateTime.now());

  /// Returns `true` if the date is yesterday, `false` otherwise.
  bool get isYesterday =>
      isSameDay(DateTime.now().subtract(const Duration(days: 1)));

  /// Returns `true` if the date is tomorrow, `false` otherwise.
  bool get isTomorrow => isSameDay(DateTime.now().add(const Duration(days: 1)));

  /// Returns `true` if the date is in the past, `false` otherwise.
  bool get isPast => isBefore(DateTime.now());

  /// Returns `true` if the date is in the future, `false` otherwise.
  bool get isFuture => isAfter(DateTime.now());

  /// Returns `true` if the date is in the same day as [other], `false` otherwise.
  bool isSameDay(DateTime other) =>
      year == other.year && month == other.month && day == other.day;

  /// Returns `true` if the date is in the same month as [other], `false` otherwise.
  bool isSameMonth(DateTime other) =>
      year == other.year && month == other.month;

  /// Returns `true` if the date is in the same year as [other], `false` otherwise.
  bool isSameYear(DateTime other) => year == other.year;

  /// Returns `true` if the date is in the same hour as [other], `false` otherwise.
  bool isSameHour(DateTime other) =>
      year == other.year &&
      month == other.month &&
      day == other.day &&
      hour == other.hour;

  /// Returns `true` if the date is in the same minute as [other], `false` otherwise.
  bool isSameMinute(DateTime other) =>
      year == other.year &&
      month == other.month &&
      day == other.day &&
      hour == other.hour &&
      minute == other.minute;

  /// Returns `true` if the date is in the same second as [other], `false` otherwise.
  bool isSameSecond(DateTime other) =>
      year == other.year &&
      month == other.month &&
      day == other.day &&
      hour == other.hour &&
      minute == other.minute &&
      second == other.second;

  /// Returns `true` if the date is in the same millisecond as [other], `false` otherwise.
  bool isSameMillisecond(DateTime other) =>
      year == other.year &&
      month == other.month &&
      day == other.day &&
      hour == other.hour &&
      minute == other.minute &&
      second == other.second &&
      millisecond == other.millisecond;

  /// Return `true` if the date is ahead of [other] by [days], `false` otherwise.
  bool isAheadByDays(DateTime other, int days) =>
      difference(other).inDays >= days;

  /// Return `true` if the date is behind of [other] by [days], `false` otherwise.
  bool isBehindByDays(DateTime other, int days) =>
      difference(other).inDays <= -days;

  /// Return `true` if is morning, `false` otherwise.
  /// Morning is defined as between 5am and 12pm.
  bool get isMorning => hour >= 6 && hour < 12;

  /// Return `true` if is afternoon, `false` otherwise.
  /// Afternoon is defined as 12:00 to 17:59.
  bool get isAfternoon => hour >= 12 && hour < 18;

  /// Return `true` if is evening, `false` otherwise.
  /// Evening is between 18 and 22.
  bool get isEvening => hour >= 18 && hour < 23;

  /// Return `true` if is night, `false` otherwise.
  /// Night is between 23 and 5.
  bool get isNight => hour >= 23 || hour < 6;

  /// Return `true` if is weekend, `false` otherwise.
  bool get isWeekend =>
      weekday == DateTime.saturday || weekday == DateTime.sunday;

  /// Return `true` if is weekday, `false` otherwise.
  bool get isWeekday => !isWeekend;

  /// Return `true` if is holiday, `false` otherwise.
  /// Holidays are defined as Saturday and Sunday.
  bool get isHoliday => isWeekend;

  /// Days until [other].
  /// If [other] is in the past, the result will be negative.
  int daysUntil(DateTime other) => difference(other).inDays;

  /// Hours until [other].
  /// If [other] is in the past, the result will be negative.
  int hoursUntil(DateTime other) => difference(other).inHours;

  /// Days until end of year.
  int daysUntilEndOfYear() => DateTime(year + 1).daysUntil(this);

  /// Return `Season` of the date.
  /// Seasons are defined as:
  /// - Spring: March 20 - June 20
  /// - Summer: June 21 - September 22
  /// - Autumn: September 23 - December 20
  /// - Winter: December 21 - March 19

  String get season {
    if (month >= 3 && month <= 6) {
      if (month == 6 && day >= 21 || month == 3 && day <= 19) {
        return 'Spring';
      } else if (month == 6 && day <= 20 || month == 3 && day >= 20) {
        return 'Summer';
      }
    } else if (month >= 6 && month <= 9) {
      if (month == 9 && day >= 23 || month == 6 && day <= 20) {
        return 'Summer';
      } else if (month == 9 && day <= 22 || month == 6 && day >= 21) {
        return 'Autumn';
      }
    } else if (month >= 9 && month <= 12) {
      if (month == 12 && day >= 21 || month == 9 && day <= 22) {
        return 'Autumn';
      } else if (month == 12 && day <= 20 || month == 9 && day >= 23) {
        return 'Winter';
      }
    } else if (month >= 1 && month <= 3) {
      if (month == 3 && day >= 20 || month == 12 && day <= 20) {
        return 'Winter';
      } else if (month == 3 && day <= 19 || month == 12 && day >= 21) {
        return 'Spring';
      }
    }
    return '';
  }

  /// Return `true` if is in [season], `false` otherwise.
  bool isInSeason(String season) => this.season == season;

  /// Return `true` if is leap year, `false` otherwise.
  bool get isLeapYear {
    if (year % 4 != 0) {
      return false;
    } else if (year % 100 != 0) {
      return true;
    } else if (year % 400 != 0) {
      return false;
    } else {
      return true;
    }
  }

  /// Return days until the weekend.
  /// If the date is in the weekend, the result will be 0.
  int daysUntilWeekend() {
    if (isWeekend) {
      return 0;
    } else {
      return DateTime.saturday - weekday;
    }
  }
}
