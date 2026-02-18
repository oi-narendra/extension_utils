# extension_utils

[![pub package](https://img.shields.io/pub/v/extension_utils.svg)](https://pub.dev/packages/extension_utils)

A modern Dart/Flutter utility library providing practical extensions for `String`, `List`, `Map`, `num`, `DateTime`, `Duration`, `Color`, `Iterable`, and `Enum` types.

Requires **Dart ≥ 3.3.0** and **Flutter ≥ 3.19.0**.

## Features

| Extension | Description |
|-----------|-------------|
| `StringUtils` | Case conversion, validation, formatting, encoding |
| `ListUtils` | Statistics, sorting, windowing, zipping, sampling |
| `MapUtils` | Deep access, merging, key/value mapping, query strings |
| `NumberUtils` | Math, formatting, numeral systems, ordinals |
| `DateTimeUtils` | Boundaries, relative time, formatting, workday arithmetic |
| `DurationUtils` | Human-readable formatting, `ago`/`fromNow` helpers |
| `ColorUtils` | Lighten/darken, palettes, contrast, hex conversion |
| `IterableUtils` | Safe access, aggregation, grouping, chunking |
| `EnumUtils` | Pattern matching, human-readable labels |

## Installation

```yaml
dependencies:
  extension_utils: ^2.0.0
```

```dart
import 'package:extension_utils/extension_utils.dart';
```

---

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
