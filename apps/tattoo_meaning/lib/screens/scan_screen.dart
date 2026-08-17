import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../config/app_config.dart';
import '../data/meaning_interpreter.dart';
import '../data/on_device_catalog.dart';
import '../data/scan_repository.dart';
import '../data/scan_scope.dart';
import '../data/tattoo_scan.dart';
import '../premium/premium_controller.dart';
import '../premium/premium_scope.dart';
import '../premium/review_prompt.dart';
import 'paywall_screen.dart';
import 'result_screen.dart';

class ScanScreen extends StatefulWidget {
  const ScanScreen({super.key});

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  final ImagePicker _picker = ImagePicker();
  final MeaningInterpreter _interpreter = MeaningInterpreter();
  bool _isReading = false;
  String? _errorMessage;

  Future<void> _executePick(ImageSource source) async {
    final PremiumController premium = PremiumScope.of(context);
    if (!premium.canUseFreeTier) {
      await Navigator.of(context).push(
        MaterialPageRoute<void>(
          builder: (BuildContext context) => const PaywallScreen(),
        ),
      );
      return;
    }
    final XFile? file = await _picker.pickImage(
      source: source,
      maxWidth: 1024,
      imageQuality: 85,
    );
    if (file == null || !mounted) {
      return;
    }
    await _executeRead(await file.readAsBytes());
  }

  Future<void> _executeRead(Uint8List bytes) async {
    final PremiumController premium = PremiumScope.of(context);
    final ScanRepository scans = ScanScope.of(context);
    if (bytes.length > AppConfig.maxImageBytes) {
      setState(() {
        _errorMessage = 'Choose a smaller photo and try again.';
      });
      return;
    }
    premium.consumeFreeUse();
    setState(() {
      _isReading = true;
      _errorMessage = null;
    });
    try {
      final MeaningResult meaning = await _interpreter.executeRead(bytes);
      final TattooScan scan = await scans.executeSaveNew(
        scan: meaning.toScan(id: '', imagePath: ''),
        imageBytes: bytes,
      );
      if (!mounted) {
        return;
      }
      if (!scan.usedOnDeviceFallback) {
        await ReviewPrompt.executeAfterSuccess();
      }
      if (!mounted) {
        return;
      }
      await Navigator.of(context).push(
        MaterialPageRoute<void>(
          builder: (BuildContext context) => ResultScreen(scan: scan),
        ),
      );
    } catch (_) {
      premium.refundFreeUse();
      if (!mounted) {
        return;
      }
      setState(() {
        _errorMessage = 'Could not read that photo. Try another angle.';
      });
    } finally {
      if (mounted) {
        setState(() {
          _isReading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(title: const Text(AppConfig.appName)),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            spacing: 16,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const Spacer(),
              Icon(Icons.camera_alt_outlined, size: AppConfig.heroIconSize, color: colors.primary),
              Text(
                'Photograph a tattoo to read its meaning.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              if (_errorMessage != null)
                Text(
                  _errorMessage!,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: colors.error),
                ),
              if (_isReading) const Center(child: CircularProgressIndicator()),
              const Spacer(),
              FilledButton(
                onPressed: _isReading ? null : () => _executePick(ImageSource.camera),
                child: const Text('Camera'),
              ),
              OutlinedButton(
                onPressed: _isReading ? null : () => _executePick(ImageSource.gallery),
                child: const Text('Photo library'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
