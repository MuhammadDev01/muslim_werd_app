import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:muslim_werd_app/features/home/logic/prayer_scene.dart';

class BannerTitle extends StatelessWidget {
  final PrayerScene scene;

  const BannerTitle({super.key, required this.scene});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'مواقيت الصلاة',
              style: TextStyle(
                color: scene.foreground,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const Gap(3),

            Text(
              scene.subtitle,
              style: TextStyle(
                color: scene.foreground.withValues(alpha: .82),
                fontSize: 10,
              ),
            ),
          ],
        ),

        Container(
          width: 45,
          height: 45,
          decoration: BoxDecoration(
            color: scene.foreground.withValues(alpha: .18),
            shape: BoxShape.circle,
            border: Border.all(color: scene.foreground.withValues(alpha: .3)),
          ),
          child: Icon(scene.icon, color: scene.foreground, size: 24),
        ),
      ],
    );
  }
}
