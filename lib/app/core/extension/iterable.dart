extension IterableHelpers<E> on Iterable<E> {
  Iterable<T> mapNotNull<T>(T? f(E e)) => map<T?>(f).whereNotNull();

  Iterable<T> whereNotNull<T>() => where((e) => e != null).whereType();

  E? firstWhereOrNull(bool test(E element)) {
    for (E element in this) {
      if (test(element)) return element;
    }
    return null;
  }

  E? get firstOrNull {
    return isNotEmpty ? first : null;
  }

  E? get lastOrNull {
    return isNotEmpty ? last : null;
  }
}

extension MapHelpers<K, V> on Map<K, V> {
  Map<K, V> operator +(Map<K, V> other) => {
        ...this,
        ...other,
      };
}

List<T> listOfNotNull<T>(Iterable<T?> items) {
  return items.whereNotNull<T>().toList();
}
