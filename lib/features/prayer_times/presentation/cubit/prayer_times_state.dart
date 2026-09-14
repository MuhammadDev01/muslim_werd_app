import 'package:muslim_werd_app/features/prayer_times/domain/prayer_type.dart';
import 'package:muslim_werd_app/features/prayer_times/domain/prayer_ui_model.dart';

class PrayerTimesState {
  final List<PrayerUiModel> prayers;

  /// الصلاة الحالية
  final PrayerType activePrayer;

  /// الوقت المتبقي على الصلاة القادمة
  final Duration remaining;

  const PrayerTimesState({
    this.prayers = const [],
    this.activePrayer = PrayerType.fajr,
    this.remaining = Duration.zero,
  });
}