class AppConfig {
  // Lze prepsat pri buildu: --dart-define=API_BASE_URL=https://tvoje-domena
  static const String backendUrl =
      String.fromEnvironment('API_BASE_URL', defaultValue: 'https://menza.example.com');
}
