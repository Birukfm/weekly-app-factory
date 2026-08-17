import 'package:flutter/material.dart';

class AppConfig {
  const AppConfig._();

  static const String appName = 'Tattoo Meaning';
  static const String privacyPolicyUrl =
      'https://birukfm.github.io/weekly-app-factory/tattoo-meaning/privacy.html';
  static const String termsOfUseUrl =
      'https://birukfm.github.io/weekly-app-factory/tattoo-meaning/terms.html';
  static const String supportEmail = 'support@nojic.net';
  static const String privacyEmail = 'privacy@nojic.net';
  static const String weeklyProductId = 'tattoomeaning_weekly';
  static const String yearlyProductId = 'tattoomeaning_yearly';
  static const String lifetimeProductId = 'tattoomeaning_lifetime';
  static const bool usesLifetimeInsteadOfYearly = false;
  static const String revenueCatApiKeyIos = '';
  static const String revenueCatApiKeyAndroid = '';
  static const String geminiModel = 'gemini-2.0-flash';
  static const bool debugPremium = false;
  static const Color seedColor = Color(0xFF8E1C3A);
  static const Color accentGold = Color(0xFFC4A574);
  static const int freeUseLimit = 3;
  static const double heroIconSize = 96;
  static const double paywallIconSize = 64;
  static const int maxImageBytes = 1200000;

  static String get geminiApiKey {
    return const String.fromEnvironment('GEMINI_API_KEY');
  }

  static bool get hasGeminiKey => geminiApiKey.isNotEmpty;
}
