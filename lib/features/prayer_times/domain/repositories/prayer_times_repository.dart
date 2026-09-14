import 'package:muslim_werd_app/features/prayer_times/domain/prayer_ui_model.dart';

/// مصدر بيانات مواقيت الصلاة — قابل للتبديل (Mock حاليًا، Aladhan لاحقًا).
abstract interface class PrayerTimesRepository {
  Future<List<PrayerUiModel>> getPrayerTimes(DateTime date);
}