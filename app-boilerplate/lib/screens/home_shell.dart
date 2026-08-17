import 'package:flutter/material.dart';

import '../config/app_config.dart';
import '../premium/premium_controller.dart';
import '../premium/premium_scope.dart';
import '../premium/review_prompt.dart';
import 'paywall_screen.dart';
import 'settings_screen.dart';

class HomeShell extends StatefulWidget {
  const HomeShell({super.key});

  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  int _tabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _tabIndex,
        children: const <Widget>[
          FeatureStubScreen(),
          HistoryStubScreen(),
          CollectionStubScreen(),
          SettingsScreen(),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _tabIndex,
        onDestinationSelected: (int index) {
          setState(() {
            _tabIndex = index;
          });
        },
        destinations: const <NavigationDestination>[
          NavigationDestination(
            icon: Icon(Icons.camera_alt_outlined),
            selectedIcon: Icon(Icons.camera_alt),
            label: 'Scan',
          ),
          NavigationDestination(
            icon: Icon(Icons.history_outlined),
            selectedIcon: Icon(Icons.history),
            label: 'History',
          ),
          NavigationDestination(
            icon: Icon(Icons.collections_bookmark_outlined),
            selectedIcon: Icon(Icons.collections_bookmark),
            label: 'Collection',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings_outlined),
            selectedIcon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}

class FeatureStubScreen extends StatelessWidget {
  const FeatureStubScreen({super.key});

  Future<void> _runAhaPath(BuildContext context) async {
    final PremiumController premium = PremiumScope.of(context);
    if (!premium.canUseFreeTier) {
      await Navigator.of(context).push(
        MaterialPageRoute<void>(
          builder: (BuildContext context) => const PaywallScreen(),
        ),
      );
      return;
    }
    premium.consumeFreeUse();
    await ReviewPrompt.executeAfterSuccess();
    if (!context.mounted) {
      return;
    }
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Replace this stub with the Wednesday feature.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(AppConfig.appName)),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: 16,
            children: <Widget>[
              Text(
                'Main feature goes here on Wednesday.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              FilledButton(
                onPressed: () => _runAhaPath(context),
                child: const Text('Run aha path'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HistoryStubScreen extends StatelessWidget {
  const HistoryStubScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('History')),
      body: const Center(child: Text('Past results will land here.')),
    );
  }
}

class CollectionStubScreen extends StatelessWidget {
  const CollectionStubScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Collection')),
      body: const Center(child: Text('Saved items will land here.')),
    );
  }
}
