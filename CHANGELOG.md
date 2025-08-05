## 1.1.0

- Introduced `DateCheckerExtensions` extension with many additional helper methods on `DateTime`, including:
  - `startOfDay`/`endOfDay`, `startOfMonth`/`endOfMonth`, `startOfYear`/`endOfYear` for easy boundary calculations.
  - `weekNumber`, `quarter`, `semester`, `dayOfYear` and `daysInMonth` getters for period information.
  - Configurable `weekStart`/`weekEnd` methods with optional first day of week parameter.
  - `isWeekend`, `isWeekday` and `isLeapYear` convenience checks.
  - Range comparators such as `isThisYear`, `isNextYear`, `isLastYear`, `isNextMonth`, `isLastMonth`, `isPast` and `isFuture`.
  - Equality checks `isSameDay`, `isSameWeek`, `isSameMonth`, `isSameYear` and `isWithinRange`.
  - Arithmetic helpers `addDays`, `addWeeks`, `addMonths` and `addYears` for date math.
- Updated public API to export the new extension.
- Relaxed SDK constraint to `>=2.12.0 <4.0.0` to support Dart 3.
- Bumped package version to `1.1.0`.

## 1.0.0+2
- Removed dependency on `intl` package
- Replaced deprecated `pedantic` package with recommended `lints`

## 1.0.0+1

- Updated README and adding pub.dev badge

## 1.0.0

- Initial release to pub.dev
