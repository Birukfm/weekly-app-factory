import 'package:flutter/material.dart';

import '../premium/session_store.dart';
import 'home_shell.dart';
import 'onboarding_screen.dart';

class BootstrapScreen extends StatefulWidget {
  const BootstrapScreen({super.key});

  @override
  State<BootstrapScreen> createState() => _BootstrapScreenState();
}

class _BootstrapScreenState extends State<BootstrapScreen> {
  @override
  void initState() {
    super.initState();
    _openStartRoute();
  }

  Future<void> _openStartRoute() async {
    final bool hasCompletedOnboarding =
        await const SessionStore().readHasCompletedOnboarding();
    if (!mounted) {
      return;
    }
    final Widget next = hasCompletedOnboarding
        ? const HomeShell()
        : const OnboardingScreen();
    Navigator.of(context).pushReplacement(
      MaterialPageRoute<void>(builder: (BuildContext context) => next),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
