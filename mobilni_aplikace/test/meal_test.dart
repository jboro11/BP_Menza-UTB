// test pro model Meal - parsovani JSON dat ze serveru
import 'package:flutter_test/flutter_test.dart';
import 'package:menza_foto/models/meal.dart';

void main() {
  group('Meal.fromJson', () {

    test('standardni vstup - vsechna pole', () {
      // standardni JSON odpoved ze serveru
      final json = {
        'meal_id': 42,
        'name': 'Svickova na smetane',
        'category': 'Jidlo',
        'allergens': '1, 7',
        'has_photo': false,
      };
      final meal = Meal.fromJson(json);

      expect(meal.id, equals(42));
      expect(meal.czechName, equals('Svickova na smetane'));
      expect(meal.category, equals('Jidlo'));
      expect(meal.allergens, equals('1, 7'));
      expect(meal.hasPhoto, isFalse);
    });

    test('has_photo true', () {
      // jidlo, ktere uz ma nahranou fotku
      final json = {
        'meal_id': 10,
        'name': 'Rizek',
        'category': 'Hlavni jidlo',
        'allergens': '1, 3',
        'has_photo': true,
      };
      final meal = Meal.fromJson(json);
      expect(meal.hasPhoto, isTrue);
    });

    test('chybejici alergeny vrati prazdny retezec', () {
      // server muze vratit null nebo chybejici klic
      final json = {
        'meal_id': 5,
        'name': 'Polevka',
        'category': 'Polevka',
        'has_photo': false,
      };
      final meal = Meal.fromJson(json);
      expect(meal.allergens, equals(''));
    });

    test('chybejici kategorie vrati prazdny retezec', () {
      final json = {
        'meal_id': 7,
        'name': 'Dezert',
        'has_photo': false,
      };
      final meal = Meal.fromJson(json);
      expect(meal.category, equals(''));
    });

    test('null hodnoty nehodí vyjimku', () {
      // server muze vratit null pro volitelne pole
      final json = {
        'meal_id': 99,
        'name': 'Testovaci jidlo',
        'category': null,
        'allergens': null,
        'has_photo': false,
      };
      // nema vyhodit vyjimku
      expect(() => Meal.fromJson(json), returnsNormally);
    });
  });
}
