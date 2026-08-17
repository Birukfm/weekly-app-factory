import 'package:shared_preferences/shared_preferences.dart';

class SessionStore {
  const SessionStore();

  static const String _onboardingKey = 'hasCompletedOnboarding';

  Future<bool> readHasCompletedOnboarding() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_onboardingKey) ?? false;
  }

  Future<void> saveHasCompletedOnboarding() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_onboardingKey, true);
  }
}
