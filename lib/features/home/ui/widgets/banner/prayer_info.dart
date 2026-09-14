import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:muslim_werd_app/features/home/logic/prayer_scene.dart';
import 'package:muslim_werd_app/features/home/logic/prayer_type.dart';
import 'package:muslim_werd_app/features/home/logic/prayer_ui_model.dart';

class PrayerInfo extends StatelessWidget {
  final PrayerType activePrayer;
  final List<PrayerUiModel> prayers;
  final PrayerScene scene;

  const PrayerInfo({
    super.key,
    required this.activePrayer,
    required this.prayers,
    required this.scene,
  });

  @override
  Widget build(BuildContext context) {
    final prayer = prayers.firstWhere(
      (element) => element.type == activePrayer,
      orElse:
          () => const PrayerUiModel(
            type: PrayerType.fajr,
            name: 'الفجر',
            time: '04:52 AM',
          ),
    );

    return Align(
      alignment: Alignment.centerRight,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 700),
        transitionBuilder: (child, animation) {
          return FadeTransition(
            opacity: animation,
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0.15, 0),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            ),
          );
        },
        child: Row(
          key: ValueKey(prayer.type),
          children: [
            // Prayer Icon
            AnimatedScale(
              scale: 1,
              duration: const Duration(milliseconds: 600),
              child: Container(
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                  color: scene.foreground.withValues(alpha: .18),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: scene.foreground.withValues(alpha: .4),
                    width: 1.5,
                  ),
                ),
                child: Icon(scene.icon, color: scene.foreground, size: 36),
              ),
            ),

            const Gap(14),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: scene.foreground.withValues(alpha: .2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    'الآن',
                    style: TextStyle(color: scene.foreground, fontSize: 10),
                  ),
                ),

                const Gap(5),

                Text(
                  prayer.name,
                  style: TextStyle(
                    color: scene.foreground,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                Text(
                  prayer.time,
                  style: TextStyle(color: scene.foreground, fontSize: 16),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
