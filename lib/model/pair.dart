/// A wrapper class for a pair of objects.
/// It is used to return two objects from a function.
/// [T] is the type of the first object.
/// [U] is the type of the second object.

class Pair<T, U> {
  T first;
  U second;

  Pair(this.first, this.second);

  @override
  String toString() {
    return '($first, $second)';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Pair &&
          runtimeType == other.runtimeType &&
          first == other.first &&
          second == other.second;

  @override
  int get hashCode => first.hashCode ^ second.hashCode;
}
