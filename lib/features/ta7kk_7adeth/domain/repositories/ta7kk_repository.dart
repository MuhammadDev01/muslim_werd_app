import 'package:muslim_werd_app/features/ta7kk_7adeth/domain/models/hadith_ta7kk_result.dart';

/// مصدر بيانات البحث عن صحة الأحاديث في الموسوعة الحديثية (dorar.net).
/// الجزء المجرّد في الـ domain يسمح بحقن أي تنفيذ (Remote/Mock) — Dependency Inversion.
abstract interface class Ta7kkRepository {
  Future<List<HadithTa7kkResult>> search(String keywords);
}