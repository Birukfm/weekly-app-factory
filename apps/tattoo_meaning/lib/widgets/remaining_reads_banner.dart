import 'package:flutter/material.dart';

import '../premium/premium_controller.dart';
import '../premium/premium_scope.dart';

class RemainingReadsBanner extends StatelessWidget {
  const RemainingReadsBanner({super.key});

  @override
  Widget build(BuildContext context) {
    final PremiumController premium = PremiumScope.of(context);
    final String label = premium.isPremium
        ? 'Pro · unlimited reads'
        : '${premium.freeUsesRemaining} free reads left';
    return Text(
      label,
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.labelLarge,
    );
  }
}
