import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PhotoPreviewScreen extends StatefulWidget {
  final Uint8List originalBytes;
  final Uint8List filteredBytes;

  const PhotoPreviewScreen({
    super.key,
    required this.originalBytes,
    required this.filteredBytes,
  });

  @override
  State<PhotoPreviewScreen> createState() => _PhotoPreviewScreenState();
}

class _PhotoPreviewScreenState extends State<PhotoPreviewScreen> {
  bool _showOriginal = false;
  bool _selectedUseFilter = true;

  void _setShowOriginal(bool value) {
    if (_showOriginal != value) {
      setState(() {
        _showOriginal = value;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    const Color utbOrange = Color(0xFFF37222);

    return Scaffold(
      backgroundColor: const Color(0xFF1E2229),
      appBar: AppBar(
        title: const Text('Náhled fotografie'),
        centerTitle: true,
        backgroundColor: const Color(0xFF1E2229),
        foregroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
          child: Column(
            children: [
              // Nápověda nahoře
              const Text(
                'Přidržením prstu na fotce zobrazíte originál bez filtru',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),

              // Plocha s fotkou a detekcí gest
              Expanded(
                child: Center(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black26,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.white12, width: 1.5),
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        GestureDetector(
                          onTapDown: (_) => _setShowOriginal(true),
                          onTapUp: (_) => _setShowOriginal(!_selectedUseFilter),
                          onTapCancel: () => _setShowOriginal(!_selectedUseFilter),
                          onLongPressStart: (_) => _setShowOriginal(true),
                          onLongPressEnd: (_) => _setShowOriginal(!_selectedUseFilter),
                          child: IndexedStack(
                            index: _showOriginal ? 0 : 1,
                            children: [
                              Image.memory(
                                widget.originalBytes,
                                fit: BoxFit.contain,
                                width: double.infinity,
                                height: double.infinity,
                              ),
                              Image.memory(
                                widget.filteredBytes,
                                fit: BoxFit.contain,
                                width: double.infinity,
                                height: double.infinity,
                              ),
                            ],
                          ),
                        ),
                        
                        // Dynamický štítek v rohu indikující stav filtru
                        Positioned(
                          top: 16,
                          right: 16,
                          child: IgnorePointer(
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                color: _showOriginal
                                    ? Colors.black54
                                    : utbOrange.withValues(alpha: 0.95),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    width: 8,
                                    height: 8,
                                    decoration: BoxDecoration(
                                      color: _showOriginal ? Colors.amber : Colors.greenAccent,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  const SizedBox(width: 6),
                                  Text(
                                    _showOriginal ? 'ORIGINÁL' : 'UPRAVENO FILTREM',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Segmentovaný výběr verze k nahrání
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          HapticFeedback.lightImpact();
                          setState(() {
                            _selectedUseFilter = true;
                            _showOriginal = false;
                          });
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                            color: _selectedUseFilter
                                ? utbOrange
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.auto_awesome,
                                size: 16,
                                color: _selectedUseFilter ? Colors.white : Colors.white70,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'Vylepšená verze',
                                style: TextStyle(
                                  color: _selectedUseFilter ? Colors.white : Colors.white70,
                                  fontWeight: _selectedUseFilter
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          HapticFeedback.lightImpact();
                          setState(() {
                            _selectedUseFilter = false;
                            _showOriginal = true;
                          });
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                            color: !_selectedUseFilter
                                ? utbOrange
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.photo,
                                size: 16,
                                color: !_selectedUseFilter ? Colors.white : Colors.white70,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'Původní verze',
                                style: TextStyle(
                                  color: !_selectedUseFilter ? Colors.white : Colors.white70,
                                  fontWeight: !_selectedUseFilter
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Ovládací tlačítka dole
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {
                        HapticFeedback.lightImpact();
                        Navigator.pop(context, 'cancel');
                      },
                      icon: const Icon(Icons.close, size: 22, color: Colors.white70),
                      label: const Text(
                        'Vyfotit znovu',
                        style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 18),
                        side: const BorderSide(color: Colors.white30, width: 1.5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: FilledButton.icon(
                      onPressed: () {
                        HapticFeedback.lightImpact();
                        Navigator.pop(
                          context,
                          _selectedUseFilter ? 'filtered' : 'original',
                        );
                      },
                      icon: const Icon(Icons.check, size: 22),
                      label: const Text(
                        'Odeslat',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      style: FilledButton.styleFrom(
                        backgroundColor: utbOrange,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 18),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 0,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}
