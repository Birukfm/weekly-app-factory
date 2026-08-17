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

  MeaningResult buildFallback() {
    return const MeaningResult(
      title: 'Common tattoo symbolism',
      summary:
          'This read used the on-device guide because a live photo model was unavailable. Roses often mean love or remembrance. Anchors mean stability. Swallows mean return and loyalty. Dragons mean protection and power. These are cultural patterns, not a verdict on the wearer.',
      origin: 'Shared motifs across sailor, Japanese, and Western traditional ink.',
      symbols: <String>['rose', 'anchor', 'swallow', 'dragon'],
      usedOnDeviceFallback: true,
    );
  }
}
