import 'dart:io';

import 'package:flutter/material.dart';

import '../data/scan_repository.dart';
import '../data/scan_scope.dart';
import '../data/tattoo_scan.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key, required this.scan});

  final TattooScan scan;

  @override
  Widget build(BuildContext context) {
    final ScanRepository scans = ScanScope.of(context);
    final TattooScan current = scans.findById(scan.id) ?? scan;
    final ColorScheme colors = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(title: Text(current.title)),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: <Widget>[
          if (current.imagePath.isNotEmpty)
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.file(File(current.imagePath), fit: BoxFit.cover),
            ),
          const SizedBox(height: 16),
          Text(current.summary, style: Theme.of(context).textTheme.bodyLarge),
          const SizedBox(height: 16),
          Text('Origin', style: Theme.of(context).textTheme.titleSmall),
          Text(current.origin),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: current.symbols
                .map((String symbol) => Chip(label: Text(symbol)))
                .toList(),
          ),
          if (current.usedOnDeviceFallback)
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Text(
                'Live photo reading was unavailable, so this is the on-device guide. It is not a custom read of this photo.',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: colors.tertiary),
              ),
            ),
          const SizedBox(height: 24),
          FilledButton(
            onPressed: () => scans.executeToggleSaved(current.id),
            child: Text(
              current.isSaved ? 'Remove from collection' : 'Save to collection',
            ),
          ),
        ],
      ),
    );
  }
}
