import 'package:flutter/material.dart';
import 'package:muslim_werd_app/features/home/logic/prayer_scene.dart';

class SunOrMoon extends StatelessWidget {
  final PrayerScene scene;

  const SunOrMoon({super.key, required this.scene});

  @override
  Widget build(BuildContext context) {
    return AnimatedAlign(
      duration: const Duration(milliseconds: 1200),
      curve: Curves.easeInOut,
      alignment: scene.sunPosition,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 1200),
        width: scene.sunSize,
        height: scene.sunSize,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: scene.sunColor,
          boxShadow: [
            BoxShadow(
              color: scene.sunColor.withValues(alpha: .35),
              blurRadius: 35,
              spreadRadius: 5,
            ),
          ],
        ),
      ),
    );
  }
}
