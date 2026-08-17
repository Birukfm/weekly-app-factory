import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../config/app_config.dart';

class StoreLegalLinks extends StatelessWidget {
  const StoreLegalLinks({super.key});

  Future<void> _openUrl(String url) async {
    await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 8,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        TextButton(
          onPressed: () => _openUrl(AppConfig.privacyPolicyUrl),
          child: const Text('Privacy'),
        ),
        TextButton(
          onPressed: () => _openUrl(AppConfig.termsOfUseUrl),
          child: const Text('Terms'),
        ),
      ],
    );
  }
}
