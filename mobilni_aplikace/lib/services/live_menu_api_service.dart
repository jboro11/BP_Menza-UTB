import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import '../models/models.dart';
import 'menu_api_service.dart';

// komunikace s Flask backendem (app.py)
class LiveMenuApiService implements MenuApiService {
  final String baseUrl;

  LiveMenuApiService({required this.baseUrl});

  @override
  Future<List<Meal>> fetchTodayMenu({int canteenId = 2}) async {
    final uri = Uri.parse('$baseUrl/api/mobile/menu?canteen_id=$canteenId');
    http.Response response;
    try {
      response = await http.get(uri).timeout(const Duration(seconds: 45));
    } on TimeoutException {
      throw Exception('Server odpovídá moc dlouho.');
    }

    if (response.statusCode != 200) {
      final decodedError = utf8.decode(response.bodyBytes);
      throw Exception('Server vrátil ${response.statusCode}: $decodedError');
    }

    // Flask vrací UTF-8 JSON, proto dekódujeme přes bodyBytes.
    final decoded = utf8.decode(response.bodyBytes);
    final List<dynamic> items = jsonDecode(decoded) as List<dynamic>;
    return items.map((json) {
      final map = json as Map<String, dynamic>;
      return Meal.fromJson(map);
    }).toList();
  }

  @override
  Future<UploadResult> uploadPhoto({
    required int mealId,
    required String imagePath,
  }) async {
    final uri = Uri.parse('$baseUrl/api/mobile/upload');
    final request = http.MultipartRequest('POST', uri)
      ..fields['meal_id'] = mealId.toString()
      ..files.add(await http.MultipartFile.fromPath('photo', imagePath));

    final streamed = await request.send().timeout(const Duration(seconds: 30));
    final response = await http.Response.fromStream(streamed);

    final decoded = utf8.decode(response.bodyBytes);
    final body = jsonDecode(decoded) as Map<String, dynamic>;

    if (response.statusCode == 200 && body['status'] == 'ok') {
      return UploadResult(
        success: true,
        message: body['message'] ?? 'Nahráno.',
      );
    } else {
      return UploadResult(
        success: false,
        message: body['message'] ?? 'Chyba ${response.statusCode}',
      );
    }
  }
}
