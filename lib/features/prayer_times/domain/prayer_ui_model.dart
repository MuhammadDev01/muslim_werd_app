import 'package:muslim_werd_app/features/prayer_times/domain/prayer_type.dart';

class PrayerUiModel {
  final PrayerType type;
  final String name;
  final String time;

  const PrayerUiModel({
    required this.type,
    required this.name,
    required this.time,
  });
}