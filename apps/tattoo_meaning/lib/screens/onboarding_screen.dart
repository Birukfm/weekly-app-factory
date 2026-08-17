import 'package:flutter/material.dart';

import '../config/app_config.dart';
import '../config/onboarding_copy.dart';
import 'paywall_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int _stepIndex = 0;

  void _goToNextStep() {
    if (_stepIndex >= OnboardingCopy.steps.length - 1) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute<void>(
          builder: (BuildContext context) => const PaywallScreen(),
        ),
      );
      return;
    }
    setState(() {
      _stepIndex += 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    final OnboardingStep step = OnboardingCopy.steps[_stepIndex];
    final ColorScheme colors = Theme.of(context).colorScheme;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            spacing: 24,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const Spacer(),
              Icon(step.icon, size: AppConfig.heroIconSize, color: colors.primary),
              Text(
                step.title,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              Text(
                step.body,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const Spacer(),
              FilledButton(
                onPressed: _goToNextStep,
                child: Text(
                  _stepIndex == OnboardingCopy.steps.length - 1
                      ? 'Continue'
                      : 'Next',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
