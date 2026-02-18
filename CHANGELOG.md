# Changelog

## 2.0.0

This is a major release with breaking changes. The package has been modernized for Dart 3.x and Flutter 3.19+.

### Breaking Changes

- Minimum SDK is now `Dart >=3.3.0 <4.0.0` and `Flutter >=3.19.0`
- `StringUtils` extension now targets `String` instead of `String?` (anti-pattern removed)
- Removed redundant methods already present in the Dart/Flutter standard library:
  - `String`: `startsWith`, `endsWith`, `charCount`, `isNullOrEmpty`, `isNullOrWhitespace`
  - `num`: `isEven`, `isOdd`, `isNegative`, `clamp`
  - `Map`: `isEmpty` (conflicted with built-in)
- `ListUtils.removeLast(item)` renamed to `removeLastOccurrence(item)` to avoid conflict with the built-in `List.removeLast()`

### New Extensions

#### `bool_utils.dart` (new)

- `toggled` – returns the logical inverse
- `toYesNo`, `toOnOff`, `toEnabledDisabled` – human-readable string representations
- `ifTrue`, `ifFalse` – conditional value helpers
- `when` – pattern-match style dispatch on a bool

#### `uri_utils.dart` (new)

- `appendPath` – appends a path segment
- `withQueryParam`, `withQueryParams` – adds/replaces query parameters
- `removeQueryParam` – removes a specific query parameter
- `isSecure` – checks for `https` scheme
- `hasQueryParams` – checks for presence of query parameters
- `isAbsolute` – checks if the URI is absolute

#### `future_utils.dart` (new)

- `retryFuture<T>()` – top-level function that retries a future factory up to N times
- `withTimeout` – completes with a fallback if the future exceeds a duration
- `withFallback` – returns a fallback value on any error

#### `object_utils.dart` (new)

- Kotlin-style scope functions: `let`, `also`, `takeIf`, `takeUnless`

#### `regexp_utils.dart` (new)

- `RegExpPatterns` class with 14 pre-built patterns: `email`, `url`, `phone`, `ipv4`, `ipv6`, `uuid`, `hexColor`, `creditCard`, `postalCode`, `date`, `time`, `username`, `slug`, `htmlTag`

#### `color_utils.dart` (new)

- `isLight`, `isDark`, `luminance`, `contrastColor`
- `lighten`, `darken`, `withHue`, `withSaturation`, `withLightness`
- `mix`, `complementary`, `grayscale`
- `analogous`, `triadic`, `tetradic`
- `toHex`, `toMaterialColor`
- `contrastRatio`, `splitComplementary`, `withOpacityPercent`, `isAccessibleOn`, `shade`, `tint`

#### `iterable_utils.dart` (new)

- Safe access: `firstOrNull`, `lastOrNull`, `singleOrNull`
- Counting: `count`, `none`
- Aggregation: `sumBy`, `averageBy`, `maxBy`, `minBy`
- Indexed iteration: `forEachIndexed`, `mapIndexed`, `whereIndexed`
- Transformation: `flatMap`, `chunked`, `distinctBy`
- Grouping: `groupBy`, `associateBy`, `associateWith`

#### `duration_utils.dart` (new)

- Predicates: `isZero`, `isNegative`
- Derived units: `inWeeks`
- DateTime arithmetic: `ago`, `fromNow`
- Formatting: `formatted`, `toHhMmSs`, `toMmSs`
- Arithmetic: `multipliedBy`, `dividedBy`, `percentageOf`, `toCountdown`

### Improvements

#### `string_utils.dart`

- Fixed: `toCamelCase`, `toSnakeCase`, `toPascalCase`, `toKebabCase`
- Fixed: `isEmail` regex
- Added: `isUrl`, `isPhoneNumber`, `mask`, `truncate`, `toSlug`, `initials`, `reverse`, `equalsIgnoreCase`, `fromBase64`, `toBase64`, `stripHtml`, `countOccurrences`, `wordCount`, `between`, `before`, `after`, `beforeLast`, `afterLast`, `dropLeft`, `dropRight`, `removePrefix`, `removeSuffix`, `format`, `formatMap`, `toHtmlText`, `repeat`
- Added: `levenshteinDistance`, `similarityTo`, `wordWrap`, `toSentenceCase`, `extractNumbers`, `extractEmails`, `extractUrls`, `compactWhitespace`, `truncateWords`, `tryParseJson`
- Added: `StringUtilsNullable` extension with `isNullOrEmpty`, `isNullOrBlank`, `orEmpty`, `orDefault`

#### `list_utils.dart`

- Fixed: `sortedBy`, `sortedByDescending` generics
- Fixed: `sumBy` return type
- Added: `second`, `third`, `penultimate`, `flatten`, `zip`, `toPairs`, `windowed`, `rotate`, `swap`, `move`, `random`, `sample`, `frequencies`, `mode`, `median`, `average`, `averageBy`
- Added: `firstWhereOrNull`, `lastOrNull`, `intersperse`, `page`, `distinct`, `difference`, `intersection`, `cumulativeSum`, `transpose`

#### `map_utils.dart`

- Fixed: `shift` method logic
- Added: `getOrDefault`, `getOrPut`, `mapKeys`, `mapValues`, `invertMap`, `mergeWith`, `toQueryString`, `flatten`, `deepGet`
- Added: `deepMerge`, `deepSet`, `compact`, `renameKey`, `diff`, `pick`, `omit`
- Added top-level: `mapFromQueryString`

#### `number_utils.dart`

- Fixed: `toCurrencyString` formatting
- Added: `lerp`, `normalize`, `factorial`, `isPrime`, `toOrdinal`, `toRoman`, `toBinary`, `toHex`, `toOctal`, `roundTo`, `pad`, `percentage`, `digitCount`, `reversed`, `toRadians`, `toDegrees`
- Added: `clampTo`, `toFileSize`, `toDuration`, `toCompact`, `gcd`, `lcm`, `isFibonacci`, `toWords`, `safeDivide`

#### `datetime_utils.dart`

- Fixed: `season` getter logic
- Added: `startOfDay`, `endOfDay`, `startOfWeek`, `endOfWeek`, `startOfMonth`, `endOfMonth`, `startOfYear`, `endOfYear`, `timeAgo`, `format`, `addWorkdays`, `nextWeekday`, `isBetween`, `age`, `quarterOfYear`, `weekOfYear`, `toUtcIso8601`
- Added: `countdown`, `isBusinessHours`, `daysInMonth`, `copyWith`, `timezoneOffsetString`, `fiscalQuarter`

#### `enum_utils.dart`

- Added: `label` getter for human-readable enum names
- Fixed: `when()` now throws `ArgumentError` for unhandled values

### Testing

- Added 540 comprehensive unit tests covering all extensions

---

## 1.0.2

- Added Enum Utils
- Updated `groupBy` extension in list to return a map of lists

## 1.0.1

- Added `sortedBy`, `sortedByDescending`, `groupBy`, `takeIf`, `takeWhile`, `joinToString` extensions in list
- Updated `partition` extension in list/map to return a pair of lists

## 1.0.0

- Initial release
  - Added list extensions
  - Added map extensions
  - Added number extensions
  - Added string extensions
  - Added datetime extensions
