import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import '../config/app_config.dart';
import 'dashboard_screen.dart';

class PinGateScreen extends StatefulWidget {
  const PinGateScreen({super.key});

  @override
  State<PinGateScreen> createState() => _PinGateScreenState();
}

class _PinGateScreenState extends State<PinGateScreen> {
  static const int _maxAttempts = 5;
  static const int _cooldownSeconds = 30;

  final TextEditingController _pinController = TextEditingController();
  Timer? _cooldownTimer;

  int _failedAttempts = 0;
  int _secondsLeft = 0;
  String? _errorText;

  bool get _isLocked => _secondsLeft > 0;

  @override
  void dispose() {
    _cooldownTimer?.cancel();
    _pinController.dispose();
    super.dispose();
  }

  Future<void> _confirmPin() async {
    if (_isLocked) return;
    HapticFeedback.lightImpact();

    final pin = _pinController.text.trim();
    if (pin.isEmpty) return;

    setState(() {
      _errorText = null;
    });

    try {
      final response = await http.post(
        Uri.parse('${AppConfig.backendUrl}/api/mobile/verify_pin'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'pin': pin}),
      ).timeout(const Duration(seconds: 8));

      if (!mounted) return;

      if (response.statusCode == 200) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const DashboardScreen()),
        );
      } else {
        // Zpracování chybového kódu ze serveru
        String errMsg = 'Nesprávný PIN.';
        try {
          final body = jsonDecode(response.body) as Map<String, dynamic>;
          errMsg = body['message'] ?? errMsg;
        } catch (_) {}

        setState(() {
          _failedAttempts += 1;
          _pinController.clear();
          _errorText = '$errMsg ($_failedAttempts/$_maxAttempts).';
        });

        if (_failedAttempts >= _maxAttempts) {
          _startCooldown();
        }
      }
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _pinController.clear();
        _errorText = 'Chyba připojení k serveru.';
      });
    }
  }

  void _startCooldown() {
    _cooldownTimer?.cancel();
    setState(() {
      _failedAttempts = 0;
      _secondsLeft = _cooldownSeconds;
      _errorText = 'Příliš mnoho pokusů. Zkuste to za $_secondsLeft s.';
    });

    _cooldownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }

      if (_secondsLeft <= 1) {
        timer.cancel();
        setState(() {
          _secondsLeft = 0;
          _errorText = null;
        });
        return;
      }

      setState(() {
        _secondsLeft -= 1;
        _errorText = 'Příliš mnoho pokusů. Zkuste to za $_secondsLeft s.';
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    const Color utbOrange = Color(0xFFF37222);

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 360),
            child: Card(
              elevation: 0,
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(28),
                side: const BorderSide(color: Colors.black12, width: 1.5),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 36.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const CircleAvatar(
                      radius: 36,
                      backgroundColor: Color(0xFFFFF5E6),
                      child: Icon(Icons.lock_outline, size: 36, color: utbOrange),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Zadejte PIN',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 22, 
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF1A3B70),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Pro přístup k aplikaci zadejte kód obsluhy.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.black54,
                      ),
                    ),
                    const SizedBox(height: 28),

                    TextField(
                      controller: _pinController,
                      obscureText: true,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 20, letterSpacing: 8, fontWeight: FontWeight.bold),
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.done,
                      enabled: !_isLocked,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(4),
                      ],
                      onSubmitted: (_) => _confirmPin(),
                      decoration: InputDecoration(
                        hintText: '••••',
                        hintStyle: const TextStyle(letterSpacing: 4),
                        contentPadding: const EdgeInsets.symmetric(vertical: 16),
                        filled: true,
                        fillColor: const Color(0xFFF8F9FA),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: const BorderSide(color: utbOrange, width: 2),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    if (_errorText != null)
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: _isLocked ? const Color(0xFFFFF3CD) : const Color(0xFFFDE8E8),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          _errorText!,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: _isLocked ? const Color(0xFF856404) : const Color(0xFFC81E1E),
                            fontWeight: FontWeight.w700,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    const SizedBox(height: 20),

                    FilledButton(
                      onPressed: _isLocked ? null : _confirmPin,
                      style: FilledButton.styleFrom(
                        backgroundColor: utbOrange,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        elevation: 0,
                      ),
                      child: Text(
                        _isLocked ? 'Počkejte ($_secondsLeft s)' : 'Potvrdit',
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
