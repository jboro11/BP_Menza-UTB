import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../providers/menu_provider.dart';
import '../models/models.dart';
import 'photo_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      context.read<MenuProvider>().loadMenu();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<MenuProvider>();

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        title: const Text('Dnešní menu'),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 1,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: 'Obnovit',
            onPressed: provider.isLoading
                ? null
                : () {
                    HapticFeedback.lightImpact();
                    provider.loadMenu();
                  },
          ),
        ],
      ),
      body: Column(
        children: [
          const _CanteenSelector(),
          Expanded(child: _buildContent(provider)),
        ],
      ),
    );
  }

  Widget _buildContent(MenuProvider provider) {
    if (provider.isLoading) {
      return const Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(color: Color(0xFFF37222)),
            SizedBox(height: 16),
            Text(
              'Načítám jídelníček…',
              style: TextStyle(fontSize: 20, color: Colors.black87),
            ),
          ],
        ),
      );
    }

    if (provider.meals.isEmpty) {
      if (provider.error != null) {
        return Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.error_outline, size: 64, color: Colors.red.shade400),
                const SizedBox(height: 16),
                Text(
                  'Chyba při načítání:\n${provider.error}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 18, color: Colors.black87),
                ),
                const SizedBox(height: 24),
                FilledButton.icon(
                  onPressed: () => provider.loadMenu(),
                  icon: const Icon(Icons.refresh),
                  label: const Text('Zkusit znovu'),
                ),
              ],
            ),
          ),
        );
      }
      return const Center(
        child: Text(
          'Dnes nejsou žádná jídla.',
          style: TextStyle(fontSize: 22, color: Colors.black54),
        ),
      );
    }

    return Column(
      children: [
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
        Expanded(child: _MealList(meals: provider.meals)),
      ],
    );
  }
}

class _CanteenSelector extends StatelessWidget {
  const _CanteenSelector();

  static const canteens = [
    (2, 'U4'),
    (3, 'U5'),
    (4, 'BUFET U2'),
    (6, 'U13'),
    (15, 'GARNI'),
    (16, 'U11 UNI'),
    (17, 'U15 LCFT'),
    (18, 'U16 FMK'),
    (19, 'U17 CPS'),
    (20, 'U18 FHS'),
  ];

  static const Set<int> hiddenCanteens = {16, 17, 18, 19, 20};

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<MenuProvider>();
    final visibleCanteens =
        canteens.where((canteen) => !hiddenCanteens.contains(canteen.$1)).toList();

    return Container(
      height: 72,
      padding: const EdgeInsets.symmetric(vertical: 10),
      color: Colors.white,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        itemCount: visibleCanteens.length,
        separatorBuilder: (_, __) => const SizedBox(width: 10),
        itemBuilder: (context, index) {
          final (id, label) = visibleCanteens[index];
          final selected = id == provider.canteenId;
          return ChoiceChip(
            label: Text(
              label,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: selected ? Colors.white : Colors.black87,
              ),
            ),
            selected: selected,
            selectedColor: const Color(0xFFF37222),
            backgroundColor: const Color(0xFFF0F1F4),
            side: BorderSide(color: selected ? const Color(0xFFF37222) : Colors.black12),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            onSelected: (_) {
              HapticFeedback.lightImpact();
              provider.changeCanteen(id);
            },
          );
        },
      ),
    );
  }
}

class _MealList extends StatelessWidget {
  final List<Meal> meals;
  const _MealList({required this.meals});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 24),
      itemCount: meals.length,
      separatorBuilder: (_, __) => const SizedBox(height: 14),
      itemBuilder: (context, index) => _MealCard(meal: meals[index]),
    );
  }
}

class _MealCard extends StatelessWidget {
  final Meal meal;
  const _MealCard({required this.meal});

  @override
  Widget build(BuildContext context) {
    final uploading = context.watch<MenuProvider>().uploadingMealId == meal.id;

    final Color statusColor;
    final String statusLabel;
    final IconData statusIcon;

    if (meal.hasPhoto) {
      statusColor = const Color(0xFF2E7D32);
      statusLabel = 'HOTOVO';
      statusIcon = Icons.check_circle;
    } else if (meal.localImagePath != null) {
      statusColor = const Color(0xFFF37222);
      statusLabel = 'K NAHRÁNÍ';
      statusIcon = Icons.cloud_upload;
    } else {
      statusColor = const Color(0xFFE53935);
      statusLabel = 'VYFOTIT';
      statusIcon = Icons.camera_alt;
    }

    return Card(
      margin: EdgeInsets.zero,
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: BorderSide(color: statusColor, width: 2),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: uploading ? null : () => _onTap(context),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      meal.category.isNotEmpty ? meal.category : 'Jídlo',
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF2D4E89),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                    decoration: BoxDecoration(
                      color: statusColor.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(statusIcon, size: 18, color: statusColor),
                        const SizedBox(width: 6),
                        Text(
                          statusLabel,
                          style: TextStyle(
                            color: statusColor,
                            fontSize: 13,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                meal.czechName,
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 20,
                  height: 1.25,
                  fontWeight: FontWeight.w700,
                  color: Colors.black87,
                ),
              ),
              if (uploading) ...[
                const SizedBox(height: 12),
                const SizedBox(
                  width: 22,
                  height: 22,
                  child: CircularProgressIndicator(strokeWidth: 2.5),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  void _onTap(BuildContext context) {
    HapticFeedback.lightImpact();
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => PhotoScreen(meal: meal)),
    );
  }
}
