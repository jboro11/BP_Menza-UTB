import 'dart:math';
import '../models/models.dart';
import 'menu_api_service.dart';

// testovaci "fake" API - vraci ukazkova data, at muzeme testovat UI bez serveru
class MockMenuApiService implements MenuApiService {
  // par testovacich jidel
  final List<Meal> _mockMeals = [
    Meal(
      id: 1,
      category: 'Polévky',
      name: 'Hovězí vývar s nudlemi',
      nameCz: 'Hovězí vývar s nudlemi',
      nameEn: 'Beef broth with noodles',
      allergens: '1; 3; 9',
      studentPrice: '39 Kč',
      publicPrice: '49 Kč',
      hasPhoto: false,
    ),
    Meal(
      id: 2,
      category: 'Polévky',
      name: 'Kulajda',
      nameCz: 'Kulajda',
      nameEn: 'Dill mushroom soup',
      allergens: '1; 3; 7',
      studentPrice: '42 Kč',
      publicPrice: '55 Kč',
      hasPhoto: true,
    ),
    Meal(
      id: 3,
      category: 'Hlavní jídla',
      name: 'Svíčková na smetaně, houskový knedlík',
      nameCz: 'Svíčková na smetaně, houskový knedlík',
      nameEn: 'Marinated sirloin with dumplings',
      allergens: '1; 3; 7',
      studentPrice: '109 Kč',
      publicPrice: '135 Kč',
      hasPhoto: false,
    ),
    Meal(
      id: 4,
      category: 'Hlavní jídla',
      name: 'Smažený kuřecí řízek, bramborový salát',
      nameCz: 'Smažený kuřecí řízek, bramborový salát',
      nameEn: 'Fried chicken schnitzel with potato salad',
      allergens: '1; 3; 7; 10',
      studentPrice: '115 Kč',
      publicPrice: '139 Kč',
      hasPhoto: false,
    ),
    Meal(
      id: 5,
      category: 'Hlavní jídla',
      name: 'Hovězí guláš, houskový knedlík',
      nameCz: 'Hovězí guláš, houskový knedlík',
      nameEn: 'Beef goulash with dumplings',
      allergens: '1; 3; 7',
      studentPrice: '105 Kč',
      publicPrice: '129 Kč',
      hasPhoto: true,
    ),
    Meal(
      id: 6,
      category: 'Hlavní jídla',
      name: 'Grilovaný losos, dušená zelenina',
      nameCz: 'Grilovaný losos, dušená zelenina',
      nameEn: 'Grilled salmon with steamed vegetables',
      allergens: '4; 7',
      studentPrice: '129 Kč',
      publicPrice: '159 Kč',
      hasPhoto: false,
    ),
    Meal(
      id: 7,
      category: 'Bezmasá jídla',
      name: 'Smažený květák, vařené brambory',
      nameCz: 'Smažený květák, vařené brambory',
      nameEn: 'Fried cauliflower with boiled potatoes',
      allergens: '1; 3; 7',
      studentPrice: '99 Kč',
      publicPrice: '119 Kč',
      hasPhoto: false,
    ),
    Meal(
      id: 8,
      category: 'Minutky',
      name: '120g Přírodní kuřecí plátek, basmati rýže',
      nameCz: '120g Přírodní kuřecí plátek, basmati rýže',
      nameEn: '120g Chicken steak with basmati rice',
      allergens: '1; 7',
      studentPrice: '112 Kč',
      publicPrice: '136 Kč',
      hasPhoto: false,
    ),
  ];

  @override
  Future<List<Meal>> fetchTodayMenu({int canteenId = 2}) async {
    // umele zpozdeni aby to vypadalo jako sitovy request
    await Future.delayed(const Duration(milliseconds: 800));
    // vratime kopii dat
    return _mockMeals
        .map((m) => Meal(
              id: m.id,
              category: m.category,
              name: m.name,
              nameCz: m.nameCz,
              nameEn: m.nameEn,
              allergens: m.allergens,
              studentPrice: m.studentPrice,
              publicPrice: m.publicPrice,
              hasPhoto: m.hasPhoto,
            ))
        .toList();
  }

  @override
  Future<UploadResult> uploadPhoto({
    required int mealId,
    required String imagePath,
  }) async {
    // simulace uploadu
    final delay = 1000 + Random().nextInt(1000);
    await Future.delayed(Duration(milliseconds: delay));

    // 90% sance na uspech, at muzeme otestovat i chybovy stav
    if (Random().nextDouble() < 0.9) {
      final idx = _mockMeals.indexWhere((m) => m.id == mealId);
      if (idx != -1) {
        _mockMeals[idx].hasPhoto = true;
        _mockMeals[idx].localImagePath = imagePath;
      }
      return const UploadResult(
        success: true,
        message: 'Fotografie úspěšně nahrána.',
      );
    } else {
      return const UploadResult(
        success: false,
        message: 'Simulovaná chyba serveru - zkuste to znovu.',
      );
    }
  }
}
