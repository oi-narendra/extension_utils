A util library that contains various extensions for strings, lists, maps, and more.

## Features

- [x] String extensions
- [x] List extensions
- [x] Map extensions
- [x] DateTime extensions
- [x] Number extensions
- [x] Enum extensions
- [ ] Color extensions  

### Installation

Add the following to your pubspec.yaml file:

```yaml
dependencies:
  extension_utils: ^1.0.1
```

### Usage

```dart
import 'package:extension_utils/extension_utils.dart';

void main() {
  print('Hello, World!'.toSnakeCase());
  // hello_world
}
```

## API Reference

### String Extensions

```dart
'hello, world!'.capitalize(); // Hello, world!

'Hello, World!'.uncapitalize();   // hello, World!

'hello, world!'.titleCase();  // Hello, World!

'hello, world!'.underscore(); // hello_world

'hello, world!'.variablize(); // helloWorld

'hello, world!'.constantize();  // HELLO_WORLD

'hello, world!'.humanize(); // Hello world

'hello, world!'.pluralize();  // hello, worlds!

'hello, world!'.tableize(); // hello_worlds

'hello, world!'.sequenceize();  // hello_worlds

'hello, world!'.foreignKey(); // hello_world_id

'hello, world!'.pathize();  // hello/world

'hello, world!'.toPascalCase(); // HelloWorld

'hello, world!'.toSnakeCase();  // hello_world

'hello, world!'.toKebabCase();  // hello-world

'hello, world!'.toTrainCase();  // Hello-World

'hello, world!'.toDotCase();  // hello.world

'hello, world!'.toHtmlText(); // hello, world!

'hello,\wworld!'.escape();  // hello,\\wworld!

'dad'.isPalindrome(); // true

'email@gmail.com'.isEmail();  // true

'983123'.isDigits();  // true

'#FFFFFF'.isHexColor(); // true

'#FFFFFF'.toColor(); // Color(0xffffffff)

'hello, world!'.wordCount();  // 2

'hello, world!'.charCount();  // 13

'hello, world!'.vowelCount(); // 3

'hello, world!'.consonantCount(); // 8

'hello, world!'.syllableCount();  // 3

'hello, world!'.sentenceCount();  // 1

'hello, world!'.between('hello', '!');  // , world

'hello, world!'.before('world');  // hello, 

'hello, world!'.after('hello'); // , world!

'hello, world!'.beforeLast('o');  // hello, w

'hello, world!'.afterLast('o'); // rld!

'hello, world!'.beforeFirst('o'); // hell

'hello, world!'.afterFirst('o');  // , world!

'hello, world!'.startsWith('hello');  // true

'hello, world!'.endsWith('!');  // true

'hello, world!'.betweenFirst('hello', '!'); // , world

'hello, world!'.betweenLast('hello', '!');  // , world

'hello, world!'.containsIgnoreCase('HELLO');  // true

'hello, world!'.dropLeft(6);  // world!

'hello, world!'.dropRight(6); //  hello,

'hello, world!'.dropLeftWhile((c) => c != ' '); // world!

'hello, world!'.dropRightWhile((c) => c != ' ');  // hello,

'hello, world!'.replaceAfterFirst('hello', '!');  // hello!

'hello, world!'.replaceAfterLast('hello', '!'); // hello!

'hello, world!'.replaceBeforeFirst('hello', '!'); // !, world!

'hello, world!'.replaceBeforeLast('hello', '!');  // !, world!

'hello, world!'.replaceRange(0, 5, 'hi'); // hi, world!

'hello, world!'.toBytes();  // [104, 101, 108, 108, 111, 44, 32, 119, 111, 114, 108, 100, 33]

'hello, world!'.toBase64(); // aGVsbG8sIHdvcmxkIQ==

'hello, world!'.prepend('hi, ');  // hi, hello, world!

'hello, world!'.append('!');  // hello, world!!

'hello, {}!'.format(['world']); // hello, world!

'hello, {name}!'.formatMap({'name': 'world'});  // hello, world!
```

### List Extensions

```dart
['hello', 'world'].removeFirst(); // ['world']

['hello', 'world'].removeLast(); // ['hello']

['hello','world','hello','world'].removeAll('hello'); // ['world','world']

['lorem','ipsum','hello', 'world'].removeAllList(['lorem','hello']); // ['ipsum','world']

['lorem','ipsum','hello', 'world'].removeAllSet({'lorem','hello'}); // ['ipsum','world']

['lorem','ipsum','hello', 'world'].removeAllIterable(['lorem','hello']); // ['ipsum','world']

['lorem','ipsum','hello', 'world'].removeAllMapKeys({'lorem': 'ipsum', 'hello': 'world'}); // ['ipsum','world']

['lorem','ipsum','hello', 'world'].removeAllMapValues({'lorem': 'ipsum', 'hello': 'world'}); // ['lorem','hello']

['hi','hello','lorem', 'ipsum'].parititon((s) => s.startsWith('h')); // Pair(['hi','hello'],['lorem', 'ipsum'])

[Product(qty: 5, price: 10), Product(qty: 10, price: 20)].sumBy((p) => p.qty * p.price); // 250

['lorem','ipsum','hello', 'world'].containsAllList(['lorem','hello']); // true

['lorem','ipsum','hello', 'world'].containsAllSet({'lorem','hello'}); // true

['lorem','ipsum','hello', 'world'].containsAllIterable(['lorem','hello']); // true

['lorem','ipsum','hello', 'world'].containsAllMapKeys({'lorem': 'ipsum', 'hello': 'world'}); // true

['lorem','ipsum','hello', 'world'].containsAllMapValues({'lorem': 'ipsum', 'hello': 'world'}); // false

['lorem','ipsum','hello', 'world'].mergeList(['lorem','hello'],unique: true); // ['lorem','ipsum','hello', 'world','lorem']

['lorem','ipsum','hello', 'world'].toMap(); // {'lorem': 'lorem','ipsum': 'ipsum','hello': 'hello', 'world': 'world'}

['lorem','ipsum','helloo', 'world'].distinctBy((a) => a.length == 5); // ['lorem','helloo']

['lorem','ipsum','hello', 'world'].compact(); // ['lorem','ipsum','hello', 'world']

['lorem','ipsum','hello', 'world'].clearAndAddAll(['lorem','hello']); // ['lorem','hello']

['hi', 'ipsum', 'hello', 'bro'].sortedBy((s) => s.length); // ['hi', 'bro', 'hello', 'ipsum']

['hi', 'ipsum', 'hello', 'bro'].sortByDescending((s) => s.length); // ['ipsum', 'hello', 'hi', 'bro']

['hi', 'ipsum', 'hello', 'bro'].groupBy((s) => s.length); // {2: ['hi', 'bro'], 5: ['ipsum', 'hello']}

['hi', 'ipsum', 'hello', 'bro'].joinToString(','); // hi,ipsum,hello,bro

['hi', 'ipsum', 'hello', 'bro'].joinToString(',', transform: (s) => s.toUpperCase()); // HI,IPSUM,HELLO,BRO

['hi', 'ipsum', 'hello', 'bro'].joinToString(',', prefix: '(', suffix: ')'); // (hi,ipsum,hello,bro)

[1,2,3,4,5,6].takeWhile((i) => i < 4); // [1,2,3]

[1,2,3,4,5,6].takeIf((i) => i < 4 || i == 5 ); // [1,2,3,5]

```

### Number Extensions

```dart
1.0.isEven(); // false

1.0.isOdd(); // true

1.0.isNegative(); // false

1.0.isPositive(); // true

1.0.isZero(); // false

(1/2).isInteger(); // false

-2.swapSign(); // 2

2.swapSign(); // -2

2.000524.toPrecision(3); // 2.00

2.000524.toPrecision(4); // 2.001

645123512.toCurrencyString(); // 645,123,512.00

2.000524.isInRange(1, 3); // true

9842323112.startsWith(984); // true

9842323112.endsWith(112); // true

9842323112.contains(232); // true

9842323112.count(2); // 3

12312412.indexesOfFirst(2); // 1

12312412.indexesOfLast(2); // 5

12312412.indexesOfAll(2); // [1, 5]

9876543210.sumOfDigits(); // 45

9876543210.digitsAfter(2); // 10

9876543210.digitsBefore(2); // 98765432

9876543210.digitsBetween(9, 4); // 8765

9872543210.digitsBeforeFirst(2); // 987

9872543210.digitsAfterFirst(2); // 543210

9872543210.digitsBeforeLast(2); // 9872543

9872543210.digitsAfterLast(2); // 10

10.loremIpsum(); // Lorem ipsum dolor sit amet, consectetur adipiscing elit. 

20.randomList(min: 1, max: 10); // [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
```

### Map Extensions

```dart
{}.isEmpty(); // true

{'hello': 'world'}.contains('hello','world'); // true

{'hello': 'world','lorem': 'ipsum'}.removeExact(key: 'hello', value: 'world'); // {'lorem': 'ipsum'}

{'hello': 'world','lorem': 'ipsum'}.prefixKeys('product-') // {'product-hello': 'world','product-lorem': 'ipsum'}

{'hello': 'world','lorem': 'ipsum'}.suffixKeys('-product') // {'hello-product': 'world','lorem-product': 'ipsum'}

{'hello': 'world','lorem': 'ipsum'}.prefixValues('product-') // {'hello': 'product-world','lorem': 'product-ipsum'}

{'hello': 'world','lorem': 'ipsum'}.suffixValues('-product') // {'hello': 'world-product','lorem': 'ipsum-product'}

{'hello': 'world','lorem': 'ipsum'}.capitalizeKeys() // {'Hello': 'world','Lorem': 'ipsum'}

{'hello': 'world','lorem': 'ipsum'}.capitalizeValues() // {'hello': 'World','lorem': 'Ipsum'}

{'hello world': 'lorem ipsum'}.camelCaseKeys() // {'helloWorld': 'lorem ipsum'}

{'hello world': 'lorem ipsum'}.camelCaseValues() // {'hello world': 'loremIpsum'}

{'hello world': 'lorem ipsum'}.snakeCaseKeys() // {'hello_world': 'lorem ipsum'}

{'hello world': 'lorem ipsum'}.snakeCaseValues() // {'hello world': 'lorem_ipsum'}

{'hello world': 'lorem ipsum'}.kebabCaseKeys() // {'hello-world': 'lorem ipsum'}

{'hello world': 'lorem ipsum'}.kebabCaseValues() // {'hello world': 'lorem-ipsum'}

///List<Map<K, V>> partition<K, V>(bool Function(K key, V value) predicate)
{'hello': 'world','lorem': 'ipsum','hi': 'there'}.partition((key, value) => key.length == 5); // [{'hello': 'world', 'lorem': 'ipsum'},{'hi': 'there'}]

{'hello': 'world','lorem': 'ipsum'}.filter((key, value) => key == 'hello') // {'hello': 'world'}

{'hello': 'world','lorem': 'ipsum'}.filterNull() // {'hello': 'world','lorem': 'ipsum'}

{'hello': 'world','lorem': 'ipsum'}.filterEmpty() // {'hello': 'world','lorem': 'ipsum'}

{'hello': 'world','lorem': 'ipsum'}.filterKeys(['hello']) // {'hello': 'world'}

{'hello': 'world','lorem': 'ipsum'}.filterValues(['world']) // {'hello': 'world'}

{'hello': 'world','lorem': 'ipsum'}.filterNot((key, value) => key == 'hello') // {'lorem': 'ipsum'}

{'hello': 'world','lorem': 'ipsum'}.reject((key, value) => key == 'hello') // {'lorem': 'ipsum'}

{'hello': 'world','lorem': 'ipsum'}.rejectKeys(['hello']) // {'lorem': 'ipsum'}

{'hello': 'world,lorem': 'ipsum'}.rejectValues(['world']) // {'lorem': 'ipsum'}

{'hello': 'world','lorem': 'ipsum'}.rejectNot((key, value) => key == 'hello') // {'hello': 'world'}

{'hello': 'world','lorem': 'ipsum'}.shift() // {'lorem': 'ipsum'}

{'hello': 'world','lorem': 'ipsum'}.printDebug(label: 'Map', separator: ': ', indent: ',  ') // Map: hello: world,  lorem: ipsum

{'hello': 'world','lorem': 'ipsum','lo': 'ipsum'}.uniqueValues() // {'hello': 'world','lorem': 'ipsum'}
```

### DateTime Extensions

```dart
DateTime.now().isToday() // true

DateTime.now().isYesterday() // false

DateTime.now().isTomorrow() // false

DateTime.now().isPast() // false

DateTime.now().isFuture() // false

DateTime.now().isSameDay(DateTime.now()) // true

DateTime.now().isSameMonth(DateTime.now()) // true

DateTime.now().isSameYear(DateTime.now()) // true

DateTime.now().isSameHour(DateTime.now()) // true

DateTime.now().isSameMinute(DateTime.now()) // true

DateTime.now().isSameSecond(DateTime.now()) // true

DateTime.now().isSameMillisecond(DateTime.now()) // true

DateTime.now().isAheadByDays(DateTime.now(), 1) // false

DateTime.now().isBehindByDays(DateTime.now(), 1) // false

DateTime.now().isMorning() // true

DateTime.now().isAfternoon() // false

DateTime.now().isEvening() // false

DateTime.now().isNight() // false

DateTime.now().isWeekend() // false

DateTime.now().isWeekday() // true

DateTime.now().isHoliday() // false

DateTime.now().daysUntil(DateTime.now()) // 0

DateTime.now().hoursUntil(DateTime.now()) // 0

DateTime.now().daysUntilEndOfYear() // 0

DateTime.now().season() // 'winter'

DateTime.now().isInSeason('winter') // true

DateTime.now().isLeapYear() // false

DateTime.now().daysUntilWeekend() // 5
```

### Enum Extensions

```dart
enum UserType { admin, user, guest }

UserType userType = UserType.admin;

userType.when({
  UserType.admin: () => debugPrint('Admin'),
  UserType.user: () => debugPrint('User'),
  UserType.guest: () => debugPrint('Guest'),
}) // 'Admin'

userType.whenOrElse({
  UserType.admin: () => debugPrint('Admin'),
  UserType.user: () => debugPrint('User'),
}, orElse: () => debugPrint('Guest')) // 'Admin'

```

### Color Extensions

- will be added soon

## Contributing

If you have any suggestions or ideas, feel free to open an issue or a pull request.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details
