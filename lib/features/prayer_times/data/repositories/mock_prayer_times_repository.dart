import 'package:muslim_werd_app/features/prayer_times/domain/prayer_type.dart';
import 'package:muslim_werd_app/features/prayer_times/domain/prayer_ui_model.dart';
import 'package:muslim_werd_app/features/prayer_times/domain/repositories/prayer_times_repository.dart';

class MockPrayerTimesRepository implements PrayerTimesRepository {
  @override
  Future<List<PrayerUiModel>> getPrayerTimes(DateTime date) async {
    return const [
      PrayerUiModel(type: PrayerType.fajr, name: 'الفجر', time: '5:24 AM'),
      PrayerUiModel(type: PrayerType.dhuhr, name: 'الظهر', time: '12:18 PM'),
      PrayerUiModel(type: PrayerType.asr, name: 'العصر', time: '3:42 PM'),
      PrayerUiModel(type: PrayerType.maghrib, name: 'المغرب', time: '6:05 PM'),
      PrayerUiModel(type: PrayerType.isha, name: 'العشاء', time: '7:40 PM'),
    ];
  }
}