import 'package:test/test.dart';
import 'package:date_checker/date_checker.dart';

void main() {
  group('DateCheckerExtensions', () {
    test('startOfDay and endOfDay', () {
      final d = DateTime(2025, 8, 4, 13, 30, 45);
      expect(d.startOfDay, DateTime(2025, 8, 4));
      expect(d.endOfDay, DateTime(2025, 8, 4, 23, 59, 59, 999));
    });

    test('startOfMonth and endOfMonth', () {
      final d = DateTime(2024, 2, 15); // Leap year February
      expect(d.startOfMonth, DateTime(2024, 2, 1));
      expect(d.endOfMonth, DateTime(2024, 2, 29, 23, 59, 59, 999));
    });

    test('startOfYear and endOfYear', () {
      final d = DateTime(2023, 6, 10);
      expect(d.startOfYear, DateTime(2023, 1, 1));
      expect(d.endOfYear, DateTime(2023, 12, 31, 23, 59, 59, 999));
    });

    test('weekNumber', () {
      // 2020-12-28 is ISO week 53 of 2020 (because 2020 has 53 weeks)
      final d = DateTime(2020, 12, 28);
      expect(d.weekNumber, 53);
      // 2021-01-04 is ISO week 1 of 2021
      final d2 = DateTime(2021, 1, 4);
      expect(d2.weekNumber, 1);
    });

    test('quarter and semester', () {
      expect(DateTime(2025, 1, 1).quarter, 1);
      expect(DateTime(2025, 4, 1).quarter, 2);
      expect(DateTime(2025, 7, 1).quarter, 3);
      expect(DateTime(2025, 10, 1).quarter, 4);
      expect(DateTime(2025, 1, 1).semester, 1);
      expect(DateTime(2025, 7, 1).semester, 2);
    });

    test('dayOfYear and daysInMonth', () {
      expect(DateTime(2023, 1, 1).dayOfYear, 1);
      expect(DateTime(2023, 12, 31).dayOfYear, 365);
      expect(DateTime(2024, 12, 31).dayOfYear, 366);
      expect(DateTime(2025, 2, 1).daysInMonth, 28);
      expect(DateTime(2024, 2, 1).daysInMonth, 29);
    });

    test('isWeekend and isWeekday', () {
      expect(DateTime(2025, 8, 4).isWeekday, true); // Monday
      expect(DateTime(2025, 8, 3).isWeekend, true); // Sunday
    });

    test('isLeapYear', () {
      expect(DateTime(2024, 1, 1).isLeapYear, true);
      expect(DateTime(2025, 1, 1).isLeapYear, false);
    });

    test('weekStart and weekEnd with custom first day', () {
      final d = DateTime(2025, 8, 4); // Monday
      // default first day is Monday
      expect(d.weekStart(), DateTime(2025, 8, 4));
      // Sunday start (DateTime.sunday = 7)
      expect(d.weekStart(DateTime.sunday), DateTime(2025, 8, 3));
      // Week end using Monday start
      expect(
        d.weekEnd(),
        DateTime(2025, 8, 11).subtract(const Duration(milliseconds: 1)),
      );
    });

    test('isSameDay, isSameWeek, isSameMonth, isSameYear', () {
      final a = DateTime(2025, 8, 4);
      final b = DateTime(2025, 8, 4, 23, 59);
      expect(a.isSameDay(b), true);
      final c = DateTime(2025, 8, 6);
      expect(a.isSameWeek(c), true);
      final d = DateTime(2025, 9, 1);
      expect(a.isSameMonth(d), false);
      expect(a.isSameYear(d), true);
    });

    test('isWithinRange', () {
      final date = DateTime(2025, 8, 4);
      final start = DateTime(2025, 8, 1);
      final end = DateTime(2025, 8, 10);
      expect(date.isWithinRange(start, end), true);
      expect(DateTime(2025, 7, 31).isWithinRange(start, end), false);
    });

    test('isPast and isFuture', () {
      final pastDate = DateTime.now().subtract(const Duration(days: 1));
      final futureDate = DateTime.now().add(const Duration(days: 1));
      expect(pastDate.isPast, true);
      expect(futureDate.isFuture, true);
    });

    test('addDays, addWeeks, addMonths, addYears', () {
      final d = DateTime(2025, 1, 31);
      expect(d.addDays(1), DateTime(2025, 2, 1));
      expect(d.addWeeks(4), DateTime(2025, 2, 28));
      expect(d.addMonths(1),
          DateTime(2025, 2, 28, d.hour, d.minute, d.second, d.millisecond, d.microsecond));
      final d2 = DateTime(2024, 12, 31);
      expect(d2.addMonths(2), DateTime(2025, 2, 28, d2.hour, d2.minute, d2.second, d2.millisecond, d2.microsecond));
      final leapDay = DateTime(2024, 2, 29);
      expect(leapDay.addYears(1), DateTime(2025, 2, 28));
    });

    test('isThisYear, isNextYear, isLastYear and isNextMonth, isLastMonth', () {
      final now = DateTime.now();
      final thisYear = DateTime(now.year, 6, 1);
      final nextYear = DateTime(now.year + 1, 1, 1);
      final lastYear = DateTime(now.year - 1, 12, 31);
      expect(thisYear.isThisYear, true);
      expect(nextYear.isNextYear, true);
      expect(lastYear.isLastYear, true);

      final thisMonth = DateTime(now.year, now.month, 1);
      final nextMonth = now.month == 12
          ? DateTime(now.year + 1, 1, 1)
          : DateTime(now.year, now.month + 1, 1);
      final lastMonth = now.month == 1
          ? DateTime(now.year - 1, 12, 1)
          : DateTime(now.year, now.month - 1, 1);
      expect(thisMonth.isThisMonth, true);
      expect(nextMonth.isNextMonth, true);
      expect(lastMonth.isLastMonth, true);
    });
  });
}
