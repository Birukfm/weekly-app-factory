import 'dart:convert';
import 'dart:typed_data';

import 'package:google_generative_ai/google_generative_ai.dart';

import '../config/app_config.dart';
import 'on_device_catalog.dart';

class MeaningInterpreter {
  MeaningInterpreter({OnDeviceMeaningCatalog catalog = const OnDeviceMeaningCatalog()})
      : _catalog = catalog;

  final OnDeviceMeaningCatalog _catalog;

  Future<MeaningResult> executeRead(Uint8List imageBytes) async {
    if (!AppConfig.hasGeminiKey) {
      return _catalog.buildFallback(imageBytes);
    }
    try {
      final GenerativeModel model = GenerativeModel(
        model: AppConfig.geminiModel,
        apiKey: AppConfig.geminiApiKey,
      );
      final GenerateContentResponse response = await model.generateContent(
        <Content>[
          Content.multi(<Part>[
            TextPart(_prompt),
            DataPart('image/jpeg', imageBytes),
          ]),
        ],
      );
      final String text = response.text ?? '';
      final MeaningResult? parsed = _parseJson(text);
      if (parsed == null) {
        return _catalog.buildFallback(imageBytes);
      }
      return parsed;
    } catch (_) {
      return _catalog.buildFallback(imageBytes);
    }
  }

  static const String _prompt = '''
You explain tattoo symbolism. Return ONLY JSON with keys:
title (short name of the motif),
summary (2-4 sentences, cultural meaning, not fortune-telling),
origin (region or tradition if known, else "mixed / modern"),
symbols (array of 1-6 short motif names).
If the image is not a tattoo, still describe likely ink motifs if any, or say it is unclear.
Do not give medical, legal, or gang-affiliation claims.
''';

  MeaningResult? _parseJson(String raw) {
    final int start = raw.indexOf('{');
    final int end = raw.lastIndexOf('}');
    if (start < 0 || end <= start) {
      return null;
    }
    try {
      final Object parsed = jsonDecode(raw.substring(start, end + 1));
      if (parsed is! Map) {
        return null;
      }
      final Map<String, Object?> json = Map<String, Object?>.from(parsed);
      final List<Object?> symbols = json['symbols'] is List
          ? List<Object?>.from(json['symbols']! as List)
          : <Object?>[];
      return MeaningResult(
        title: (json['title'] as String?)?.trim().isNotEmpty == true
            ? json['title'] as String
            : 'Tattoo motif',
        summary: (json['summary'] as String?) ?? '',
        origin: (json['origin'] as String?) ?? '',
        symbols: symbols.map((Object? item) => item.toString()).toList(),
        usedOnDeviceFallback: false,
      );
    } catch (_) {
      return null;
    }
  }
}
