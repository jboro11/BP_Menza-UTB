import 'dart:io';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import '../models/models.dart';
import '../services/services.dart';

class MenuProvider extends ChangeNotifier {
  static const Set<int> _hiddenCategoryIds = {5, 10};
  final MenuApiService _api;

  MenuProvider(this._api);

  // --- stav ---

  List<Meal> _meals = [];
  List<Meal> get meals => List.unmodifiable(_meals);

  List<Meal> _fastFillMeals = [];
  List<Meal> get fastFillMeals => List.unmodifiable(_fastFillMeals);

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _isOffline = false;
  bool get isOffline => _isOffline;

  String? _error;
  String? get error => _error;

  int? _uploadingMealId;  // které jídlo se právě uploaduje
  int? get uploadingMealId => _uploadingMealId;

  int _canteenId = 2;  // vybraná jídelna (default U4)
  int get canteenId => _canteenId;

  // --- lokální cache ---

  Future<File> _getCacheFile(int cId) async {
    final directory = await getApplicationDocumentsDirectory();
    return File('${directory.path}/cached_menu_$cId.json');
  }

  Future<void> _writeCache(int cId, List<Meal> list) async {
    try {
      final file = await _getCacheFile(cId);
      final jsonStr = jsonEncode(list.map((m) => m.toJson()).toList());
      await file.writeAsString(jsonStr);
    } catch (e) {
      if (kDebugMode) print('Chyba zápisu cache: $e');
    }
  }

  Future<List<Meal>> _readCache(int cId) async {
    try {
      final file = await _getCacheFile(cId);
      if (await file.exists()) {
        final jsonStr = await file.readAsString();
        final List<dynamic> decoded = jsonDecode(jsonStr);
        return decoded.map((json) => Meal.fromJson(json as Map<String, dynamic>)).toList();
      }
    } catch (e) {
      if (kDebugMode) print('Chyba čtení cache: $e');
    }
    return [];
  }

  // --- akce ---

  // změní jídelnu a načte její menu
  Future<void> changeCanteen(int id) async {
    _canteenId = id;
    notifyListeners();
    await loadMenu();
  }

  List<Meal> _filterMeals(List<Meal> list) {
    return list.where((meal) {
      if (meal.categoryId != null && _hiddenCategoryIds.contains(meal.categoryId)) {
        return false;
      }
      final categoryNormalized = meal.category.toLowerCase();
      if (categoryNormalized.contains('steril') || categoryNormalized.contains('obal')) {
        return false;
      }
      return true;
    }).toList();
  }

  // stáhne menu ze serveru s podporou offline režimu
  Future<void> loadMenu() async {
    _isLoading = true;
    _error = null;
    _isOffline = false;
    notifyListeners();

    try {
      final fetchedMeals = await _api.fetchTodayMenu(canteenId: _canteenId);
      _meals = _filterMeals(fetchedMeals);
      await _writeCache(_canteenId, _meals);
    } catch (e) {
      final cached = await _readCache(_canteenId);
      if (cached.isNotEmpty) {
        _meals = cached;
        _isOffline = true;
        _error = 'Offline režim – zobrazena uložená data.';
      } else {
        _error = 'Chyba připojení: $e';
        _meals = [];
      }
    }

    _isLoading = false;
    notifyListeners();
  }

  // stáhne a sjednotí menu pro rychlé plnění (ze všech menz)
  Future<void> loadFastFillMenu() async {
    _isLoading = true;
    _error = null;
    _isOffline = false;
    notifyListeners();

    try {
      // Backend vrací sjednocený jídelníček pro canteen_id = 0
      final fetchedMeals = await _api.fetchTodayMenu(canteenId: 0);
      _fastFillMeals = _filterMeals(fetchedMeals).where((m) => !m.hasPhoto).toList();
      await _writeCache(0, _fastFillMeals);
    } catch (e) {
      final cached = await _readCache(0);
      if (cached.isNotEmpty) {
        _fastFillMeals = cached;
        _isOffline = true;
        _error = 'Offline režim – zobrazena uložená data.';
      } else {
        _error = 'Chyba připojení: $e';
        _fastFillMeals = [];
      }
    }

    _isLoading = false;
    notifyListeners();
  }

  // uloží cestu k fotce po vyfocení lokálně
  void setLocalImage(int mealId, String path) {
    final idx = _meals.indexWhere((m) => m.id == mealId);
    if (idx != -1) {
      _meals[idx].localImagePath = path;
      notifyListeners();
    }
    final idxFast = _fastFillMeals.indexWhere((m) => m.id == mealId);
    if (idxFast != -1) {
      _fastFillMeals[idxFast].localImagePath = path;
      notifyListeners();
    }
  }



  // nahraje fotku na server a označí v obou seznamech
  Future<UploadResult> uploadPhoto(int mealId, String imagePath) async {
    _uploadingMealId = mealId;
    notifyListeners();

    final result = await _api.uploadPhoto(
      mealId: mealId,
      imagePath: imagePath,
    );

    if (result.success) {
      final idx = _meals.indexWhere((m) => m.id == mealId);
      if (idx != -1) {
        _meals[idx].hasPhoto = true;
      }
      final idxFast = _fastFillMeals.indexWhere((m) => m.id == mealId);
      if (idxFast != -1) {
        _fastFillMeals[idxFast].hasPhoto = true;
      }
    }

    _uploadingMealId = null;
    notifyListeners();
    return result;
  }
}
