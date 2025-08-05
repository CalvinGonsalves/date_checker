import 'date_checker_extensions.dart';

/// Additional date extension utilities supplementing the existing DateChecker extensions.
///
/// This extension adds helpers such as a [halfYear] alias, quarter comparison,
/// start/end of week getters, and a check for the current month.
extension AdditionalDateCheckerExtensions on DateTime {
  /// Returns the half of the year (1 for Jan–Jun, 2 for Jul–Dec).
  ///
  /// Equivalent to [DateCheckerExtensions.semester], but provided as a more
  /// intuitive alias.
  int get halfYear => ((month - 1) ~/ 6) + 1;

  /// Returns true if this date is in the same quarter of the same year as [other].
  bool isSameQuarter(DateTime other) =>
      year == other.year && ((month - 1) ~/ 3) == ((other.month - 1) ~/ 3);

  /// Returns a new [DateTime] at the beginning of the week containing this date.
  ///
  /// By default the first day of the week is Monday (`DateTime.monday`). You can
  /// override [firstDayOfWeek] (0–6 where 0=Sunday).
  DateTime startOfWeek({int firstDayOfWeek = DateTime.monday}) =>
      weekStart(firstDayOfWeek);

  /// Returns a new [DateTime] at the end of the week containing this date.
  ///
  /// By default the first day of the week is Monday (`DateTime.monday`). You can
  /// override [firstDayOfWeek] (0–6 where 0=Sunday).
  DateTime endOfWeek({int firstDayOfWeek = DateTime.monday}) =>
      weekEnd(firstDayOfWeek);

  /// Returns true if this date is in the current calendar month.
  bool get isThisMonth {
    final now = DateTime.now();
    return year == now.year && month == now.month;
  }
}
