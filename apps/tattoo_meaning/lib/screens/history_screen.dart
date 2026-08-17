import 'dart:io';

import 'package:flutter/material.dart';

import '../data/scan_repository.dart';
import '../data/scan_scope.dart';
import '../data/tattoo_scan.dart';
import 'result_screen.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ScanRepository scans = ScanScope.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('History')),
      body: scans.scans.isEmpty
          ? const Center(child: Text('No scans yet. Photograph a tattoo to start.'))
          : ListView.separated(
              itemCount: scans.scans.length,
              separatorBuilder: (BuildContext context, int index) => const Divider(height: 1),
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
          ? const Center(child: Text('Save a meaning to keep it here.'))
          : ListView.separated(
              itemCount: saved.length,
              separatorBuilder: (BuildContext context, int index) => const Divider(height: 1),
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
      leading: scan.imagePath.isEmpty
          ? const Icon(Icons.image_outlined)
          : Image.file(File(scan.imagePath), width: 48, height: 48, fit: BoxFit.cover),
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
