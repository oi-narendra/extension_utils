import 'package:flutter_test/flutter_test.dart';
import 'package:extension_utils/datetime_utils.dart';

void main() {
  group('DateTimeUtils', () {
    // ─── Relative Predicates ─────────────────────────────────────────────────
    group('isToday / isYesterday / isTomorrow', () {
      test('isToday', () => expect(DateTime.now().isToday, isTrue));
      test(
          'isYesterday',
          () => expect(
              DateTime.now().subtract(const Duration(days: 1)).isYesterday,
              isTrue));
      test(
          'isTomorrow',
          () => expect(
              DateTime.now().add(const Duration(days: 1)).isTomorrow, isTrue));
    });

    group('isPast / isFuture', () {
      test('past date isPast', () => expect(DateTime(2000).isPast, isTrue));
      test('future date isFuture',
          () => expect(DateTime(2099).isFuture, isTrue));
    });

    // ─── Comparison ─────────────────────────────────────────────────────────
    group('isSameDay', () {
      test(
          'same day',
          () => expect(
              DateTime(2024, 3, 15).isSameDay(DateTime(2024, 3, 15, 10, 30)),
              isTrue));
      test(
          'different day',
          () => expect(
              DateTime(2024, 3, 15).isSameDay(DateTime(2024, 3, 16)), isFalse));
    });

    group('isBetween', () {
      final start = DateTime(2024);
      final end = DateTime(2024, 12, 31);
      test('date within range',
          () => expect(DateTime(2024, 6, 15).isBetween(start, end), isTrue));
      test('date at start', () => expect(start.isBetween(start, end), isTrue));
      test('date outside range',
          () => expect(DateTime(2023, 12, 31).isBetween(start, end), isFalse));
    });

    // ─── Time of Day ────────────────────────────────────────────────────────
    group('isMorning / isAfternoon / isEvening / isNight', () {
      test('morning at 9am',
          () => expect(DateTime(2024, 1, 1, 9).isMorning, isTrue));
      test('afternoon at 2pm',
          () => expect(DateTime(2024, 1, 1, 14).isAfternoon, isTrue));
      test('evening at 8pm',
          () => expect(DateTime(2024, 1, 1, 20).isEvening, isTrue));
      test('night at 11pm',
          () => expect(DateTime(2024, 1, 1, 23).isNight, isTrue));
    });

    // ─── Week / Weekend ──────────────────────────────────────────────────────
    group('isWeekend / isWeekday', () {
      test('Saturday is weekend',
          () => expect(DateTime(2024, 3, 16).isWeekend, isTrue)); // Saturday
      test('Monday is weekday',
          () => expect(DateTime(2024, 3, 18).isWeekday, isTrue)); // Monday
    });

    // ─── Boundaries ─────────────────────────────────────────────────────────
    group('startOfDay / endOfDay', () {
      final date = DateTime(2024, 3, 15, 10, 30, 45);
      test('startOfDay', () => expect(date.startOfDay, DateTime(2024, 3, 15)));
      test('endOfDay',
          () => expect(date.endOfDay, DateTime(2024, 3, 15, 23, 59, 59, 999)));
    });

    group('startOfWeek / endOfWeek', () {
      // 2024-03-15 is a Friday
      final friday = DateTime(2024, 3, 15);
      test('startOfWeek is Monday',
          () => expect(friday.startOfWeek.weekday, DateTime.monday));
      test('endOfWeek is Sunday',
          () => expect(friday.endOfWeek.weekday, DateTime.sunday));
    });

    group('startOfMonth / endOfMonth', () {
      final date = DateTime(2024, 3, 15);
      test('startOfMonth', () => expect(date.startOfMonth, DateTime(2024, 3)));
      test('endOfMonth day', () => expect(date.endOfMonth.day, 31));
    });

    group('startOfYear / endOfYear', () {
      final date = DateTime(2024, 6, 15);
      test('startOfYear', () => expect(date.startOfYear, DateTime(2024)));
      test('endOfYear month', () => expect(date.endOfYear.month, 12));
    });

    // ─── Calendar Info ───────────────────────────────────────────────────────
    group('isLeapYear', () {
      test(
          '2024 is leap year', () => expect(DateTime(2024).isLeapYear, isTrue));
      test('2023 is not leap year',
          () => expect(DateTime(2023).isLeapYear, isFalse));
      test('1900 is not leap year',
          () => expect(DateTime(1900).isLeapYear, isFalse));
      test(
          '2000 is leap year', () => expect(DateTime(2000).isLeapYear, isTrue));
    });

    group('quarterOfYear', () {
      test('Q1 (January)', () => expect(DateTime(2024).quarterOfYear, 1));
      test('Q2 (April)', () => expect(DateTime(2024, 4).quarterOfYear, 2));
      test('Q3 (July)', () => expect(DateTime(2024, 7).quarterOfYear, 3));
      test('Q4 (October)', () => expect(DateTime(2024, 10).quarterOfYear, 4));
    });

    group('age', () {
      test('age calculation', () {
        final birthdate = DateTime(DateTime.now().year - 25);
        expect(birthdate.age, 25);
      });
    });

    group('season', () {
      test('Spring (April)',
          () => expect(DateTime(2024, 4, 15).season, 'Spring'));
      test('Summer (July)',
          () => expect(DateTime(2024, 7, 15).season, 'Summer'));
      test('Autumn (October)',
          () => expect(DateTime(2024, 10, 15).season, 'Autumn'));
      test('Winter (January)',
          () => expect(DateTime(2024, 1, 15).season, 'Winter'));
    });

    // ─── Arithmetic ──────────────────────────────────────────────────────────
    group('addWorkdays', () {
      // 2024-01-05 is a Friday
      test('adds workdays skipping weekend', () {
        final friday = DateTime(2024, 1, 5);
        final result = friday.addWorkdays(1);
        expect(result.weekday, DateTime.monday);
      });
      test('adds 5 workdays', () {
        final monday = DateTime(2024, 1, 8); // Monday
        final result = monday.addWorkdays(5);
        expect(result.weekday, DateTime.monday); // next Monday
      });
    });

    group('nextWeekday', () {
      test('next Monday from Friday', () {
        final friday = DateTime(2024, 1, 5);
        expect(friday.nextWeekday(DateTime.monday).weekday, DateTime.monday);
      });
    });

    group('daysUntil', () {
      test('positive days', () {
        final today = DateTime(2024);
        final future = DateTime(2024, 1, 11);
        expect(today.daysUntil(future), 10);
      });
    });

    // ─── Formatting ──────────────────────────────────────────────────────────
    group('timeAgo', () {
      test('just now', () {
        final now = DateTime.now();
        expect(now.timeAgo(), 'just now');
      });
      test('minutes ago', () {
        final past = DateTime.now().subtract(const Duration(minutes: 5));
        expect(past.timeAgo(), '5 minutes ago');
      });
      test('hours ago', () {
        final past = DateTime.now().subtract(const Duration(hours: 2));
        expect(past.timeAgo(), '2 hours ago');
      });
      test('in the future', () {
        final future = DateTime.now().add(const Duration(hours: 3, minutes: 1));
        expect(future.timeAgo(), 'in 3 hours');
      });
    });

    group('format', () {
      final date = DateTime(2024, 3, 5, 14, 30, 45);
      test('yyyy-MM-dd', () => expect(date.format('yyyy-MM-dd'), '2024-03-05'));
      test('dd MMM yyyy',
          () => expect(date.format('dd MMM yyyy'), '05 Mar 2024'));
      test('HH:mm:ss', () => expect(date.format('HH:mm:ss'), '14:30:45'));
      test('MMMM', () => expect(date.format('MMMM'), 'March'));
      test('EEE', () => expect(date.format('EEE'), 'Tue'));
    });
  });
}
