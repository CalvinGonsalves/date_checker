import 'package:intl/intl.dart';

///Returns the first day of the week in which [date] is present. If [date] is
///not provided,
///the current day `DateTime.now()` is considered.
///
///```
///var moonLanding = DateTime.parse("1969-07-20 20:18:04Z");
///assert(weekStart(date: moonLanding) == DateTime(1969, 7, 14));
///assert(weekStart(date: moonLanding).weekday == DateTime.monday)
///
///```
///
///In accordance with ISO 8601 a week starts with Monday.
///By default the week will start with Monday unless [isMondayStartOfWeek] is
///set to false
///then week starts with Sunday.
///
///```
///assert(weekStart(date: moonLanding, isMondayStartOfWeek: false) ==
///        DateTime(1969, 7, 20),);
///assert(
///     weekStart(
///           date: moonLanding,
///           isMondayStartOfWeek: false,
///         ).weekday ==
///         DateTime.sunday,
///   );
///```

DateTime weekStart({DateTime? date, bool isMondayStartOfWeek = true}) {
  date = date?.toLocal() ?? DateTime.now().toLocal();
  var startOfWeek = DateTime(date.year, date.month, date.day);
  var weekDay =
      isMondayStartOfWeek ? startOfWeek.weekday : 1 + startOfWeek.weekday % 7;
  startOfWeek = startOfWeek.subtract(
    Duration(
      days: weekDay - 1,
    ),
  );

  return startOfWeek;
}

///Returns the last day of the week in which [date] is present. If [date] is not
///provided,the current day `DateTime.now()` is considered.
///
///```
///var moonLanding = DateTime.parse("1969-07-20 20:18:04Z");
///assert(weekEnd(date: moonLanding) == DateTime(1969, 7, 20, 23, 59, 59, 999));
///assert(weekEnd(date: moonLanding).weekday == DateTime.sunday)
///```
///
///In accordance with ISO 8601 a week ends with Sunday.
///By default the week will end with Sunday unless [isMondayStartOfWeek] is set
///to false then week ends with Saturday.
///
///```
///assert(weekEnd(date: moonLanding, isMondayStartOfWeek: false) ==
///        DateTime(1969, 7, 26, 23, 59, 59, 999),);
///assert(weekEnd(date: moonLanding, isMondayStartOfWeek: false).weekday ==
///        DateTime.saturday,)
///```
///
DateTime weekEnd({DateTime? date, bool isMondayStartOfWeek = true}) {
  date = date?.toLocal() ?? DateTime.now().toLocal();
  var endOFWeek =
      DateTime(date.year, date.month, date.day, 23, 59, 59, 999, 999);

  var weekDay =
      isMondayStartOfWeek ? endOFWeek.weekday : 1 + endOFWeek.weekday % 7;
  endOFWeek = endOFWeek.add(
    Duration(
      days: 7 - weekDay,
    ),
  );

  return endOFWeek;
}

///Sets the start of the week to Sunday if set to true. This affects the result.
///of [isLastWeek] and [isThisWeek]
///
///By default Monday is the start of week.
set sundayAsStartOfWeek(bool sunday) =>
    DateChecker._isMondayStartOfWeek = !sunday;

///Extension methods on DateTime
extension DateChecker on DateTime {
  static bool _isMondayStartOfWeek = true;

  ///Returns true if [this] is current day
  bool get isToday {
    final date = toLocal();
    final now = DateTime.now();
    final diffDays = date.difference(now).inDays;
    final isSameAsToday = (diffDays == 0 && date.day == now.day);
    return isSameAsToday;
  }

  ///Returns true if [this] is the next day
  bool get isTomorrow {
    final date = toLocal();
    final now = DateTime.now();

    return DateTime(now.year, now.month, now.day + 1) ==
        (DateTime(date.year, date.month, date.day));
  }

  ///Returns true if [this] is the previous day
  bool get isYesterday {
    final date = toLocal();
    final now = DateTime.now();

    return DateTime(now.year, now.month, now.day - 1) ==
        (DateTime(date.year, date.month, date.day));
  }

  ///Returns true if [this] is in last week
  bool get isLastWeek {
    final date = toLocal();

    final weekStartDate = weekStart(
      isMondayStartOfWeek: _isMondayStartOfWeek,
    );

    return (date.isAfter(
          weekStartDate.subtract(const Duration(days: 7, microseconds: 1)),
        ) &&
        date.isBefore(
          weekStartDate,
        ));
  }

  ///Returns true if [this] is in current week
  bool get isThisWeek {
    final date = toLocal();

    final weekStartDate = weekStart(isMondayStartOfWeek: _isMondayStartOfWeek);

    return ((date.isAtSameMomentAs(weekStartDate) ||
            date.isAfter(weekStartDate)) &&
        date.isBefore(weekEnd(isMondayStartOfWeek: _isMondayStartOfWeek)
            .add(const Duration(microseconds: 1))));
  }

  ///Returns true if [this] is in next week
  bool get isNextWeek {
    final date = toLocal();

    final weekEndDate = weekEnd(isMondayStartOfWeek: _isMondayStartOfWeek);

    return date.isAfter(weekEndDate) &&
        date.isBefore(
            weekEndDate.add(const Duration(days: 7, microseconds: 1)));
  }

  ///Returs true if [this] is in current month of the current year
  bool get isThisMonth => (DateFormat.yMMMM().format(DateTime.now()) ==
      DateFormat.yMMMM().format(this));
}
