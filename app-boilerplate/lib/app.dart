import 'package:flutter/material.dart';

import 'config/app_config.dart';
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

  @override
  void dispose() {
    _premium.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PremiumScope(
      controller: _premium,
      child: MaterialApp(
        title: AppConfig.appName,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: AppConfig.seedColor),
          useMaterial3: true,
        ),
        home: const BootstrapScreen(),
      ),
    );
  }
}
