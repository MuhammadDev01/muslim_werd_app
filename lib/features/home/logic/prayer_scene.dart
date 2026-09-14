import 'package:flutter/material.dart';
import 'package:muslim_werd_app/core/theme/app_colors.dart';
import 'package:muslim_werd_app/features/home/logic/prayer_type.dart';

class PrayerScene {
  final List<Color> background;

  final Color sunColor;
  final Color mosqueColor;
  final Color primary;

  final Alignment sunPosition;
  final double sunSize;

  final double cloudOpacity;

  final IconData icon;

  final String subtitle;

  /// لون محتوى البانر (نص وأيقونات) حسب إضاءة المشهد
  final Color foreground;

  const PrayerScene({
    required this.background,
    required this.sunColor,
    required this.mosqueColor,
    required this.primary,
    required this.sunPosition,
    required this.sunSize,
    required this.cloudOpacity,
    required this.icon,
    required this.subtitle,
    required this.foreground,
  });

  factory PrayerScene.fromType(PrayerType type) {
    switch (type) {
      // ========================================================
      // FAJR
      // ========================================================

      case PrayerType.fajr:
        return const PrayerScene(
          background: [
            AppColors.fajrSkyTop,
            AppColors.fajrSkyMid,
            AppColors.fajrSkyBottom,
          ],
          sunColor: AppColors.fajrSun,
          mosqueColor: AppColors.fajrMosque,
          primary: AppColors.primary,
          sunPosition: Alignment(.65, .35),
          sunSize: 55,
          cloudOpacity: .30,
          icon: Icons.wb_twilight_rounded,
          subtitle: 'صباحٌ هادئ وبداية يوم مباركة',
          foreground: AppColors.textPrimary,
        );

      // ========================================================
      // DHUHR
      // ========================================================

      case PrayerType.dhuhr:
        return const PrayerScene(
          background: [
            AppColors.dhuhrSkyTop,
            AppColors.dhuhrSkyMid,
            AppColors.dhuhrSkyBottom,
          ],
          sunColor: AppColors.dhuhrSun,
          mosqueColor: AppColors.dhuhrMosque,
          primary: AppColors.primary,
          sunPosition: Alignment(.65, -.75),
          sunSize: 68,
          cloudOpacity: .45,
          icon: Icons.wb_sunny_rounded,
          subtitle: 'نور النهار وبركة الظهر',
          foreground: AppColors.textPrimary,
        );

      // ========================================================
      // ASR
      // ========================================================

      case PrayerType.asr:
        return const PrayerScene(
          background: [
            AppColors.asrSkyTop,
            AppColors.asrSkyMid,
            AppColors.asrSkyBottom,
          ],
          sunColor: AppColors.asrSun,
          mosqueColor: AppColors.asrMosque,
          primary: AppColors.primary,
          sunPosition: Alignment(.65, .05),
          sunSize: 63,
          cloudOpacity: .25,
          icon: Icons.wb_sunny_outlined,
          subtitle: 'وقت العصر .. لحظة سكينة',
          foreground: AppColors.textPrimary,
        );

      // ========================================================
      // MAGHRIB
      // ========================================================

      case PrayerType.maghrib:
        return const PrayerScene(
          background: [
            AppColors.maghribSkyTop,
            AppColors.maghribSkyMid,
            AppColors.maghribSkyBottom,
          ],
          sunColor: AppColors.maghribSun,
          mosqueColor: AppColors.maghribMosque,
          primary: AppColors.accentGold,
          sunPosition: Alignment(.65, .55),
          sunSize: 52,
          cloudOpacity: .18,
          icon: Icons.wb_twilight,
          subtitle: 'غروب الشمس وبداية المساء',
          foreground: AppColors.textPrimary,
        );

      // ========================================================
      // ISHA
      // ========================================================

      case PrayerType.isha:
        return const PrayerScene(
          background: [
            AppColors.ishaSkyTop,
            AppColors.ishaSkyMid,
            AppColors.ishaSkyBottom,
          ],
          sunColor: AppColors.ishaSun,
          mosqueColor: AppColors.ishaMosque,
          primary: AppColors.primaryLight,
          sunPosition: Alignment(.65, -.55),
          sunSize: 42,
          cloudOpacity: .03,
          icon: Icons.nightlight_round,
          subtitle: 'هدوء الليل وسكينة العشاء',
          foreground: AppColors.white,
        );
    }
  }
}
