import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'tattoo_scan.dart';

class ScanRepository extends ChangeNotifier {
  ScanRepository();

  static const String _storageKey = 'tattooScans';
  List<TattooScan> _scans = <TattooScan>[];

  List<TattooScan> get scans {
    return List<TattooScan>.unmodifiable(_scans);
  }

  List<TattooScan> get savedScans {
    return _scans.where((TattooScan scan) => scan.isSaved).toList();
  }

  TattooScan? findById(String id) {
    for (final TattooScan scan in _scans) {
      if (scan.id == id) {
        return scan;
      }
    }
    return null;
  }

  Future<void> executeLoad() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String raw = prefs.getString(_storageKey) ?? '[]';
    final Object decodedRaw = jsonDecode(raw);
    final List<TattooScan> loaded = <TattooScan>[];
    if (decodedRaw is List) {
      for (final Object? item in decodedRaw) {
        if (item is Map) {
          loaded.add(TattooScan.fromJson(Map<String, Object?>.from(item)));
        }
      }
    }
    _scans = loaded;
    notifyListeners();
  }

  Future<TattooScan> executeSaveNew({
    required TattooScan scan,
    required List<int> imageBytes,
  }) async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final String hash = md5.convert(imageBytes).toString();
    final File file = File('${directory.path}/scan_$hash.jpg');
    await file.writeAsBytes(imageBytes, flush: true);
    final TattooScan stored = TattooScan(
      id: scan.id.isEmpty ? hash : scan.id,
      imagePath: file.path,
      title: scan.title,
      summary: scan.summary,
      origin: scan.origin,
      symbols: scan.symbols,
      createdAtMs: scan.createdAtMs,
      isSaved: scan.isSaved,
      usedOnDeviceFallback: scan.usedOnDeviceFallback,
    );
    _scans = <TattooScan>[stored, ..._scans];
    await _persist();
    notifyListeners();
    return stored;
  }

  Future<void> executeToggleSaved(String id) async {
    _scans = _scans
        .map(
          (TattooScan scan) =>
              scan.id == id ? scan.copyWith(isSaved: !scan.isSaved) : scan,
        )
        .toList();
    await _persist();
    notifyListeners();
  }

  Future<void> _persist() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      _storageKey,
      jsonEncode(_scans.map((TattooScan scan) => scan.toJson()).toList()),
    );
  }
}
