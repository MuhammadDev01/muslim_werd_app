import 'package:flutter/material.dart';
import 'package:muslim_werd_app/features/home/logic/prayer_scene.dart';

class BannerGradient extends StatelessWidget {
  final PrayerScene scene;

  const BannerGradient({super.key, required this.scene});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 1200),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: scene.background,
        ),
      ),
    );
  }
}
