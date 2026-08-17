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
    return Scaffold(
      appBar: AppBar(title: Text(current.title)),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: <Widget>[
          Column(
            spacing: 16,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              ScanPhoto(path: current.imagePath),
              Text(current.summary, style: Theme.of(context).textTheme.bodyLarge),
              Text('Origin', style: Theme.of(context).textTheme.titleSmall),
              Text(current.origin),
              SymbolWrap(symbols: current.symbols),
              if (current.usedOnDeviceFallback) const FallbackNotice(),
              FilledButton(
                onPressed: () => scans.executeToggleSaved(current.id),
                child: Text(
                  current.isSaved ? 'Remove from collection' : 'Save to collection',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ScanPhoto extends StatelessWidget {
  const ScanPhoto({super.key, required this.path});

  final String path;

  @override
  Widget build(BuildContext context) {
    if (path.isEmpty) {
      return const SizedBox.shrink();
    }
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: Image.file(File(path), fit: BoxFit.cover),
    );
  }
}

class SymbolWrap extends StatelessWidget {
  const SymbolWrap({super.key, required this.symbols});

  final List<String> symbols;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: symbols
          .map((String symbol) => Chip(label: Text(symbol)))
          .toList(),
    );
  }
}

class FallbackNotice extends StatelessWidget {
  const FallbackNotice({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'Live photo reading was unavailable, so this is the on-device guide. It is not a custom read of this photo.',
      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Theme.of(context).colorScheme.tertiary,
          ),
    );
  }
}
