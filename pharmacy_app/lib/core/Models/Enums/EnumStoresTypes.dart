enum StoreType {
  hotel, // الفنادق
  dj, // دي جي
  weddingHall // صالة أعراس
}

extension StoreTypeExtension on StoreType {
  String get arabicName {
    switch (this) {
      case StoreType.hotel:
        return 'فندق';
      case StoreType.dj:
        return 'دي جي';
      case StoreType.weddingHall:
        return 'صالة أعراس';
    }
  }

  int get value {
    switch (this) {
      case StoreType.hotel:
        return 2;
      case StoreType.dj:
        return 1;
      case StoreType.weddingHall:
        return 3;
    }
  }
}

// الدالة لتحويل الرقم إلى النص العربي
String getStoreTypeNameByValue(int value) {
  final type = StoreType.values.firstWhere(
    (type) => type.value == value,
    orElse: () => throw Exception('القيمة غير موجودة'),
  );
  return type.arabicName;
}
