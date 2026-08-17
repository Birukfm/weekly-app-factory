import 'package:flutter/material.dart';

class OnboardingStep {
  const OnboardingStep({
    required this.title,
    required this.body,
    required this.icon,
  });

  final String title;
  final String body;
  final IconData icon;
}

class OnboardingCopy {
  const OnboardingCopy._();

  static const List<OnboardingStep> steps = <OnboardingStep>[
    OnboardingStep(
      title: 'Snap the ink',
      body: 'Photograph a tattoo or pick one from your library.',
      icon: Icons.camera_alt_outlined,
    ),
    OnboardingStep(
      title: 'Read the meaning',
      body: 'Get the symbolism, origin, and common interpretations in seconds.',
      icon: Icons.menu_book_outlined,
    ),
    OnboardingStep(
      title: 'Keep a collection',
      body: 'Save scans and compare styles. Pro unlocks unlimited reads.',
      icon: Icons.collections_bookmark_outlined,
    ),
  ];

  static const List<String> paywallBenefits = <String>[
    'Unlimited tattoo meaning reads',
    'Full scan history',
    'Save a personal collection',
    'Cancel anytime',
  ];
}
