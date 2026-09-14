import 'package:muslim_werd_app/features/prayer_times/domain/prayer_type.dart';
import 'package:muslim_werd_app/features/prayer_times/domain/prayer_ui_model.dart';

class PrayerTimesResult {
  final PrayerType activePrayer;
  final PrayerType nextPrayer;
  final Duration remaining;

  const PrayerTimesResult({
    required this.activePrayer,
    required this.nextPrayer,
    required this.remaining,
  });
}

/// منطق حساب الصلاة الحالية والصلاة القادمة والوقت المتبقي.
class PrayerTimesCalculator {
  PrayerTimesCalculator._();

  /// [prayers] قائمة مواقيت اليوم، [now] الزمن الحالي.
  static PrayerTimesResult compute({
    required List<PrayerUiModel> prayers,
    required DateTime now,
  }) {
    if (prayers.isEmpty) {
      return const PrayerTimesResult(
        activePrayer: PrayerType.fajr,
        nextPrayer: PrayerType.fajr,
        remaining: Duration.zero,
      );
    }

    final nowMinutes = now.hour * 60 + now.minute;

    final entries =
        prayers
            .map((p) => (_minutesOfDay(p.time), p.type))
            .toList()
          ..sort((a, b) => a.$1.compareTo(b.$1));

    // أول صلاة لم يحن وقتها بعد اليوم، وإلا نبدأ من الأذان الأول (بكرة)
    var nextIndex = 0;
    for (var i = 0; i < entries.length; i++) {
      if (entries[i].$1 > nowMinutes) {
        nextIndex = i;
        break;
      }
    }

    final wrapped = nextIndex == 0;

    final activeIndex = wrapped ? entries.length - 1 : nextIndex - 1;

    final next = entries[nextIndex];

    var remainingMinutes = next.$1 - nowMinutes;
    if (remainingMinutes <= 0) {
      remainingMinutes += 24 * 60;
    }

    return PrayerTimesResult(
      activePrayer: entries[activeIndex].$2,
      nextPrayer: next.$2,
      remaining: Duration(minutes: remainingMinutes),
    );
  }

  static int _minutesOfDay(String time) {
    final match = RegExp(
      r'^(\d{1,2}):(\d{2})\s*([AP]M)?$',
    ).firstMatch(time.trim());
    if (match == null) return 0;

    var hour = int.parse(match.group(1)!);
    final minute = int.parse(match.group(2)!);
    final meridiem = match.group(3);

    if (meridiem == 'PM' && hour != 12) hour += 12;
    if (meridiem == 'AM' && hour == 12) hour = 0;

    return hour * 60 + minute;
  }
}