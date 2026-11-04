# extension_utils

[![pub package](https://img.shields.io/pub/v/extension_utils.svg)](https://pub.dev/packages/extension_utils)

A modern Dart/Flutter utility library providing practical extensions for `String`, `List`, `Map`, `num`, `DateTime`, `Duration`, `Color`, `Iterable`, `Enum`, `bool`, `Uri`, `Future`, `Object`, and `RegExp` types.

Requires **Flutter ≥ 3.29.0** (bundled Dart 3.7+).

## Features

| Extension        | Description                                                    |
| ---------------- | -------------------------------------------------------------- |
| `StringUtils`    | Case conversion, validation, formatting, encoding, NLP helpers |
| `ListUtils`      | Statistics, sorting, windowing, zipping, pagination, set ops   |
| `MapUtils`       | Deep access/merge, key/value mapping, query strings, diffing   |
| `NumberUtils`    | Math, formatting, numeral systems, ordinals, file sizes        |
| `DateTimeUtils`  | Boundaries, relative time, formatting, workday arithmetic      |
| `DurationUtils`  | Human-readable formatting, arithmetic, countdown               |
| `ColorUtils`     | Lighten/darken, palettes, contrast, accessibility, hex         |
| `IterableUtils`  | Safe access, aggregation, grouping, chunking                   |
| `EnumUtils`      | Pattern matching, human-readable labels                        |
| `BoolUtils`      | Toggle, conditional helpers, pattern dispatch                  |
| `UriUtils`       | Query params, path manipulation, scheme checks                 |
| `FutureUtils`    | Retry, timeout, fallback                                       |
| `ObjectUtils`    | Kotlin-style scope functions (`let`, `also`, `takeIf`)         |
| `RegExpPatterns` | 14 pre-built common regex patterns                             |

## Installation

```yaml
dependencies:
  extension_utils: ^2.0.0
```

```dart
import 'package:extension_utils/extension_utils.dart';
```

---

## Debounce and throttle

```dart
final search = Debouncer(delay: const Duration(milliseconds: 300));
search.run(() => searchUsers(query)); // Only the latest call runs.
search.flush(); // Optional: run it now.
search.cancel(); // Optional: discard pending work.

final taps = Throttler(interval: const Duration(seconds: 1));
final accepted = taps.run(() => refresh()); // Runs immediately, or returns false.

// In your State.dispose():
search.dispose();
taps.dispose();
```

Keep these instances outside `build`. Throttle ignores calls during its cooldown;
it does not queue a final call. Neither helper cancels or waits for asynchronous
work already started. Handle errors in async callbacks as usual. Calling `run`
after disposal throws `StateError`.

The example app lets you try debounced search and rapid button taps.

## API Reference

### String Extensions

```dart
// Case conversion
'hello world'.toCamelCase()    // 'helloWorld'
'hello world'.toPascalCase()   // 'HelloWorld'
'hello world'.toSnakeCase()    // 'hello_world'
'hello world'.toKebabCase()    // 'hello-world'
'hello world'.toTitleCase()    // 'Hello World'
'hello world'.toConstantCase() // 'HELLO_WORLD'
'hello world'.capitalize()     // 'Hello world'

// Validation
'user@example.com'.isEmail()    // true
'https://dart.dev'.isUrl()      // true
'+1-800-555-0100'.isPhoneNumber() // true
'#FF5733'.isHexColor()          // true
'dad'.isPalindrome()            // true
'12345'.isDigits()              // true
'hello'.isAlpha()               // true

// Formatting & transformation
'hello world'.toSlug()          // 'hello-world'
'John Doe'.initials()           // 'JD'
'Hello World'.reverse()         // 'dlroW olleH'
'1234567890'.mask(visibleCount: 4) // '******7890'
'Long text here'.truncate(8)    // 'Long tex...'
'<b>bold</b>'.stripHtml()       // 'bold'

// Encoding
'hello'.toBase64()              // 'aGVsbG8='
'aGVsbG8='.fromBase64()        // 'hello'

// Utilities
'hello world'.wordCount         // 2
'hello'.countOccurrences('l')   // 2
'hello'.equalsIgnoreCase('HELLO') // true
'hello {name}!'.formatMap({'name': 'world'}) // 'hello world!'
'hello {}!'.format(['world'])   // 'hello world!'
'hello'.repeat(3, separator: '-') // 'hello-hello-hello'

// Substrings
'hello world'.between('hello ', '!')  // 'world'
'hello world'.before(' ')             // 'hello'
'hello world'.after(' ')              // 'world'
'hello world'.dropLeft(6)             // 'world'
'hello world'.dropRight(6)            // 'hello'
'hello world'.removePrefix('hello ')  // 'world'
'hello world'.removeSuffix(' world')  // 'hello'
// New in 2.1.0
'hello world'.levenshteinDistance('hello')  // 6
'kitten'.similarityTo('sitting')            // 0.57...
'hello world'.toSentenceCase()              // 'Hello world'
'hello world'.wordWrap(5)                   // 'hello\nworld'
'price is 42.5'.extractNumbers()            // [42.5]
'email me@example.com'.extractEmails()      // ['me@example.com']
'visit https://dart.dev'.extractUrls()      // ['https://dart.dev']
'  hello   world  '.compactWhitespace()     // 'hello world'
'one two three'.truncateWords(2)            // 'one two...'
'{"key": 1}'.tryParseJson()                 // {'key': 1}

// Null-safe helpers (StringUtilsNullable)
String? s;
s.isNullOrEmpty   // true
s.orEmpty         // ''
s.orDefault('hi') // 'hi'
```

### List Extensions

```dart
// Safe access
[1, 2, 3].second    // 2
[1, 2, 3].third     // 3
[1, 2, 3].penultimate // 2

// Removal
[1, 2, 1, 3].removeFirst(1)          // [2, 1, 3]
[1, 2, 1, 3].removeLastOccurrence(1) // [1, 2, 3]
[1, 2, 1, 3].removeAll(1)            // [2, 3]

// Sorting
['b', 'a', 'c'].sortedBy((s) => s)            // ['a', 'b', 'c']
['b', 'a', 'c'].sortedByDescending((s) => s)  // ['c', 'b', 'a']

// Transformation
[[1, 2], [3, 4]].flatten()              // [1, 2, 3, 4]
[1, 2, 3].zip(['a', 'b', 'c'])         // [(1, 'a'), (2, 'b'), (3, 'c')]
[1, 2, 3, 4, 5].windowed(3)            // [[1,2,3],[2,3,4],[3,4,5]]
[1, 2, 3].rotate(1)                    // [2, 3, 1]

// Statistics (on List<num>)
[1, 2, 3, 4].average   // 2.5
[1, 2, 3, 4].median    // 2.5
[1, 1, 2, 3].mode      // [1]
[1, 2, 3].sumBy((n) => n * 2) // 12

// Sampling
[1, 2, 3, 4, 5].random()     // random element
[1, 2, 3, 4, 5].sample(3)    // 3 random elements

// Grouping
[1, 2, 3, 4].groupBy((n) => n.isEven ? 'even' : 'odd')
// {'odd': [1, 3], 'even': [2, 4]}

// Joining
[1, 2, 3].joinToString(', ')  // '1, 2, 3'
// New in 2.1.0
[1, 2, 3].firstWhereOrNull((n) => n > 5)  // null
[1, 2, 3].lastOrNull                       // 3
[1, 2, 3].intersperse(0)                   // [1, 0, 2, 0, 3]
[1, 2, 3, 4, 5].page(pageSize: 2, page: 1) // [3, 4]
[1, 2, 2, 3].distinct()                    // [1, 2, 3]
[1, 2, 3].difference([2, 3, 4])            // [1]
[1, 2, 3].intersection([2, 3, 4])          // [2, 3]
[1, 2, 3].cumulativeSum()                  // [1, 3, 6]
[[1, 2], [3, 4]].transpose()               // [[1, 3], [2, 4]]
```

### Map Extensions

```dart
// Safe access
{'a': 1}.getOrDefault('b', 0)   // 0
{'a': 1}.getOrPut('b', () => 2) // 2 (and inserts it)

// Transformation
{'a': 1, 'b': 2}.mapKeys((k) => k.toUpperCase())   // {'A': 1, 'B': 2}
{'a': 1, 'b': 2}.mapValues((v) => v * 10)          // {'a': 10, 'b': 20}
{'a': 1, 'b': 2}.invertMap()                        // {1: 'a', 2: 'b'}

// Merging
{'a': 1}.mergeWith({'b': 2})  // {'a': 1, 'b': 2}

// Filtering
{'a': 1, 'b': 2}.filter((k, v) => v > 1)  // {'b': 2}
{'a': 1, 'b': 2}.filterKeys(['a'])         // {'a': 1}
{'a': 1, 'b': 2}.filterValues([2])         // {'b': 2}

// Nested access
{'a': {'b': {'c': 42}}}.deepGet('a.b.c')  // 42

// Serialization
{'q': 'dart', 'page': '1'}.toQueryString() // 'q=dart&page=1'

// Flattening
{'a': {'b': 1}}.flatten()  // {'a.b': 1}
// New in 2.1.0
{'a': 1}.deepMerge({'b': 2})               // {'a': 1, 'b': 2}
{'a': 1, 'b': null}.compact()              // {'a': 1}
{'a': 1}.renameKey('a', 'z')              // {'z': 1}
{'a': 1, 'b': 2}.pick(['a'])              // {'a': 1}
{'a': 1, 'b': 2}.omit(['b'])              // {'a': 1}
{'a': 1}.diff({'a': 2, 'b': 3})           // {'a': [1, 2], 'b': [null, 3]}
mapFromQueryString('q=dart&page=1')        // {'q': 'dart', 'page': '1'}
```

### Number Extensions

```dart
// Math
0.0.lerp(10.0, 0.5)    // 5.0
5.0.normalize(0, 10)   // 0.5
5.factorial()          // 120
7.isPrime              // true
3.14159.toRadians()    // 0.054... (wait, this is degrees→radians)
1.5708.toDegrees()     // 90.0

// Formatting
1234567.toCurrencyString()           // '1,234,567.00'
1234567.toCurrencyString(symbol: '€') // '€1,234,567.00'
3.toOrdinal()                        // '3rd'
2024.toRoman()                       // 'MMXXIV'
255.toBinary()                       // '11111111'
255.toHex()                          // 'ff'
255.toOctal()                        // '377'
3.14159.roundTo(2)                   // 3.14
3.14159.toPrecision(4)               // '3.142'
42.pad(5)                            // '00042'
25.0.percentage(200)                 // 12.5
1234.digitCount                      // 4
// New in 2.1.0
42.clampTo(0, 10)                // 10
1024.toFileSize()                // '1.0 KB'
90.toDuration()                  // Duration(minutes: 90) [seconds]
1500000.toCompact()              // '1.5M'
12.gcd(8)                        // 4
12.lcm(8)                        // 24
8.isFibonacci                    // true
42.toWords()                     // 'forty two'
10.safeDivide(0)                 // 0.0
```

### DateTime Extensions

```dart
// Boundaries
DateTime.now().startOfDay    // 2024-03-05 00:00:00.000
DateTime.now().endOfDay      // 2024-03-05 23:59:59.999
DateTime.now().startOfWeek   // Monday of this week
DateTime.now().startOfMonth  // 2024-03-01
DateTime.now().startOfYear   // 2024-01-01

// Relative time
DateTime.now().subtract(Duration(hours: 2)).timeAgo() // '2 hours ago'
DateTime.now().add(Duration(days: 3)).timeAgo()       // 'in 3 days'

// Formatting (no intl dependency)
DateTime(2024, 3, 5).format('dd MMM yyyy')  // '05 Mar 2024'
DateTime(2024, 3, 5).format('yyyy-MM-dd')   // '2024-03-05'
DateTime(2024, 3, 5).format('MMMM')         // 'March'
DateTime(2024, 3, 5).format('EEE')          // 'Tue'

// Predicates
DateTime.now().isToday     // true
DateTime.now().isWeekend   // false
DateTime.now().isLeapYear  // false
DateTime(2024, 3, 5).isBetween(DateTime(2024, 1, 1), DateTime(2024, 12, 31)) // true

// Utilities
DateTime.now().addWorkdays(5)    // 5 business days from now
DateTime(2000, 6, 15).age        // years since that date
DateTime.now().quarterOfYear     // 1–4
DateTime.now().weekOfYear        // 1–53
DateTime.now().season            // 'Spring', 'Summer', 'Autumn', 'Winter'
DateTime.now().toUtcIso8601      // '2024-03-05T...'
// New in 2.1.0
DateTime.now().countdown()                   // Duration until/since now
DateTime(2024, 3, 18, 10).isBusinessHours()  // true
DateTime(2024, 2).daysInMonth                // 29 (leap year)
DateTime(2024, 3, 15).copyWith(month: 6)     // DateTime(2024, 6, 15)
DateTime.now().timezoneOffsetString          // '+10:00'
DateTime(2024, 4).fiscalQuarter(4)           // 1 (fiscal year starts April)
```

### Duration Extensions

```dart
const Duration(hours: 1, minutes: 23, seconds: 45).formatted // '1h 23m 45s'
const Duration(minutes: 90).toHhMmSs()                       // '01:30:00'
const Duration(seconds: 75).toMmSs()                         // '01:15'

const Duration(hours: 2).ago      // DateTime 2 hours ago
const Duration(days: 3).fromNow   // DateTime 3 days from now

const Duration(days: 14).inWeeks  // 2
const Duration.zero.isZero        // true
// New in 2.1.0
const Duration(hours: 1).multipliedBy(1.5)  // Duration(hours: 1, minutes: 30)
const Duration(hours: 2).dividedBy(4)        // Duration(minutes: 30)
const Duration(minutes: 30).percentageOf(const Duration(hours: 1)) // 50.0
const Duration(minutes: 90).toCountdown()    // '01:30:00'
```

### Color Extensions

```dart
Colors.blue.isLight      // false
Colors.blue.isDark       // true
Colors.blue.luminance    // 0.07...
Colors.blue.contrastColor // Colors.white or Colors.black

Colors.blue.lighten(0.2)   // lighter blue
Colors.blue.darken(0.2)    // darker blue
Colors.blue.grayscale       // desaturated blue

Colors.red.mix(Colors.blue, 0.5)  // purple
Colors.red.complementary          // cyan

Colors.blue.analogous(count: 3)   // 3 analogous colors
Colors.blue.triadic               // 3 triadic colors

Colors.blue.toHex()               // '#FF2196F3'
Colors.blue.toMaterialColor()     // MaterialColor swatch
// New in 2.1.0
Colors.black.contrastRatio(Colors.white)      // 21.0
Colors.white.isAccessibleOn(Colors.black)     // true
Colors.blue.splitComplementary                // [Color, Color]
Colors.red.withOpacityPercent(50)             // Color with 50% opacity
Colors.blue.shade(20)                         // 20% darker
Colors.blue.tint(20)                          // 20% lighter
```

### Bool Extensions

```dart
true.toggled                    // false
true.toYesNo()                  // 'Yes'
false.toOnOff()                 // 'Off'
true.toEnabledDisabled()        // 'Enabled'
true.ifTrue('hello')            // 'hello'
false.ifFalse('fallback')       // 'fallback'
true.when(onTrue: () => 'yes', onFalse: () => 'no') // 'yes'
```

### URI Extensions

```dart
Uri.parse('https://example.com').isSecure          // true
Uri.parse('https://example.com').appendPath('api') // https://example.com/api
Uri.parse('https://example.com').withQueryParam('q', 'dart')
// https://example.com?q=dart
Uri.parse('https://example.com?q=dart').removeQueryParam('q')
// https://example.com
```

### Future Utilities

```dart
// Retry a future factory up to N times
final data = await retryFuture(() => fetchData(), times: 3,
    delay: Duration(seconds: 1));

// Timeout with fallback
final result = await slowOperation()
    .withTimeout(Duration(seconds: 5), fallback: defaultValue);

// Fallback on error
final safe = await riskyOperation().withFallback(defaultValue);
```

### Object Extensions

```dart
// Kotlin-style scope functions
final upper = 'hello'.let((s) => s.toUpperCase()); // 'HELLO'

final list = <int>[]
  ..also((l) => l.addAll([1, 2, 3]));  // [1, 2, 3]

final even = 4.takeIf((n) => n.isEven);   // 4
final odd  = 3.takeIf((n) => n.isEven);   // null
```

### RegExp Patterns

```dart
RegExpPatterns.email.hasMatch('user@example.com')  // true
RegExpPatterns.url.hasMatch('https://dart.dev')    // true
RegExpPatterns.uuid.hasMatch('550e8400-e29b-...')  // true
RegExpPatterns.hexColor.hasMatch('#FF5733')         // true
RegExpPatterns.creditCard.hasMatch('4111111111111111') // true
// Also: phone, ipv4, ipv6, postalCode, date, time, username, slug, htmlTag
```

### Iterable Extensions

```dart
[].firstOrNull    // null
[1].singleOrNull  // 1
[1, 2].singleOrNull // null (more than one)

[1, 2, 3, 4].count((n) => n.isEven)  // 2
[1, 3, 5].none((n) => n.isEven)      // true

[1, 2, 3].sumBy((n) => n * 2)        // 12
[1, 2, 3].averageBy((n) => n)        // 2.0
['a', 'bb', 'ccc'].maxBy((s) => s.length) // 'ccc'
['a', 'bb', 'ccc'].minBy((s) => s.length) // 'a'

[1, 2, 3].forEachIndexed((i, e) => print('$i: $e'))
[1, 2, 3].mapIndexed((i, e) => '$i:$e').toList() // ['0:1', '1:2', '2:3']

['hello', 'world'].flatMap((s) => s.split('')).toList()
// ['h','e','l','l','o','w','o','r','l','d']

[1, 2, 3, 4, 5].chunked(2).toList()  // [[1,2],[3,4],[5]]

users.groupBy((u) => u.role)         // Map<Role, List<User>>
users.associateBy((u) => u.id)       // Map<int, User>
```

### Enum Extensions

```dart
enum Status { active, inactive, pending }

Status.active.label  // 'Active'

Status.active.when({
  Status.active:   () => 'Running',
  Status.inactive: () => 'Stopped',
  Status.pending:  () => 'Waiting',
}); // 'Running'

Status.active.whenOrElse({
  Status.inactive: () => 'Stopped',
}, orElse: () => 'Other'); // 'Other'
```

---

## Contributing

Issues and pull requests are welcome at [github.com/oi-narendra/extension_utils](https://github.com/oi-narendra/extension_utils).

## License

MIT — see [LICENSE](LICENSE) for details.

## Development

CI checks formatting, analysis, package and example tests, the example web build,
and a publish dry run. A separate job tests the minimum supported Flutter SDK.
Version tags must match `pubspec.yaml` and point to a commit on `main`; publishing
only runs after all checks pass.
