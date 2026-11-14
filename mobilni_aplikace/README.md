# Menza Foto – Flutter mobilní aplikace

Mobilní aplikace pro kuchaře v menze UTB k fotografování denních jídel.

## Funkcionalita

- Načtení dnešního jídelníčku (API / mock data)
- Barevné kódování stavu fotografie (červená = chybí, oranžová = vyfoceno, zelená = nahráno)
- Focení přes kameru telefonu
- Základní úpravy fotografií (jas, kontrast, doostření)
- Upload fotografie na backend

## Struktura projektu

```
lib/
├── main.dart                    # Vstupní bod, přepínač mock/live
├── models/
│   ├── meal.dart                # Datový model jídla
│   └── upload_result.dart       # Výsledek uploadu
├── providers/
│   └── menu_provider.dart       # Stavový management (ChangeNotifier)
├── screens/
│   ├── home_screen.dart         # Hlavní obrazovka – seznam jídel
│   └── photo_screen.dart        # Focení + editace + upload
├── services/
│   ├── menu_api_service.dart    # Abstraktní rozhraní API
│   ├── mock_menu_api_service.dart  # Mock implementace (pro vývoj)
│   ├── live_menu_api_service.dart  # Živé API (Flask backend)
│   └── image_editing_service.dart  # Úpravy obrázků (jas, kontrast)
└── widgets/                     # (pro budoucí sdílené widgety)
```

## Spuštění

```bash
# 1. Nainstaluj Flutter SDK: https://docs.flutter.dev/get-started/install
# 2. Stáhni závislosti:
flutter pub get

# 3. Spusť na připojeném zařízení / emulátoru:
flutter run --dart-define=API_BASE_URL=https://menza.example.com

# 4. Pro build APK:
flutter build apk --release --dart-define=API_BASE_URL=https://menza.example.com
```

## Připojení k backendu

V příkazech výše nahraď `https://menza.example.com` adresou svého backendu, která je dostupná z telefonu nebo emulátoru.

## Závislosti

| Balíček | Účel |
|---------|------|
| provider | Stavový management |
| http | REST API volání |
| image_picker | Focení / výběr z galerie |
| image | CPU úpravy obrázků |
| path_provider | Temp složky |
