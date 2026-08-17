class TattooScan {
  const TattooScan({
    required this.id,
    required this.imagePath,
    required this.title,
    required this.summary,
    required this.origin,
    required this.symbols,
    required this.createdAtMs,
    required this.isSaved,
    required this.usedOnDeviceFallback,
  });

  final String id;
  final String imagePath;
  final String title;
  final String summary;
  final String origin;
  final List<String> symbols;
  final int createdAtMs;
  final bool isSaved;
  final bool usedOnDeviceFallback;

  DateTime get createdAt => DateTime.fromMillisecondsSinceEpoch(createdAtMs);

  TattooScan copyWith({bool? isSaved}) {
    return TattooScan(
      id: id,
      imagePath: imagePath,
      title: title,
      summary: summary,
      origin: origin,
      symbols: symbols,
      createdAtMs: createdAtMs,
      isSaved: isSaved ?? this.isSaved,
      usedOnDeviceFallback: usedOnDeviceFallback,
    );
  }

  Map<String, Object> toJson() {
    return <String, Object>{
      'id': id,
      'imagePath': imagePath,
      'title': title,
      'summary': summary,
      'origin': origin,
      'symbols': symbols,
      'createdAtMs': createdAtMs,
      'isSaved': isSaved,
      'usedOnDeviceFallback': usedOnDeviceFallback,
    };
  }

  static TattooScan fromJson(Map<String, Object?> json) {
    final List<Object?> rawSymbols = json['symbols'] is List
        ? List<Object?>.from(json['symbols']! as List)
        : <Object?>[];
    return TattooScan(
      id: json['id'] as String? ?? '',
      imagePath: json['imagePath'] as String? ?? '',
      title: json['title'] as String? ?? 'Tattoo',
      summary: json['summary'] as String? ?? '',
      origin: json['origin'] as String? ?? '',
      symbols: rawSymbols.map((Object? item) => item.toString()).toList(),
      createdAtMs: (json['createdAtMs'] as num?)?.toInt() ?? 0,
      isSaved: json['isSaved'] as bool? ?? false,
      usedOnDeviceFallback: json['usedOnDeviceFallback'] as bool? ?? false,
    );
  }
}
