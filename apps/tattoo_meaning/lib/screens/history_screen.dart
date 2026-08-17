import 'dart:io';

import 'package:flutter/material.dart';

import '../data/scan_repository.dart';
import '../data/scan_scope.dart';
import '../data/tattoo_scan.dart';
import '../widgets/empty_state.dart';
import 'result_screen.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ScanRepository scans = ScanScope.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('History')),
      body: scans.scans.isEmpty
          ? const EmptyState(
              icon: Icons.history_outlined,
              message: 'No scans yet. Photograph a tattoo to start.',
            )
          : ListView.separated(
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: scans.scans.length,
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(height: 1),
              itemBuilder: (BuildContext context, int index) {
                return ScanTile(scan: scans.scans[index]);
              },
            ),
    );
  }
}

class CollectionScreen extends StatelessWidget {
  const CollectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<TattooScan> saved = ScanScope.of(context).savedScans;
    return Scaffold(
      appBar: AppBar(title: const Text('Collection')),
      body: saved.isEmpty
          ? const EmptyState(
              icon: Icons.collections_bookmark_outlined,
              message: 'Save a meaning to keep it here.',
            )
          : ListView.separated(
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: saved.length,
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(height: 1),
              itemBuilder: (BuildContext context, int index) {
                return ScanTile(scan: saved[index]);
              },
            ),
    );
  }
}

class ScanTile extends StatelessWidget {
  const ScanTile({super.key, required this.scan});

  final TattooScan scan;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      leading: ScanThumb(path: scan.imagePath),
      title: Text(scan.title),
      subtitle: Text(scan.summary, maxLines: 2, overflow: TextOverflow.ellipsis),
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute<void>(
            builder: (BuildContext context) => ResultScreen(scan: scan),
          ),
        );
      },
    );
  }
}

class ScanThumb extends StatelessWidget {
  const ScanThumb({super.key, required this.path});

  final String path;

  @override
  Widget build(BuildContext context) {
    if (path.isEmpty) {
      return const Icon(Icons.image_outlined);
    }
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Image.file(File(path), width: 56, height: 56, fit: BoxFit.cover),
    );
  }
}
