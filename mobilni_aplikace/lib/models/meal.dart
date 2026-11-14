// Model jednoho jídla
class Meal {
  final int id;
  final int? categoryId;
  final String category;
  final String name;
  final String nameCz;
  final String nameEn;
  final String allergens;
  final String? studentPrice;
  final String? publicPrice;
  bool hasPhoto;
  String? localImagePath;

  Meal({
    required this.id,
    this.categoryId,
    required this.category,
    required this.name,
    String? nameCz,
    String? nameEn,
    required this.allergens,
    this.studentPrice,
    this.publicPrice,
    this.hasPhoto = false,
    this.localImagePath,
  })  : nameCz = (nameCz ?? name).trim(),
        nameEn = (nameEn ?? '').trim();

  String get czechName => nameCz.isNotEmpty ? nameCz : name;

  String get studentPriceLabel => _formatPrice(studentPrice);
  String get publicPriceLabel => _formatPrice(publicPrice);

  static String _formatPrice(String? value) {
    if (value == null || value.trim().isEmpty) {
      return '-';
    }
    return value.trim();
  }

  factory Meal.fromJson(Map<String, dynamic> json) {
    final dynamic rawCategoryId = json["category_id"];
    final rawName = _readString(
      json,
      const ['name', 'meal_name', 'title'],
    );
    final nameCz = _readString(
      json,
      const ['name_cz', 'name_cs', 'meal_name_cz', 'name'],
    );
    final nameEn = _readString(
      json,
      const ['name_en', 'meal_name_en'],
    );

    return Meal(
      id: json["meal_id"] as int? ?? 0,
      categoryId:
          rawCategoryId is int ? rawCategoryId : int.tryParse('${rawCategoryId ?? ''}'),
      category: json["category"] as String? ?? "Neznámá kategorie",
      name: rawName.isNotEmpty ? rawName : "Neznámý název",
      nameCz: nameCz.isNotEmpty ? nameCz : rawName,
      nameEn: nameEn,
      allergens: json["allergens"] as String? ?? "",
      studentPrice: _readString(
        json,
        const ['student_price', 'price_student', 'studentPrice'],
      ),
      publicPrice: _readString(
        json,
        const ['public_price', 'price_public', 'publicPrice', 'price'],
      ),
      hasPhoto: json["has_photo"] as bool? ?? false,
    );
  }

  static String _readString(Map<String, dynamic> json, List<String> keys) {
    for (final key in keys) {
      final value = json[key];
      if (value == null) {
        continue;
      }
      if (value is String) {
        final trimmed = value.trim();
        if (trimmed.isNotEmpty) {
          return trimmed;
        }
        continue;
      }
      final rendered = value.toString().trim();
      if (rendered.isNotEmpty) {
        return rendered;
      }
    }
    return '';
  }

  Map<String, dynamic> toJson() {
    return {
      'meal_id': id,
      'category_id': categoryId,
      'category': category,
      'name': name,
      'name_cz': nameCz,
      'name_en': nameEn,
      'allergens': allergens,
      'student_price': studentPrice,
      'public_price': publicPrice,
      'has_photo': hasPhoto,
    };
  }
}
