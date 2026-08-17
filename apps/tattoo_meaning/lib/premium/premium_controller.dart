import 'package:flutter/foundation.dart';

import '../config/app_config.dart';
import '../data/purchase_service.dart';

class PremiumController extends ChangeNotifier {
  PremiumController({PurchaseService? purchases})
      : _purchases = purchases ?? PurchaseService(),
        _isPremium = kDebugMode && AppConfig.debugPremium;

  final PurchaseService _purchases;
  bool _isPremium;
  bool _isLoading = false;
  int _freeUsesRemaining = AppConfig.freeUseLimit;

  bool get isPremium => _isPremium;
  bool get isLoading => _isLoading;
  int get freeUsesRemaining => _freeUsesRemaining;
  bool get canUseFreeTier => _isPremium || _freeUsesRemaining > 0;
  String get weeklyPrice => _purchases.priceLabel(AppConfig.weeklyProductId, 'Weekly');
  String get yearlyPrice => _purchases.priceLabel(AppConfig.yearlyProductId, 'Yearly');

  Future<void> executeInitialize() async {
    try {
      await _purchases.executeConnect(onPremium: _setPremium);
    } catch (_) {}
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

  void refundFreeUse() {
    if (_isPremium) {
      return;
    }
    _freeUsesRemaining += 1;
    notifyListeners();
  }

  Future<void> executeRestorePurchases() async {
    _isLoading = true;
    notifyListeners();
    try {
      await _purchases.executeRestore();
    } catch (_) {
      if (kDebugMode && AppConfig.debugPremium) {
        _setPremium(true);
      }
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> executePurchaseWeekly() {
    return _buy(AppConfig.weeklyProductId);
  }

  Future<bool> executePurchaseYearlyOrLifetime() {
    final String productId = AppConfig.usesLifetimeInsteadOfYearly
        ? AppConfig.lifetimeProductId
        : AppConfig.yearlyProductId;
    return _buy(productId);
  }

  Future<bool> _buy(String productId) async {
    _isLoading = true;
    notifyListeners();
    try {
      await _purchases.executeBuy(productId);
      return true;
    } catch (_) {
      if (kDebugMode) {
        _setPremium(true);
        return true;
      }
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void _setPremium(bool isPremium) {
    _isPremium = isPremium;
    notifyListeners();
  }

  @override
  void dispose() {
    _purchases.dispose();
    super.dispose();
  }
}
