import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:image/image.dart' as img;

/// Služba pro zpracování a úpravu pořízených fotografií jídel.
class ImageEditingService {
  /// Generuje ořezané originální bajty a filtrované bajty pro porovnání v náhledu.
  /// Výpočet běží v samostatném na pozadí běžícím izolátu (Isolate).
  Future<Map<String, Uint8List>> getPreviewBytes({required String imagePath}) async {
    return compute(_processImageInIsolate, imagePath);
  }
}

/// Funkce běžící na pozadí v izolátu pro zpracování obrázku mimo hlavní UI vlákno.
Map<String, Uint8List> _processImageInIsolate(String imagePath) {
  final bytes = File(imagePath).readAsBytesSync();
  img.Image? image = img.decodeImage(bytes);

  if (image == null) {
    throw Exception('Nepodařilo se dekódovat obrázek.');
  }

  // Středový ořez na čtvercový poměr stran 1:1
  if (image.width != image.height) {
    final side = image.width < image.height ? image.width : image.height;
    final x = (image.width - side) ~/ 2;
    final y = (image.height - side) ~/ 2;
    image = img.copyCrop(image, x: x, y: y, width: side, height: side);
  }

  // Zmenšení na maximální rozlišení 1200px pro úsporu mobilních dat
  if (image.width > 1200 || image.height > 1200) {
    image = img.copyResize(
      image,
      width: image.width > image.height ? 1200 : null,
      height: image.height >= image.width ? 1200 : null,
      interpolation: img.Interpolation.linear,
    );
  }

  // Uložení originálních bajtů po ořezu (bez filtrů)
  final originalBytes = Uint8List.fromList(img.encodeJpg(image, quality: 90));

  // Aplikace filtrů (normalizace jasu, úprava saturace a kontrastu)
  var filteredImage = img.normalize(image, min: 8, max: 245);
  filteredImage = img.adjustColor(
    filteredImage,
    saturation: 1.12,
    contrast: 1.03,
    brightness: 1.02,
  );
  
  // Klasické Laplaceovo doostřovací jádro 3x3
  final sharpenKernel = [
     0, -1,  0,
    -1,  5, -1,
     0, -1,  0,
  ];
  filteredImage = img.convolution(filteredImage, filter: sharpenKernel);

  final filteredBytes = Uint8List.fromList(img.encodeJpg(filteredImage, quality: 90));

  return {
    'original': originalBytes,
    'filtered': filteredBytes,
  };
}
