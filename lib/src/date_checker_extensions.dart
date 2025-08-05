import 'dart:math' as math;

/// Additional date utilities for [DateTime].
///
/// These extension methods supplement the existing DateChecker helpers by
/// providing convenient getters for boundaries of days, weeks, months and years,
/// as well as comparisons and arithmetic.
extension DateCheckerExtensions on DateTime {
  /// Returns a new [DateTime] at midnight at the start of the day.
  DateTime get startOfDay => DateTime(year, month, day);

  /// Returns a new [DateTime] at the very end of the day (23:59:59.999).
  DateTime get endOfDay => DateTime(year, month, day, 23, 59, 59, 999);

  /// Returns the first moment of the month containing this date.
  DateTime get startOfMonth => DateTime(year, month, 1);

  /// Returns the last moment of the month containing this date.
  DateTime get endOfMonth => DateTime(year, month + 1, 0, 23, 59, 59, 999);

  /// Returns the first moment of the year containing this date.
  DateTime get startOfYear => DateTime(year, 1, 1);

  /// Returns the last moment of the year containing this date.
  DateTime get endOfYear => DateTime(year + 1, 1, 0, 23, 59, 59, 999);

  /// Returns the ISO-8601 week number for this date.
  ///
  /// The first week of the year is defined as the week containing
  /// the first Thursday. Weeks start on Monday.
  int get weekNumber {
    final weekThursday = this.add(Duration(days: 4 - (weekday == DateTime.sunday ? 7 : weekday)));
    final firstThursday = DateTime(weekThursday.year, 1, 4);
    final diff = weekThursday.difference(firstThursday).inDays;
    return (diff ~/ 7) + 1;
  }

  /// Returns the quarter of the year (1-4) for this date.
  int get quarter => ((month - 1) ~/ 3) + 1;

  /// Returns the half-year (1 for Jan-Jun, 2 for Jul-Dec).
  int get semester => ((month - 1) ~/ 6) + 1;

  /// Returns the ordinal day of the year (1-366).
  int get dayOfYear => difference(DateTime(year, 1, 1)).inDays + 1;

  /// Returns the number of days in the month of this date.
  int get daysInMonth {
    final beginningNextMonth = month < 12 ? DateTime(year, month + 1, 1) : DateTime(year + 1, 1, 1);
    final lastDay = beginningNextMonth.subtract(const Duration(days: 1));
    return lastDay.day;
  }

  /// Whether this date falls on a weekend (Saturday or Sunday).
  bool get isWeekend => weekday == DateTime.saturday || weekday == DateTime.sunday;

  /// Whether this date falls on a weekday (Monday-Friday).
  bool get isWeekday => !isWeekend;

  /// Whether the year of this date is a leap year.
  bool get isLeapYear {
    final y = year;
    return (y % 4 == 0) && ((y % 100 != 0) || (y % 400 == 0));
  }

  /// Returns the first day of the week containing this date.
  ///
  /// The [firstDayOfWeek] can be any integer from Monday (1) through Sunday (7).
  /// Defaults to Monday.
  DateTime weekStart([int firstDayOfWeek = DateTime.monday]) {
    int diff = (weekday - firstDayOfWeek) % 7;
    if (diff < 0) diff += 7;
    return DateTime(year, month, day).subtract(Duration(days: diff));
  }

  /// Returns the last day of the week containing this date.
  ///
  /// The [firstDayOfWeek] can be any integer from Monday (1) through Sunday (7).
  /// Defaults to Monday.
  DateTime weekEnd([int firstDayOfWeek = DateTime.monday]) {
    return weekStart(firstDayOfWeek).add(const Duration(days: 7)).subtract(const Duration(milliseconds: 1));
  }

  /// Returns true if this date is in the same calendar day as [other].
  bool isSameDay(DateTime other) =>
      year == other.year && month == other.month && day == other.day;

  /// Returns true if this date is in the same calendar week as [other].
  ///
  /// Weeks are compared based on [firstDayOfWeek] (defaults to Monday).
  bool isSameWeek(DateTime other, [int firstDayOfWeek = DateTime.monday]) =>
      weekStart(firstDayOfWeek) == other.weekStart(firstDayOfWeek);

  /// Returns true if this date is in the same calendar month as [other].
  bool isSameMonth(DateTime other) =>
      year == other.year && month == other.month;

  /// Returns true if this date is in the same calendar year as [other].
  bool isSameYear(DateTime other) => year == other.year;

  /// Returns true if this date falls strictly within the inclusive range
  /// defined by [start] and [end].
  bool isWithinRange(DateTime start, DateTime end) =>
      !isBefore(start) && !isAfter(end);

  /// Returns true if this date is before the current moment.
  bool get isPast => isBefore(DateTime.now());

  /// Returns true if this date is after the current moment.
  bool get isFuture => isAfter(DateTime.now());

  /// Returns a new [DateTime] with [days] added.
  DateTime addDays(int days) => add(Duration(days: days));

  /// Returns a new [DateTime] with [weeks] added.
  DateTime addWeeks(int weeks) => add(Duration(days: 7 * weeks));

  /// Returns a new [DateTime] with [months] added.
  ///
  /// If the resulting day does not exist in the new month, it will be clamped
  /// to the last valid day.
  DateTime addMonths(int monthsToAdd) {
    int newYear = year + ((month - 1 + monthsToAdd) ~/ 12);
    int newMonth = ((month - 1 + monthsToAdd) % 12) + 1;
    int newDay = math.min(day, DateTime(newYear, newMonth + 1, 0).day);
    return DateTime(newYear, newMonth, newDay, hour, minute, second, millisecond, microsecond);
  }

  /// Returns a new [DateTime] with [years] added.
  ///
  /// If the resulting date does not exist in the new year (e.g. Feb 29), it
  /// will be clamped to Feb 28 in a non‑leap year.
  DateTime addYears(int yearsToAdd) {
    int newYear = year + yearsToAdd;
    int newDay = day;
    if (month == 2 && day == 29 && !((newYear % 4 == 0) && ((newYear % 100 != 0) || (newYear % 400 == 0)))) {
      newDay = 28;
    }
    return DateTime(newYear, month, newDay, hour, minute, second, millisecond, microsecond);
  }

  /// Whether this date refers to the current calendar year.
  bool get isThisYear => year == DateTime.now().year;

  /// Whether this date refers to the next calendar year.
  bool get isNextYear => year == DateTime.now().year + 1;

  /// Whether this date refers to the previous calendar year.
  bool get isLastYear => year == DateTime.now().year - 1;

  /// Whether this date refers to the next calendar month.
  bool get isNextMonth {
    final now = DateTime.now();
    if (year == now.year && month == now.month + 1) return true;
    if (now.month == 12 && year == now.year + 1 && month == 1) return true;
    return false;
  }

  /// Whether this date refers to the previous calendar month.
  bool get isLastMonth {
    final now = DateTime.now();
    if (year == now.year && month == now.month - 1) return true;
    if (now.month == 1 && year == now.year - 1 && month == 12) return true;
    return false;
  }
}
