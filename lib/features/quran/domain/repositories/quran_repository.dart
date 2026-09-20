import 'package:muslim_werd_app/features/quran/domain/models/quran_models.dart';

/// تجريد الوصول إلى بيانات القرآن الكريم.
/// يتبع مبدأ Dependency Inversion — الواجهة تعرّف العقد فقط.
abstract class QuranRepository {
  /// يجلب فهرس كل السور (بيانات مخففة).
  Future<List<QuranSurahSummary>> loadSurahIndex();

  /// يجلب سورة كاملة بآياتها.
  Future<QuranSurah> loadSurah(int surahNumber);
}