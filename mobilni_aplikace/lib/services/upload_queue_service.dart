import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

class QueueItem {
  final String id;
  final int mealId;
  final String mealName;
  final String imagePath;
  final String timestamp;

  QueueItem({
    required this.id,
    required this.mealId,
    required this.mealName,
    required this.imagePath,
    required this.timestamp,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'mealId': mealId,
        'mealName': mealName,
        'imagePath': imagePath,
        'timestamp': timestamp,
      };

  factory QueueItem.fromJson(Map<String, dynamic> json) => QueueItem(
        id: json['id'] as String,
        mealId: json['mealId'] as int,
        mealName: json['mealName'] as String? ?? 'Pokrm',
        imagePath: json['imagePath'] as String,
        timestamp: json['timestamp'] as String,
      );
}

class UploadQueueService {
  static final UploadQueueService _instance = UploadQueueService._internal();
  UploadQueueService._internal();
  factory UploadQueueService() => _instance;

  Future<File> _getQueueFile() async {
    final dir = await getApplicationDocumentsDirectory();
    final queueDir = Directory(p.join(dir.path, 'upload_queue'));
    if (!await queueDir.exists()) {
      await queueDir.create(recursive: true);
    }
    return File(p.join(queueDir.path, 'queue.json'));
  }

  Future<List<QueueItem>> getQueue() async {
    try {
      final file = await _getQueueFile();
      if (!await file.exists()) {
        return [];
      }
      final content = await file.readAsString();
      if (content.trim().isEmpty) {
        return [];
      }
      final List<dynamic> jsonList = jsonDecode(content) as List<dynamic>;
      return jsonList.map((j) => QueueItem.fromJson(j as Map<String, dynamic>)).toList();
    } catch (e) {
      return [];
    }
  }

  Future<void> _saveQueue(List<QueueItem> items) async {
    final file = await _getQueueFile();
    final jsonList = items.map((i) => i.toJson()).toList();
    await file.writeAsString(jsonEncode(jsonList));
  }

  Future<void> addToQueue({
    required int mealId,
    required String mealName,
    required String tempImagePath,
  }) async {
    // Zkopírujeme soubor z dočasného úložiště do trvalého adresáře fronty v dokumentech
    final dir = await getApplicationDocumentsDirectory();
    final queueDir = Directory(p.join(dir.path, 'upload_queue'));
    if (!await queueDir.exists()) {
      await queueDir.create(recursive: true);
    }

    final filename = 'queue_img_${mealId}_${DateTime.now().millisecondsSinceEpoch}.jpg';
    final permanentPath = p.join(queueDir.path, filename);
    await File(tempImagePath).copy(permanentPath);

    // Přidáme novou položku do serializovaného seznamu fronty
    final items = await getQueue();
    items.add(QueueItem(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      mealId: mealId,
      mealName: mealName,
      imagePath: permanentPath,
      timestamp: DateTime.now().toIso8601String(),
    ));

    await _saveQueue(items);
  }

  Future<void> removeFromQueue(String itemId) async {
    final items = await getQueue();
    final index = items.indexWhere((i) => i.id == itemId);
    if (index != -1) {
      final item = items[index];
      // Smažeme trvalý soubor z disku
      final file = File(item.imagePath);
      if (await file.exists()) {
        await file.delete();
      }
      items.removeAt(index);
      await _saveQueue(items);
    }
  }
}
