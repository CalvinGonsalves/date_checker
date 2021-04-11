# :date: Date Checker

[![pub package](https://img.shields.io/pub/v/date_checker.svg)](https://pub.dev/packages/date_checker)
[![Dart](https://github.com/CalvinGonsalves/date_checker/actions/workflows/dart.yml/badge.svg?branch=main)](https://github.com/CalvinGonsalves/date_checker/actions/workflows/dart.yml)

Convenient extension methods on DateTime to check if a date is today, this week, last week and so on, plus some other helpful utility mehods.

## Usage

### weekStart
Returns the beginning of the week in which _date_ is present

```dart
var moonLanding = DateTime.parse("1969-07-20 20:18:04Z");
moonLanding.weekday == DateTime.sunday  // true

// 1969-07-14 00:00:00.000
weekStart(date: moonLanding);   

// 1969-07-20 00:00:00.000
weekStart(date: moonLanding, isMondayStartOfWeek: false)   
```

### weekEnd
Returns the end of the week in which _date_ is present

```dart
var moonLanding = DateTime.parse("1969-07-20 20:18:04Z");

// 1969-07-20 23:59:59.999999
weekEnd(date: moonLanding);

// 1969-07-26 23:59:59.999999
weekEnd(date: moonLanding, isMondayStartOfWeek: false)

DateTime(1969, 7, 26).weekday == DateTime.saturday //true
```
If _date_ is not specified, `DateTime.now()` is considered i.e. the start/end of the current week will be returned.

If _isMondayStartOfWeek_ is not specified, defaulting to true the start/end will follow ISO 8601 and the week will be of the form [Monday...Sunday] or setting it to false will return in the form of [Sunday...Saturday]

## Extension on DateTime

Extension Method | Description
---------------- | ----------------
isToday | Returns true if date is today
isTomorrow | Returns true if date is tomorrow
isYesterday | Returns true if date is yesterday
isLastWeek | Returns true if date is from last week
isThisWeek | Returns true if date is from current week
isNextWeek | Returns true if date is from following week
isThisMonth | Returns true if date is present in current month

By default, **isLastWeek** and **isThisWeek** will return the result based on [Monday...Sunday] format. If the Sunday is desired as the first day of the week, use the setter `sundayAsStartOfWeek`to acheive the result based on [Sunday...Saturday] week format.

A simple usage example:

```dart
import 'package:date_checker/date_checker.dart';

void main() {
  var date = DateTime.now();

  final isToday = date.isToday; //true
}
```

## Features and bugs

Please file feature requests and bugs at the [issue tracker][tracker].

[tracker]: https://github.com/CalvinGonsalves/date_checker/issues
