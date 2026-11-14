import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../models/models.dart';
import '../providers/menu_provider.dart';
import 'photo_screen.dart';

class FastFillScreen extends StatefulWidget {
  const FastFillScreen({super.key});

  @override
  State<FastFillScreen> createState() => _FastFillScreenState();
}

class _FastFillScreenState extends State<FastFillScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      context.read<MenuProvider>().loadFastFillMenu();
    });
  }

  // Seskupí jídla podle kategorií
  List<Widget> buildCategorizedList(List<Meal> meals) {
    final categories = meals.map((m) => m.category).toSet().toList();
    List<Widget> widgets = [];

    for (var cat in categories) {
      final categoryMeals = meals.where((m) => m.category == cat).toList();

      widgets.add(
        Padding(
          padding: const EdgeInsets.only(top: 24, bottom: 10, left: 20, right: 20),
          child: Row(
            children: [
              Container(
                width: 4,
                height: 20,
                decoration: BoxDecoration(
                  color: const Color(0xFFF37222), // UTB Oranžová
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  cat.isNotEmpty ? cat : 'Ostatní pokrmy',
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 18,
                    color: Color(0xFF1A3B70), // UTB Tmavě modrá
                    letterSpacing: 0.3,
                  ),
                ),
              ),
            ],
          ),
        ),
      );

      for (var meal in categoryMeals) {
        widgets.add(buildMealCard(meal));
      }
    }

    return widgets;
  }

  Widget buildMealCard(Meal meal) {
    final bool hasPhoto = meal.hasPhoto;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
      elevation: 0,
      color: hasPhoto ? const Color(0xFFF1FDF3) : const Color(0xFFFFF5F5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: hasPhoto ? const Color(0xFFC3E6CB) : const Color(0xFFFFD2D2),
          width: 1.5,
        ),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: hasPhoto ? const Color(0xFFE2F6E7) : const Color(0xFFFFECEC),
            shape: BoxShape.circle,
          ),
          child: Icon(
            hasPhoto ? Icons.check_circle : Icons.camera_enhance,
            color: hasPhoto ? const Color(0xFF28A745) : const Color(0xFFDC3545),
            size: 24,
          ),
        ),
        title: Text(
          meal.czechName,
          style: const TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 16,
            color: Colors.black87,
            height: 1.3,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 6.0),
          child: Text(
            meal.allergens.isNotEmpty ? 'Alergeny: ${meal.allergens}' : 'Bez alergenů',
            style: TextStyle(
              fontSize: 13,
              color: Colors.black54,
              fontWeight: meal.allergens.isNotEmpty ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.black26),
        onTap: () async {
          HapticFeedback.lightImpact();
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PhotoScreen(meal: meal),
            ),
          );
          // Po návratu z focení aktualizujeme seznam
          if (mounted) {
            context.read<MenuProvider>().loadFastFillMenu();
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<MenuProvider>();
    final meals = provider.fastFillMeals;

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        title: const Text(
          'Rychlé plnění (všechny menzy)',
          style: TextStyle(fontWeight: FontWeight.w800, letterSpacing: 0.2, fontSize: 19),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(
            color: Colors.black12,
            height: 1.0,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: provider.isLoading
                ? null
                : () {
                    HapticFeedback.lightImpact();
                    provider.loadFastFillMenu();
                  },
          ),
        ],
      ),
      body: Column(
        children: [
          // Banner pro offline režim nebo varování
          if (provider.isOffline)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              color: const Color(0xFFFFF3CD),
              child: const Row(
                children: [
                  Icon(Icons.wifi_off, color: Color(0xFF856404), size: 20),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Pracujete v offline režimu. Zobrazena jsou naposledy uložená jídla.',
                      style: TextStyle(
                        color: Color(0xFF856404),
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ],
              ),
            ),

          Expanded(
            child: provider.isLoading
                ? const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(color: Color(0xFFF37222)),
                        SizedBox(height: 16),
                        Text(
                          'Načítám pokrmy ze všech menz...',
                          style: TextStyle(color: Colors.black54, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  )
                : provider.error != null && meals.isEmpty
                    ? Center(
                        child: Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.cloud_off, size: 64, color: Colors.black26),
                              const SizedBox(height: 16),
                              Text(
                                provider.error!,
                                textAlign: TextAlign.center,
                                style: const TextStyle(color: Colors.black54, fontSize: 15),
                              ),
                              const SizedBox(height: 24),
                              FilledButton.icon(
                                onPressed: () => provider.loadFastFillMenu(),
                                icon: const Icon(Icons.refresh),
                                label: const Text('Zkusit znovu'),
                                style: FilledButton.styleFrom(
                                  backgroundColor: const Color(0xFFF37222),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    : meals.isEmpty
                        ? const Center(
                            child: Padding(
                              padding: EdgeInsets.all(32.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.check_circle_outline,
                                    size: 96,
                                    color: Color(0xFFF37222),
                                  ),
                                  SizedBox(height: 24),
                                  Text(
                                    'Skvělá práce! Všechna jídla jsou pro dnešek vyfocená.',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Color(0xFF46505A),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      height: 1.4,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        : RefreshIndicator(
                            onRefresh: () => provider.loadFastFillMenu(),
                            color: const Color(0xFFF37222),
                            child: ListView(
                              physics: const AlwaysScrollableScrollPhysics(),
                              padding: const EdgeInsets.only(bottom: 32),
                              children: buildCategorizedList(meals),
                            ),
                          ),
          ),
        ],
      ),
    );
  }
}
