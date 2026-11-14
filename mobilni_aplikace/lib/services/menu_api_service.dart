import '../models/models.dart';

// rozhrani pro komunikaci s API (at muzeme snadno menit mock/live)
abstract class MenuApiService {
  // stahne dnesni jidelnicek
  Future<List<Meal>> fetchTodayMenu({int canteenId = 2});

  // nahraje fotku k jidlu
  Future<UploadResult> uploadPhoto({
    required int mealId,
    required String imagePath,
  });
}
