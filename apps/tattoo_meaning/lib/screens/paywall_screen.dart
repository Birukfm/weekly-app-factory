import 'package:flutter/material.dart';

import '../config/app_config.dart';
import '../config/onboarding_copy.dart';
import '../premium/premium_controller.dart';
import '../premium/premium_scope.dart';
import '../premium/session_store.dart';
import '../widgets/store_legal_links.dart';
import 'home_shell.dart';

class PaywallScreen extends StatelessWidget {
  const PaywallScreen({super.key, this.isClosable = true});

  final bool isClosable;

  Future<void> _completeAndOpenHome(BuildContext context) async {
    await const SessionStore().saveHasCompletedOnboarding();
    if (!context.mounted) {
      return;
    }
    if (Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
      return;
    }
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute<void>(
        builder: (BuildContext context) => const HomeShell(),
      ),
      (Route<dynamic> route) => false,
    );
  }

  Future<void> _buyWeekly(BuildContext context, PremiumController premium) async {
    final bool didStart = await premium.executePurchaseWeekly();
    if (!didStart && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Store products are not live yet. Create IAP in App Store Connect and Play Console.'),
        ),
      );
    }
  }

  Future<void> _buyLong(BuildContext context, PremiumController premium) async {
    final bool didStart = await premium.executePurchaseYearlyOrLifetime();
    if (!didStart && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Store products are not live yet. Create IAP in App Store Connect and Play Console.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final PremiumController premium = PremiumScope.of(context);
    final ColorScheme colors = Theme.of(context).colorScheme;
    final String longLabel = AppConfig.usesLifetimeInsteadOfYearly
        ? 'Lifetime'
        : 'Yearly';
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: <Widget>[
          if (isClosable)
            TextButton(
              onPressed: () => _completeAndOpenHome(context),
              child: const Text('Skip'),
            ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            spacing: 16,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    spacing: 16,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Icon(Icons.workspace_premium, size: AppConfig.paywallIconSize, color: colors.primary),
                      Text(
                        '${AppConfig.appName} Pro',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      Text(
                        'Weekly plan includes a free trial. Skip for three free reads.',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const PaywallBenefitList(),
                    ],
                  ),
                ),
              ),
              if (premium.isPremium)
                FilledButton(
                  onPressed: () => _completeAndOpenHome(context),
                  child: const Text('Continue'),
                ),
              FilledButton(
                onPressed: premium.isLoading
                    ? null
                    : () => _buyWeekly(context, premium),
                child: Text('Weekly with free trial · ${premium.weeklyPrice}'),
              ),
              OutlinedButton(
                onPressed: premium.isLoading
                    ? null
                    : () => _buyLong(context, premium),
                child: Text('$longLabel · ${premium.yearlyPrice}'),
              ),
              TextButton(
                onPressed: premium.isLoading
                    ? null
                    : premium.executeRestorePurchases,
                child: const Text('Restore purchases'),
              ),
              const StoreLegalLinks(),
            ],
          ),
        ),
      ),
    );
  }
}

class PaywallBenefitList extends StatelessWidget {
  const PaywallBenefitList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 8,
      children: OnboardingCopy.paywallBenefits
          .map(
            (String benefit) => ListTile(
              leading: Icon(
                Icons.check_circle,
                color: Theme.of(context).colorScheme.primary,
              ),
              title: Text(benefit),
            ),
          )
          .toList(),
    );
  }
}
