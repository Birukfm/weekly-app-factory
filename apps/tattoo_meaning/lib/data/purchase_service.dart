import 'dart:async';

import 'package:in_app_purchase/in_app_purchase.dart';

import '../config/app_config.dart';

class PurchaseService {
  PurchaseService({InAppPurchase? store}) : _store = store ?? InAppPurchase.instance;

  final InAppPurchase _store;
  StreamSubscription<List<PurchaseDetails>>? _subscription;
  List<ProductDetails> products = <ProductDetails>[];

  Future<void> executeConnect({
    required void Function(bool isPremium) onPremium,
  }) async {
    final bool isAvailable = await _store.isAvailable();
    if (!isAvailable) {
      return;
    }
    _subscription = _store.purchaseStream.listen((List<PurchaseDetails> purchases) {
      _handlePurchases(purchases, onPremium);
    });
    final Set<String> ids = <String>{
      AppConfig.weeklyProductId,
      AppConfig.yearlyProductId,
      AppConfig.lifetimeProductId,
    };
    final ProductDetailsResponse response = await _store.queryProductDetails(ids);
    products = response.productDetails;
  }

  Future<void> executeBuy(String productId) async {
    final ProductDetails? product = _product(productId);
    if (product == null) {
      throw StateError('Product $productId is not available in the store yet.');
    }
    final PurchaseParam param = PurchaseParam(productDetails: product);
    await _store.buyNonConsumable(purchaseParam: param);
  }

  Future<void> executeRestore() {
    return _store.restorePurchases();
  }

  String priceLabel(String productId, String fallback) {
    final ProductDetails? product = _product(productId);
    return product?.price ?? fallback;
  }

  ProductDetails? _product(String productId) {
    for (final ProductDetails product in products) {
      if (product.id == productId) {
        return product;
      }
    }
    return null;
  }

  void _handlePurchases(
    List<PurchaseDetails> purchases,
    void Function(bool isPremium) onPremium,
  ) {
    for (final PurchaseDetails purchase in purchases) {
      if (purchase.status == PurchaseStatus.purchased ||
          purchase.status == PurchaseStatus.restored) {
        onPremium(true);
      }
      if (purchase.pendingCompletePurchase) {
        _store.completePurchase(purchase);
      }
    }
  }

  Future<void> dispose() async {
    await _subscription?.cancel();
  }
}
