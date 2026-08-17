import 'package:flutter/material.dart';

import 'premium_controller.dart';

class PremiumScope extends InheritedNotifier<PremiumController> {
  const PremiumScope({
    super.key,
    required PremiumController controller,
    required super.child,
  }) : super(notifier: controller);

  static PremiumController of(BuildContext context) {
    final PremiumScope? scope =
        context.dependOnInheritedWidgetOfExactType<PremiumScope>();
    assert(scope != null, 'PremiumScope is missing from the tree.');
    return scope!.notifier!;
  }
}
