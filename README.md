A util library that contains various extensions for strings, lists, maps, and more.

## Features

- [x] String extensions
- [x] List extensions
- [x] Map extensions
- [x] DateTime extensions
- [x] Number extensions

### Installation

Add the following to your pubspec.yaml file:

```yaml
dependencies:
  extension_utils: ^1.0.0
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
```

```dart
'Hello, World!'.uncapitalize();   // hello, World!
```

```dart
'hello, world!'.titleCase();  // Hello, World!
```

```dart
'hello, world!'.underscore(); // hello_world
```

```dart
'hello, world!'.variablize(); // helloWorld
```

```dart
'hello, world!'.constantize();  // HELLO_WORLD
```

```dart
'hello, world!'.humanize(); // Hello world
```

```dart
'hello, world!'.pluralize();  // hello, worlds!
```

```dart
'hello, world!'.tableize(); // hello_worlds
```

```dart
'hello, world!'.sequenceize();  // hello_worlds
```

```dart
'hello, world!'.foreignKey(); // hello_world_id
```

```dart
'hello, world!'.pathize();  // hello/world
```

```dart
'hello, world!'.toPascalCase(); // HelloWorld
```

```dart
'hello, world!'.toSnakeCase();  // hello_world
```

```dart
'hello, world!'.toKebabCase();  // hello-world
```

```dart
'hello, world!'.toTrainCase();  // Hello-World
```

```dart
'hello, world!'.toDotCase();  // hello.world
```

```dart
'hello, world!'.toHtmlText(); // hello, world!
```

```dart
'hello,\wworld!'.escape();  // hello,\\wworld!
```

```dart
'dad'.isPalindrome(); // true
```

```dart
'email@gmail.com'.isEmail();  // true
```

```dart
'983123'.isDigits();  // true
```

```dart
'#FFFFFF'.isHexColor(); // true
```

```dart
'#FFFFFF'.toColor(); // Color(0xffffffff)
```

```dart
'hello, world!'.wordCount();  // 2
```

```dart
'hello, world!'.charCount();  // 13
```

```dart
'hello, world!'.vowelCount(); // 3
```

```dart
'hello, world!'.consonantCount(); // 8
```

```dart
'hello, world!'.syllableCount();  // 3
```

```dart
'hello, world!'.sentenceCount();  // 1
```

```dart
'hello, world!'.between('hello', '!');  // , world
```

```dart
'hello, world!'.before('world');  // hello, 
```

```dart
'hello, world!'.after('hello'); // , world!
```

```dart
'hello, world!'.beforeLast('o');  // hello, w
```

```dart
'hello, world!'.afterLast('o'); // rld!
```

```dart
'hello, world!'.beforeFirst('o'); // hell
```

```dart
'hello, world!'.afterFirst('o');  // , world!
```

```dart
'hello, world!'.startsWith('hello');  // true
```

```dart
'hello, world!'.endsWith('!');  // true
```

```dart
'hello, world!'.betweenFirst('hello', '!'); // , world
```

```dart
'hello, world!'.betweenLast('hello', '!');  // , world
```

```dart
'hello, world!'.containsIgnoreCase('HELLO');  // true
```

```dart
'hello, world!'.dropLeft(6);  // world!
```

```dart
'hello, world!'.dropRight(6); //  hello,
```

```dart
'hello, world!'.dropLeftWhile((c) => c != ' '); // world!
```

```dart
'hello, world!'.dropRightWhile((c) => c != ' ');  // hello,
```

```dart
'hello, world!'.replaceAfterFirst('hello', '!');  // hello!
```

```dart
'hello, world!'.replaceAfterLast('hello', '!'); // hello!
```

```dart
'hello, world!'.replaceBeforeFirst('hello', '!'); // !, world!
```

```dart
'hello, world!'.replaceBeforeLast('hello', '!');  // !, world!
```

```dart
'hello, world!'.replaceRange(0, 5, 'hi'); // hi, world!
```

```dart
'hello, world!'.toBytes();  // [104, 101, 108, 108, 111, 44, 32, 119, 111, 114, 108, 100, 33]
```

```dart
'hello, world!'.toBase64(); // aGVsbG8sIHdvcmxkIQ==
```

```dart
'hello, world!'.prepend('hi, ');  // hi, hello, world!
```

```dart
'hello, world!'.append('!');  // hello, world!!
```

```dart
'hello, {}!'.format(['world']); // hello, world!
```

```dart
'hello, {name}!'.formatMap({'name': 'world'});  // hello, world!
```

### List Extensions

```dart
 ['hello', 'world'].removeFirst(); // ['world']
```

```dart
['hello', 'world'].removeLast(); // ['hello']
```

```dart
['hello','world','hello','world'].removeAll('hello'); // ['world','world']
```

```dart
['lorem','ipsum','hello', 'world'].removeAllList(['lorem','hello']); // ['ipsum','world']
```

```dart
['lorem','ipsum','hello', 'world'].removeAllSet({'lorem','hello'}); // ['ipsum','world']
```

```dart
['lorem','ipsum','hello', 'world'].removeAllIterable(['lorem','hello']); // ['ipsum','world']
```

```dart
['lorem','ipsum','hello', 'world'].removeAllMapKeys({'lorem': 'ipsum', 'hello': 'world'}); // ['ipsum','world']
```

```dart
['lorem','ipsum','hello', 'world'].removeAllMapValues({'lorem': 'ipsum', 'hello': 'world'}); // ['lorem','hello']
```

```dart
[Product(qty: 5, price: 10), Product(qty: 10, price: 20)].sumBy((p) => p.qty * p.price); // 250
```

```dart
['lorem','ipsum','hello', 'world'].containsAllList(['lorem','hello']); // true
```

```dart
['lorem','ipsum','hello', 'world'].containsAllSet({'lorem','hello'}); // true
```

```dart
['lorem','ipsum','hello', 'world'].containsAllIterable(['lorem','hello']); // true
```

```dart
['lorem','ipsum','hello', 'world'].containsAllMapKeys({'lorem': 'ipsum', 'hello': 'world'}); // true
```

```dart
['lorem','ipsum','hello', 'world'].containsAllMapValues({'lorem': 'ipsum', 'hello': 'world'}); // false
```

```dart
['lorem','ipsum','hello', 'world'].mergeList(['lorem','hello']); // ['lorem','ipsum','hello', 'world','lorem','hello']
```

```dart
['lorem','ipsum','hello', 'world'].toMap(); // {'lorem': 'lorem','ipsum': 'ipsum','hello': 'hello', 'world': 'world'}
```

```dart
['lorem','ipsum','helloo', 'world'].distinctBy((a) => a.length == 5); // ['lorem','helloo']
```

```dart
['lorem','ipsum','hello', 'world'].compact(); // ['lorem','ipsum','hello', 'world']
```

```dart
['lorem','ipsum','hello', 'world'].clearAndAddAll(['lorem','hello']); // ['lorem','hello']
```

### Number Extensions

```dart
1.0.isEven(); // false
```

```dart
1.0.isOdd(); // true
```

```dart
1.0.isNegative(); // false
```

```dart
1.0.isPositive(); // true
```

```dart
1.0.isZero(); // false
```
  
```dart
(1/2).isInteger(); // false
```

```dart
-2.swapSign(); // 2
2.swapSign(); // -2
```

```dart
2.000524.toPrecision(3); // 2.00
2.000524.toPrecision(4); // 2.001
```

```dart
645123512.toCurrencyString(); // 645,123,512.00
```

```dart
2.000524.isInRange(1, 3); // true
```

```dart
9842323112.startsWith(984); // true
```

```dart
9842323112.endsWith(112); // true
```

```dart
9842323112.contains(232); // true
```

```dart
9842323112.count(2); // 3
```

```dart
12312412.indexesOfFirst(2); // 1
```

```dart
12312412.indexesOfLast(2); // 5
```

```dart
12312412.indexesOfAll(2); // [1, 5]
```

```dart
9876543210.sumOfDigits(); // 45
```

```dart
9876543210.digitsAfter(2); // 10
```

```dart
9876543210.digitsBefore(2); // 98765432
```

```dart
9876543210.digitsBetween(9, 4); // 8765
```

```dart
9872543210.digitsBeforeFirst(2); // 987
```

```dart
9872543210.digitsAfterFirst(2); // 543210
```

```dart
9872543210.digitsBeforeLast(2); // 9872543
```

```dart
9872543210.digitsAfterLast(2); // 10
```

```dart
10.loremIpsum(); // Lorem ipsum dolor sit amet, consectetur adipiscing elit. 
```

```dart
20.randomList(min: 1, max: 10); // [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
```

### Map Extensions

```dart
{}.isEmpty(); // true
```

```dart
{'hello': 'world'}.contains('hello','world'); // true
```

```dart
{'hello': 'world','lorem': 'ipsum'}.removeExact(key: 'hello', value: 'world'); // {'lorem': 'ipsum'}
```

<!-- prefixKeys
suffixKeys
prefixValues
suffixValues
capitalizeKeys
capitalizeValues
camelCaseKeys
camelCaseValues
snakeCaseKeys
snakeCaseValues
kebabCaseKeys
kebabCaseValues
split
filter
filterNull
filterEmpty
filterKeys
filterValues
filterNot
reject
rejectKeys
rejectValues
rejectNot
shift
printDebug
unique -->

```dart
{'hello': 'world','lorem': 'ipsum'}.prefixKeys('product-') // {'product-hello': 'world','product-lorem': 'ipsum'}
```

```dart
{'hello': 'world','lorem': 'ipsum'}.suffixKeys('-product') // {'hello-product': 'world','lorem-product': 'ipsum'}
```

```dart
{'hello': 'world','lorem': 'ipsum'}.prefixValues('product-') // {'hello': 'product-world','lorem': 'product-ipsum'}
```

```dart
{'hello': 'world','lorem': 'ipsum'}.suffixValues('-product') // {'hello': 'world-product','lorem': 'ipsum-product'}
```

```dart
{'hello': 'world','lorem': 'ipsum'}.capitalizeKeys() // {'Hello': 'world','Lorem': 'ipsum'}
```

```dart
{'hello': 'world','lorem': 'ipsum'}.capitalizeValues() // {'hello': 'World','lorem': 'Ipsum'}
```

```dart
{'hello world': 'lorem ipsum'}.camelCaseKeys() // {'helloWorld': 'lorem ipsum'}
```

```dart
{'hello world': 'lorem ipsum'}.camelCaseValues() // {'hello world': 'loremIpsum'}
```

```dart
{'hello world': 'lorem ipsum'}.snakeCaseKeys() // {'hello_world': 'lorem ipsum'}
```

```dart
{'hello world': 'lorem ipsum'}.snakeCaseValues() // {'hello world': 'lorem_ipsum'}
```

```dart
{'hello world': 'lorem ipsum'}.kebabCaseKeys() // {'hello-world': 'lorem ipsum'}
```

```dart
{'hello world': 'lorem ipsum'}.kebabCaseValues() // {'hello world': 'lorem-ipsum'}
```

```dart
///List<Map<K, V>> partition<K, V>(bool Function(K key, V value) predicate)
{'hello': 'world','lorem': 'ipsum','hi': 'there'}.partition((key, value) => key.length == 5); // [{'hello': 'world', 'lorem': 'ipsum'},{'hi': 'there'}]
```

```dart
{'hello': 'world','lorem': 'ipsum'}.filter((key, value) => key == 'hello') // {'hello': 'world'}
```

```dart
{'hello': 'world','lorem': 'ipsum'}.filterNull() // {'hello': 'world','lorem': 'ipsum'}
```

```dart
{'hello': 'world','lorem': 'ipsum'}.filterEmpty() // {'hello': 'world','lorem': 'ipsum'}
```

```dart
{'hello': 'world','lorem': 'ipsum'}.filterKeys(['hello']) // {'hello': 'world'}
```

```dart
{'hello': 'world','lorem': 'ipsum'}.filterValues(['world']) // {'hello': 'world'}
```

```dart
{'hello': 'world','lorem': 'ipsum'}.filterNot((key, value) => key == 'hello') // {'lorem': 'ipsum'}
```

```dart
{'hello': 'world','lorem': 'ipsum'}.reject((key, value) => key == 'hello') // {'lorem': 'ipsum'}
```

```dart
{'hello': 'world','lorem': 'ipsum'}.rejectKeys(['hello']) // {'lorem': 'ipsum'}
```

```dart
{'hello': 'world,lorem': 'ipsum'}.rejectValues(['world']) // {'lorem': 'ipsum'}
```

```dart
{'hello': 'world','lorem': 'ipsum'}.rejectNot((key, value) => key == 'hello') // {'hello': 'world'}
```

```dart
{'hello': 'world','lorem': 'ipsum'}.shift() // {'lorem': 'ipsum'}
```

```dart
{'hello': 'world','lorem': 'ipsum'}.printDebug(label: 'Map', separator: ': ', indent: ',  ') // Map: hello: world,  lorem: ipsum
```

```dart
{'hello': 'world','lorem': 'ipsum','lo': 'ipsum'}.uniqueValues() // {'hello': 'world','lorem': 'ipsum'}
```

### DateTime Extensions

```dart
DateTime.now().isToday() // true
```

```dart
DateTime.now().isYesterday() // false
```

```dart
DateTime.now().isTomorrow() // false
```

```dart
DateTime.now().isPast() // false
```

```dart
DateTime.now().isFuture() // false
```

```dart
DateTime.now().isSameDay(DateTime.now()) // true
```

```dart
DateTime.now().isSameMonth(DateTime.now()) // true
```

```dart
DateTime.now().isSameYear(DateTime.now()) // true
```

```dart
DateTime.now().isSameHour(DateTime.now()) // true
```

```dart
DateTime.now().isSameMinute(DateTime.now()) // true
```

```dart
DateTime.now().isSameSecond(DateTime.now()) // true
```

```dart
DateTime.now().isSameMillisecond(DateTime.now()) // true
```

```dart
DateTime.now().isAheadByDays(DateTime.now(), 1) // false
```

```dart
DateTime.now().isBehindByDays(DateTime.now(), 1) // false
```

```dart
DateTime.now().isMorning() // true
```

```dart
DateTime.now().isAfternoon() // false
```

```dart
DateTime.now().isEvening() // false
```

```dart
DateTime.now().isNight() // false
```

```dart
DateTime.now().isWeekend() // false
```

```dart
DateTime.now().isWeekday() // true
```

```dart
DateTime.now().isHoliday() // false
```

```dart
DateTime.now().daysUntil(DateTime.now()) // 0
```

```dart
DateTime.now().hoursUntil(DateTime.now()) // 0
```

```dart
DateTime.now().daysUntilEndOfYear() // 0
```

```dart
DateTime.now().season() // 'winter'
```

```dart
DateTime.now().isInSeason('winter') // true
```

```dart
DateTime.now().isLeapYear() // false
```

```dart
DateTime.now().daysUntilWeekend() // 5
```
  

## Contributing

If you have any suggestions or ideas, feel free to open an issue or a pull request.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details
