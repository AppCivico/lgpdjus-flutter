extension SafetlyParser on Object {
  double safeParseDouble({double defValue: 0}) {
    final value = this;

    if (value is String) {
      return double.tryParse(value) ?? defValue;
    } else if (value is num) {
      return value.toDouble();
    }

    return defValue;
  }

  int safeParseInt({int defValue: 0}) {
    final value = this;

    if (value is String) {
      return int.tryParse(value) ?? defValue;
    } else if (value is num) {
      return value.toInt();
    }

    return defValue;
  }

  bool safeParseBool() {
    try {
      return this == 1;
    } catch (e) {
      return false;
    }
  }
}
