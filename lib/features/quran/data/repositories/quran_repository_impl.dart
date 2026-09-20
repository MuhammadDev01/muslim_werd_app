import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:muslim_werd_app/features/quran/domain/models/quran_models.dart';
import 'package:muslim_werd_app/features/quran/domain/repositories/quran_repository.dart';

/// ينفّذ [QuranRepository] بقراءة ملف quran.json المرفق في الأصول.
/// يُحمّل الملف مرة واحدة فقط ويخزّن النتيجة cache في الذاكرة.
class QuranRepositoryImpl implements QuranRepository {
  QuranRepositoryImpl({this.assetPath = _defaultAssetPath});

  static const _defaultAssetPath = 'assets/data/quran.json';

  final String assetPath;
  List<dynamic>? _cachedData;

  Future<List<dynamic>> _loadRawData() async {
    if (_cachedData != null) return _cachedData!;

    final raw = await rootBundle.loadString(assetPath);
    final data = jsonDecode(raw) as List;
    _cachedData = data;
    return data;
  }

  @override
  Future<List<QuranSurahSummary>> loadSurahIndex() async {
    final data = await _loadRawData();
    return data
        .map((e) => QuranSurahSummary.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<QuranSurah> loadSurah(int surahNumber) async {
    final data = await _loadRawData();
    final match = data.where(
      (e) => (e as Map<String, dynamic>)['number'] == surahNumber,
    );
    if (match.isEmpty) {
      throw StateError('لم يتم العثور على السورة رقم $surahNumber');
    }
    return QuranSurah.fromJson(match.first as Map<String, dynamic>);
  }
}