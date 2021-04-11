import 'dart:math';
import 'package:date_checker/date_checker.dart';
import 'package:test/test.dart';

void main() {
  final moonLandindDate = DateTime.parse('1969-07-20 20:18:04Z');
  final now = DateTime.now();

  test('It should expect the first day of the week', () {
    expect(weekStart(date: moonLandindDate), DateTime(1969, 7, 14));
  });

  test('It should expect the last day of the week', () {
    expect(weekEnd(date: moonLandindDate),
        DateTime(1969, 7, 20, 23, 59, 59, 999, 999));
  });

  test('It should handle todays date', () {
    expect(now.isToday, true);
  });

  test('It should handle tommorrows date', () {
    final tommorrow = now.add(const Duration(days: 1));
    expect(tommorrow.isTomorrow, true);
  });

  test('It should handle yesterdays date', () {
    final yesterday = now.subtract(const Duration(days: 1));
    expect(yesterday.isYesterday, true);
  });

  test('It should handle date in this week', () {
    //generates a random date from this week
    final thisWeek = now
        .subtract(Duration(days: now.weekday))
        .add(Duration(days: Random().nextInt(7) + 1));
    // print(thisWeek);
    expect(thisWeek.isThisWeek, true);
  });

  test('It should handle date in last week', () {
    //generates a random date from last week

    final lastWeek = now
        .subtract(Duration(days: now.weekday))
        .subtract(Duration(days: Random().nextInt(7)));

    // print(lastWeek);
    expect(lastWeek.isLastWeek, true);
  });

  test('It should handle date in next week', () {
    final nextWeek = DateTime(now.year, now.month, now.day)
        .subtract(Duration(days: now.weekday))
        .add(Duration(days: 8 + Random().nextInt(7)));

    expect(nextWeek.isNextWeek, true);
  });

  test('It should handle date in this month', () {
    expect(now.isThisMonth, true);
  });
}
