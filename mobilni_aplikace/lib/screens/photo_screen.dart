import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import '../models/models.dart';
import '../providers/menu_provider.dart';
import '../services/image_editing_service.dart';
import '../services/upload_queue_service.dart';
import 'photo_preview_screen.dart';

class PhotoScreen extends StatefulWidget {
  final Meal meal;
  const PhotoScreen({super.key, required this.meal});

  @override
  State<PhotoScreen> createState() => _PhotoScreenState();
}

class _PhotoScreenState extends State<PhotoScreen> {
  final ImagePicker _picker = ImagePicker();
  final ImageEditingService _imageEditingService = ImageEditingService();
  String? _imagePath;
  bool _isUploading = false;
  String _uploadStatus = '';

  Future<void> _pickImage(ImageSource source) async {
    HapticFeedback.lightImpact();
    final XFile? photo = await _picker.pickImage(
      source: source,
      maxWidth: 1920,
      maxHeight: 1920,
      imageQuality: 85,
    );
    
    if (photo != null) {
      if (!mounted) return;
      setState(() {
        _isUploading = true;
        _uploadStatus = 'Zpracovávám fotografii...';
      });

      try {
        final previewData = await _imageEditingService.getPreviewBytes(
          imagePath: photo.path,
        );

        if (!mounted) return;
        setState(() {
          _isUploading = false;
          _uploadStatus = '';
        });

        final String? selectedVersion = await Navigator.push<String>(
          context,
          MaterialPageRoute(
            builder: (_) => PhotoPreviewScreen(
              originalBytes: previewData['original']!,
              filteredBytes: previewData['filtered']!,
            ),
          ),
        );

        if (selectedVersion != null && selectedVersion != 'cancel') {
          if (!mounted) return;
          setState(() {
            _isUploading = true;
            _uploadStatus = 'Nahrávám fotografii...';
          });

          final dir = await getTemporaryDirectory();
          final outFileName = 'edited_${DateTime.now().millisecondsSinceEpoch}.jpg';
          final outPath = p.join(dir.path, outFileName);
          
          final bytesToUpload = selectedVersion == 'filtered'
              ? previewData['filtered']!
              : previewData['original']!;
          await File(outPath).writeAsBytes(bytesToUpload);

          if (!mounted) return;
          setState(() {
            _imagePath = outPath;
          });

          await _uploadImage(File(outPath));
        }
      } catch (e) {
        if (!mounted) return;
        setState(() {
          _isUploading = false;
          _uploadStatus = 'Chyba při úpravě fotografie: $e';
        });
      }
    }
  }

  Future<void> _uploadImage(File imageFile) async {
    if (!mounted) return;
    setState(() {
      _isUploading = true;
      _uploadStatus = 'Nahrávám fotografii na server...';
    });

    try {
      final provider = Provider.of<MenuProvider>(context, listen: false);
      final result = await provider.uploadPhoto(widget.meal.id, imageFile.path);

      if (!mounted) return;

      if (result.success) {
        HapticFeedback.mediumImpact();
        setState(() {
          _uploadStatus = result.message;
          widget.meal.hasPhoto = true; 
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                const Icon(Icons.check_circle, color: Colors.white),
                const SizedBox(width: 8),
                Text(result.message),
              ],
            ),
            backgroundColor: const Color(0xFF28A745),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
        );
        
        // Automatický návrat zpět s krátkou prodlevou pro visual feedback
        Future.delayed(const Duration(milliseconds: 900), () {
          if (mounted) {
            Navigator.pop(context);
          }
        });
      } else {
        setState(() {
          _uploadStatus = 'Chyba: ${result.message}';
        });
      }
    } catch (e) {
      if (!mounted) return;
      
      try {
        final queueService = UploadQueueService();
        await queueService.addToQueue(
          mealId: widget.meal.id,
          mealName: widget.meal.czechName,
          tempImagePath: imageFile.path,
        );
        
        HapticFeedback.mediumImpact();
        setState(() {
          _uploadStatus = 'Chyba připojení. Fotka byla uložena do offline fronty a odešle se automaticky později.';
        });

        // Automatický návrat s prodlevou pro přečtení informace
        Future.delayed(const Duration(milliseconds: 2500), () {
          if (mounted) {
            Navigator.pop(context);
          }
        });
      } catch (queueErr) {
        setState(() {
          _uploadStatus = 'Chyba spojení se serverem: $e';
        });
      }
    } finally {
      if (!mounted) return;
      setState(() {
        _isUploading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool hasPhoto = widget.meal.hasPhoto;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Fotografie pokrmu', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black87),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(
            color: Colors.black12,
            height: 1.0,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Název jídla
            Text(
              widget.meal.czechName,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w800,
                color: Color(0xFF1A3B70),
                height: 1.3,
              ),
            ),
            const SizedBox(height: 8),

            // Alergeny
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xFFF1F3F5),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                widget.meal.allergens.isNotEmpty
                    ? 'Alergeny: ${widget.meal.allergens}'
                    : 'Bez alergenů',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 13, 
                  color: Colors.black54,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 28),

            // Okénko pro fotku nebo stav
            Container(
              width: double.infinity,
              height: 280,
              decoration: BoxDecoration(
                color: const Color(0xFFF8F9FA),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: hasPhoto ? const Color(0xFF28A745).withValues(alpha: 0.3) : Colors.grey.shade300, 
                  width: 2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.04),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  )
                ]
              ),
              clipBehavior: Clip.antiAlias,
              child: _imagePath != null
                  ? Image.file(File(_imagePath!), fit: BoxFit.cover)
                  : hasPhoto
                      ? const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.check_circle, size: 80, color: Color(0xFF28A745)),
                            SizedBox(height: 16),
                            Text(
                              "Fotografie je nahraná",
                              style: TextStyle(
                                color: Color(0xFF28A745), 
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.no_photography, size: 64, color: Colors.grey.shade400),
                            const SizedBox(height: 16),
                            Text(
                              "Žádný snímek k dispozici",
                              style: TextStyle(
                                color: Colors.grey.shade500, 
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
            ),
            const SizedBox(height: 24),
            
            // Text stavu nahrávání
            if (_isUploading || _uploadStatus.isNotEmpty)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: _uploadStatus.contains('Chyba') 
                      ? const Color(0xFFFDE8E8) 
                      : const Color(0xFFEAFAF1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  _uploadStatus,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: _uploadStatus.contains('Chyba') 
                        ? const Color(0xFFC81E1E) 
                        : const Color(0xFF1E824C),
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
              
            if (_isUploading) ...[
              const SizedBox(height: 16),
              const CircularProgressIndicator(color: Color(0xFFF37222)),
            ],

            const SizedBox(height: 24),

            // Tlačítka VYFOTIT a GALERIE vedle sebe
            if (!_isUploading)
              Row(
                children: [
                  Expanded(
                    child: FilledButton.icon(
                      onPressed: () => _pickImage(ImageSource.camera),
                      icon: const Icon(Icons.camera_alt),
                      label: const Text('Vyfotit'),
                      style: FilledButton.styleFrom(
                        backgroundColor: const Color(0xFFF37222),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        elevation: 0,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () => _pickImage(ImageSource.gallery),
                      icon: const Icon(Icons.photo_library),
                      label: const Text('Galerie'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.black87,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        side: BorderSide(color: Colors.grey.shade400, width: 1.5),
                      ),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
