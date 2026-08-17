import 'dart:typed_data';

import 'tattoo_scan.dart';

class MeaningResult {
  const MeaningResult({
    required this.title,
    required this.summary,
    required this.origin,
    required this.symbols,
    required this.usedOnDeviceFallback,
  });

  final String title;
  final String summary;
  final String origin;
  final List<String> symbols;
  final bool usedOnDeviceFallback;

  TattooScan toScan({required String id, required String imagePath}) {
    return TattooScan(
      id: id,
      imagePath: imagePath,
      title: title,
      summary: summary,
      origin: origin,
      symbols: symbols,
      createdAtMs: DateTime.now().millisecondsSinceEpoch,
      isSaved: false,
      usedOnDeviceFallback: usedOnDeviceFallback,
    );
  }
}

class OnDeviceMeaningCatalog {
  const OnDeviceMeaningCatalog();

  static const List<MeaningResult> _guides = <MeaningResult>[
    MeaningResult(
      title: 'Swallow',
      summary:
          'This read used the on-device guide because a live photo model was unavailable. Swallows often mean return, loyalty, and a safe journey home. Sailors marked miles traveled with the bird. These are cultural patterns, not a verdict on the wearer.',
      origin: 'Western traditional and sailor tattooing',
      symbols: <String>['swallow', 'homecoming', 'loyalty'],
      usedOnDeviceFallback: true,
    ),
    MeaningResult(
      title: 'Rose',
      summary:
          'This read used the on-device guide because a live photo model was unavailable. Roses often mean love, beauty, or remembrance. A thorned bloom can also mark loss. These are cultural patterns, not a verdict on the wearer.',
      origin: 'European and American traditional flash',
      symbols: <String>['rose', 'love', 'remembrance'],
      usedOnDeviceFallback: true,
    ),
    MeaningResult(
      title: 'Anchor',
      summary:
          'This read used the on-device guide because a live photo model was unavailable. Anchors often mean stability, hope, and staying grounded. Naval and sailor work made the motif common. These are cultural patterns, not a verdict on the wearer.',
      origin: 'Sailor and maritime tattooing',
      symbols: <String>['anchor', 'stability', 'hope'],
      usedOnDeviceFallback: true,
    ),
    MeaningResult(
      title: 'Dragon',
      summary:
          'This read used the on-device guide because a live photo model was unavailable. Dragons often mean protection, power, and wisdom. East Asian and Western takes differ. These are cultural patterns, not a verdict on the wearer.',
      origin: 'East Asian and Western traditional ink',
      symbols: <String>['dragon', 'protection', 'power'],
      usedOnDeviceFallback: true,
    ),
  ];

  MeaningResult buildFallback(Uint8List imageBytes) {
    if (imageBytes.isEmpty) {
      return _guides.first;
    }
    final int index = imageBytes[imageBytes.length ~/ 2] % _guides.length;
    return _guides[index];
  }
}
