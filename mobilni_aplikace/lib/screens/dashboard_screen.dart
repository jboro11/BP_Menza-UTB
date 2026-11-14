import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../models/models.dart';
import '../providers/menu_provider.dart';
import '../services/upload_queue_service.dart';
import 'home_screen.dart';
import 'fast_fill_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final UploadQueueService _queueService = UploadQueueService();
  List<QueueItem> _pendingItems = [];
  bool _isSyncing = false;

  @override
  void initState() {
    super.initState();
    _loadQueue();
  }

  Future<void> _loadQueue() async {
    final items = await _queueService.getQueue();
    if (mounted) {
      setState(() {
        _pendingItems = items;
      });
    }
  }

  Future<void> _syncQueue() async {
    if (_pendingItems.isEmpty || _isSyncing) return;

    HapticFeedback.lightImpact();
    setState(() {
      _isSyncing = true;
    });

    int successCount = 0;
    int failCount = 0;

    final provider = Provider.of<MenuProvider>(context, listen: false);
    final List<QueueItem> itemsToSync = List.from(_pendingItems);

    for (final item in itemsToSync) {
      try {
        final result = await provider.uploadPhoto(item.mealId, item.imagePath);
        if (result.success) {
          await _queueService.removeFromQueue(item.id);
          successCount++;
        } else {
          failCount++;
        }
      } catch (e) {
        failCount++;
      }
    }

    await _loadQueue();

    if (mounted) {
      setState(() {
        _isSyncing = false;
      });

      if (successCount > 0) {
        HapticFeedback.mediumImpact();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                const Icon(Icons.cloud_done, color: Colors.white),
                const SizedBox(width: 8),
                Text('Úspěšně odesláno: $successCount fotek.'),
              ],
            ),
            backgroundColor: const Color(0xFF28A745),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
        );
      } else if (failCount > 0) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                const Icon(Icons.cloud_off, color: Colors.white),
                const SizedBox(width: 8),
                const Text('Některé fotky se nepodařilo odeslat. Zkuste to znovu.'),
              ],
            ),
            backgroundColor: const Color(0xFFC81E1E),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    const Color utbOrange = Color(0xFFF37222);
    final int pendingCount = _pendingItems.length;

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Icon(Icons.restaurant, size: 72, color: utbOrange),
              const SizedBox(height: 16),
              const Text(
                'Menza UTB',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w900,
                  color: Colors.black87,
                  letterSpacing: -0.5,
                ),
              ),

              if (pendingCount > 0) ...[
                const SizedBox(height: 24),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFF3CD),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: const Color(0xFFFFEBAA), width: 1.5),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.cloud_off_rounded, color: Color(0xFF856404), size: 28),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Text(
                          'Máte $pendingCount neodeslaných fotek. Připojte se k internetu.',
                          style: const TextStyle(
                            color: Color(0xFF856404),
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: _isSyncing
                            ? const SizedBox(
                                width: 22,
                                height: 22,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2.5,
                                  color: Color(0xFF856404),
                                ),
                              )
                            : const Icon(Icons.sync_rounded, color: Color(0xFF856404), size: 26),
                        onPressed: _isSyncing ? null : _syncQueue,
                      ),
                    ],
                  ),
                ),
              ],
               
              const Spacer(),

              // Tlačítko 1: Klasický jídelníček
              _buildBigButton(
                context,
                title: 'Jídelníček',
                subtitle: 'Pomalé plnění podle vybrané menzy',
                icon: Icons.calendar_today_rounded,
                color: Colors.white,
                textColor: Colors.black87,
                iconColor: Colors.black54,
                onTap: () async {
                  HapticFeedback.lightImpact();
                  await Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const HomeScreen()),
                  );
                  _loadQueue();
                },
              ),

              const SizedBox(height: 20),

              // Tlačítko 2: Rychlé plnění
              _buildBigButton(
                context,
                title: 'Rychlé plnění',
                subtitle: 'Zobrazit pouze jídla bez fotografie',
                icon: Icons.bolt_rounded,
                color: utbOrange,
                textColor: Colors.white,
                iconColor: Colors.white,
                isPrimary: true,
                onTap: () async {
                  HapticFeedback.lightImpact();
                  await Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const FastFillScreen()),
                  );
                  _loadQueue();
                },
              ),
              
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBigButton(
    BuildContext context, {
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required Color textColor,
    required Color iconColor,
    required VoidCallback onTap,
    bool isPrimary = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(24),
        boxShadow: isPrimary
          ? [BoxShadow(color: color.withValues(alpha: 0.4), blurRadius: 16, offset: const Offset(0, 8))]
            : [const BoxShadow(color: Colors.black12, blurRadius: 12, offset: Offset(0, 4))],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(24),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Row(
              children: [
                Icon(icon, size: 40, color: iconColor),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: textColor,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        subtitle,
                        style: TextStyle(
                          fontSize: 14,
                          color: textColor.withValues(alpha: 0.8),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
