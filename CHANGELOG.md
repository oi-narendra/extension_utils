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

#### `color_utils.dart` (new)
- `isLight`, `isDark`, `luminance`, `contrastColor`
- `lighten`, `darken`, `withHue`, `withSaturation`, `withLightness`
- `mix`, `complementary`, `grayscale`
- `analogous`, `triadic`, `tetradic`
- `toHex`, `toMaterialColor`

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

### Improvements

#### `string_utils.dart`
- Fixed: `toCamelCase`, `toSnakeCase`, `toPascalCase`, `toKebabCase`
- Fixed: `isEmail` regex
- Added: `isUrl`, `isPhoneNumber`, `mask`, `truncate`, `toSlug`, `initials`, `reverse`, `equalsIgnoreCase`, `fromBase64`, `toBase64`, `stripHtml`, `countOccurrences`, `wordCount`, `between`, `before`, `after`, `beforeLast`, `afterLast`, `dropLeft`, `dropRight`, `removePrefix`, `removeSuffix`, `format`, `formatMap`, `toHtmlText`, `repeat`

#### `list_utils.dart`
- Fixed: `sortedBy`, `sortedByDescending` generics
- Fixed: `sumBy` return type
- Added: `second`, `third`, `penultimate`, `flatten`, `zip`, `toPairs`, `windowed`, `rotate`, `swap`, `move`, `random`, `sample`, `frequencies`, `mode`, `median`, `average`, `averageBy`

#### `map_utils.dart`
- Fixed: `shift` method logic
- Added: `getOrDefault`, `getOrPut`, `mapKeys`, `mapValues`, `invertMap`, `mergeWith`, `toQueryString`, `flatten`, `deepGet`

#### `number_utils.dart`
- Fixed: `toCurrencyString` formatting
- Added: `lerp`, `normalize`, `factorial`, `isPrime`, `toOrdinal`, `toRoman`, `toBinary`, `toHex`, `toOctal`, `roundTo`, `pad`, `percentage`, `digitCount`, `reversed`, `toRadians`, `toDegrees`

#### `datetime_utils.dart`
- Fixed: `season` getter logic
- Added: `startOfDay`, `endOfDay`, `startOfWeek`, `endOfWeek`, `startOfMonth`, `endOfMonth`, `startOfYear`, `endOfYear`, `timeAgo`, `format`, `addWorkdays`, `nextWeekday`, `isBetween`, `age`, `quarterOfYear`, `weekOfYear`, `toUtcIso8601`

#### `enum_utils.dart`
- Added: `label` getter for human-readable enum names
- Fixed: `when()` now throws `ArgumentError` for unhandled values

### Testing
- Added 356 comprehensive unit tests covering all extensions

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
