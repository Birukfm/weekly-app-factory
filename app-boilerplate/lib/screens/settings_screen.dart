import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../config/app_config.dart';
import '../premium/premium_controller.dart';
import '../premium/premium_scope.dart';
import 'paywall_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  Future<void> _openUrl(String url) async {
    final Uri uri = Uri.parse(url);
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  @override
  Widget build(BuildContext context) {
    final PremiumController premium = PremiumScope.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: const Text('Pro status'),
            subtitle: Text(premium.isPremium ? 'Active' : 'Free'),
          ),
          ListTile(
            title: const Text('Upgrade'),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => const PaywallScreen(),
                ),
              );
            },
          ),
          ListTile(
            title: const Text('Restore purchases'),
            onTap: premium.isLoading ? null : premium.executeRestorePurchases,
          ),
          ListTile(
            title: const Text('Privacy policy'),
            onTap: () => _openUrl(AppConfig.privacyPolicyUrl),
          ),
          ListTile(
            title: const Text('Terms of use'),
            onTap: () => _openUrl(AppConfig.termsOfUseUrl),
          ),
          ListTile(
            title: const Text('Support'),
            subtitle: const Text(AppConfig.supportEmail),
            onTap: () => _openUrl('mailto:${AppConfig.supportEmail}'),
          ),
        ],
      ),
    );
  }
}
