import 'package:flutter/foundation.dart';

import '../config/app_config.dart';

class PremiumController extends ChangeNotifier {
  PremiumController() : _isPremium = AppConfig.debugPremium;

  bool _isPremium;
  bool _isLoading = false;
  int _freeUsesRemaining = AppConfig.freeUseLimit;

  bool get isPremium => _isPremium;
  bool get isLoading => _isLoading;
  int get freeUsesRemaining => _freeUsesRemaining;
  bool get canUseFreeTier => _isPremium || _freeUsesRemaining > 0;
  bool get hasRevenueCatKeys {
    return AppConfig.revenueCatApiKeyIos.isNotEmpty ||
        AppConfig.revenueCatApiKeyAndroid.isNotEmpty;
  }

  bool consumeFreeUse() {
    if (_isPremium) {
      return true;
    }
    if (_freeUsesRemaining <= 0) {
      return false;
    }
    _freeUsesRemaining -= 1;
    notifyListeners();
    return true;
  }

  Future<void> executeRestorePurchases() async {
    _isLoading = true;
    notifyListeners();
    await Future<void>.delayed(const Duration(milliseconds: 400));
    if (AppConfig.debugPremium) {
      _isPremium = true;
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<bool> executePurchaseWeekly() {
    return _executeStubPurchase();
  }

  Future<bool> executePurchaseYearlyOrLifetime() {
    return _executeStubPurchase();
  }

  Future<bool> _executeStubPurchase() async {
    _isLoading = true;
    notifyListeners();
    await Future<void>.delayed(const Duration(milliseconds: 400));
    _isPremium = true;
    _isLoading = false;
    notifyListeners();
    return true;
  }
}
