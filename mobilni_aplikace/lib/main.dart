import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/menu_provider.dart';
import 'services/services.dart';
import 'screens/pin_gate_screen.dart';
import 'config/app_config.dart';

// Přepínač pro použití testovacích (mock) dat (true) nebo produkčního API (false)
const bool kUseMockApi = false;

void main() {
  runApp(const MenzaFotoApp());
}

class MenzaFotoApp extends StatelessWidget {
  const MenzaFotoApp({super.key});

  @override
  Widget build(BuildContext context) {
    // podle prepinace vybereme mock nebo live API
    final MenuApiService api = kUseMockApi
        ? MockMenuApiService()
      : LiveMenuApiService(baseUrl: AppConfig.backendUrl);

    return ChangeNotifierProvider(
      create: (_) => MenuProvider(api),
      child: MaterialApp(
        title: 'Menza UTB – Foto',
        debugShowCheckedModeBanner: false,

        theme: ThemeData(
          useMaterial3: true,
          brightness: Brightness.light,
          primaryColor: const Color(0xFFF37222),
          scaffoldBackgroundColor: const Color(0xFFF9FBFC),
          fontFamily: 'PlusJakartaSans',
          colorScheme: const ColorScheme.light(
            primary: Color(0xFFF37222),
            onPrimary: Colors.white,
            secondary: Color(0xFFBECDD2),
            onSecondary: Color(0xFF46505A),
            surface: Colors.white,
            onSurface: Color(0xFF46505A),
          ),
          appBarTheme: const AppBarTheme(
            centerTitle: true,
            elevation: 0,
            backgroundColor: Colors.white,
            foregroundColor: Color(0xFF46505A),
            iconTheme: IconThemeData(color: Color(0xFF46505A)),
            titleTextStyle: TextStyle(
              fontFamily: 'PlusJakartaSans',
              color: Color(0xFF46505A),
              fontSize: 19,
              fontWeight: FontWeight.bold,
            ),
          ),
          cardTheme: CardThemeData(
            elevation: 0,
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: const BorderSide(color: Color(0xFFBECDD2), width: 1.5),
            ),
          ),
          filledButtonTheme: FilledButtonThemeData(
            style: FilledButton.styleFrom(
              backgroundColor: const Color(0xFFF37222),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 0,
            ),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFF37222),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 0,
            ),
          ),
          outlinedButtonTheme: OutlinedButtonThemeData(
            style: OutlinedButton.styleFrom(
              foregroundColor: const Color(0xFF46505A),
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
              side: const BorderSide(color: Color(0xFFBECDD2), width: 1.5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              foregroundColor: const Color(0xFFF37222),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),

        darkTheme: ThemeData(
          useMaterial3: true,
          brightness: Brightness.dark,
          primaryColor: const Color(0xFFF37222),
          fontFamily: 'PlusJakartaSans',
          colorScheme: const ColorScheme.dark(
            primary: Color(0xFFF37222),
            onPrimary: Colors.white,
            secondary: Color(0xFFBECDD2),
            onSecondary: Colors.white,
          ),
        ),

        home: const PinGateScreen(),
      ),
    );
  }
}
