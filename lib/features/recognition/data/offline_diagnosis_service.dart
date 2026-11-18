import 'dart:convert';

import 'package:flutter/services.dart';

import '../domain/offline_diagnosis.dart';
import 'plant_disease_labels.dart';

/// Локальные карточки болезней для режима без интернета.
class OfflineDiagnosisService {
  OfflineDiagnosisService({this.loadAsset});

  static const assetPath = 'assets/data/offline_diagnoses.json';

  final Future<String> Function()? loadAsset;
  Map<String, OfflineDiagnosis>? _cache;

  Future<OfflineDiagnosis> getDiagnosis(String englishLabel) async {
    final key = englishLabel.trim();
    try {
      final catalog = await _catalog();
      return catalog[key] ??
          OfflineDiagnosis.fallback(key, russianName: plantDiseaseTitles[key]);
    } catch (_) {
      return OfflineDiagnosis.fallback(
        key,
        russianName: plantDiseaseTitles[key],
      );
    }
  }

  Future<Map<String, OfflineDiagnosis>> _catalog() async {
    final cached = _cache;
    if (cached != null) {
      return cached;
    }
    final raw = loadAsset == null
        ? await rootBundle.loadString(assetPath)
        : await loadAsset!();
    final catalog = parseOfflineDiagnoses(raw);
    _cache = catalog;
    return catalog;
  }
}

Map<String, OfflineDiagnosis> parseOfflineDiagnoses(String raw) {
  final decoded = jsonDecode(raw);
  if (decoded is! List) {
    throw const FormatException('Список диагнозов повреждён.');
  }
  final catalog = <String, OfflineDiagnosis>{};
  for (final item in decoded) {
    final diagnosis = OfflineDiagnosis.tryParse(item);
    if (diagnosis == null) {
      continue;
    }
    catalog[diagnosis.englishName] = diagnosis;
  }
  return catalog;
}
