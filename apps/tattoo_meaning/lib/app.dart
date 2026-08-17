import 'package:flutter/material.dart';

import 'config/app_config.dart';
import 'data/scan_repository.dart';
import 'data/scan_scope.dart';
import 'premium/premium_controller.dart';
import 'premium/premium_scope.dart';
import 'screens/bootstrap_screen.dart';

class FactoryApp extends StatefulWidget {
  const FactoryApp({super.key});

  @override
  State<FactoryApp> createState() => _FactoryAppState();
}

class _FactoryAppState extends State<FactoryApp> {
  final PremiumController _premium = PremiumController();
  final ScanRepository _scans = ScanRepository();

  @override
  void initState() {
    super.initState();
    _premium.executeInitialize();
    _scans.executeLoad();
  }

  @override
  void dispose() {
    _premium.dispose();
    _scans.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PremiumScope(
      controller: _premium,
      child: ScanScope(
        repository: _scans,
        child: ListenableBuilder(
          listenable: Listenable.merge(<Listenable>[_premium, _scans]),
          builder: (BuildContext context, Widget? child) => child!,
          child: MaterialApp(
            title: AppConfig.appName,
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: AppConfig.seedColor),
              useMaterial3: true,
            ),
            home: const BootstrapScreen(),
          ),
        ),
      ),
    );
  }
}
