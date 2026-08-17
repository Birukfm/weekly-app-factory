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
      title: 'See the problem',
      body: 'Open the camera or pick a photo and get an answer in seconds.',
      icon: Icons.center_focus_strong,
    ),
    OnboardingStep(
      title: 'Save what matters',
      body: 'History and collection keep every result so you can come back.',
      icon: Icons.collections_bookmark_outlined,
    ),
    OnboardingStep(
      title: 'Unlock Pro',
      body: 'Unlimited scans, full history, and no watermarks.',
      icon: Icons.workspace_premium_outlined,
    ),
  ];

  static const List<String> paywallBenefits = <String>[
    'Unlimited identifications',
    'Full history and collection',
    'Priority results',
    'Cancel anytime',
  ];
}
