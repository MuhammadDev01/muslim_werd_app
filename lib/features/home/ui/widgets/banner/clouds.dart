import 'package:flutter/material.dart';
import 'package:muslim_werd_app/core/theme/app_colors.dart';
import 'package:muslim_werd_app/features/home/logic/prayer_scene.dart';

class Clouds extends StatelessWidget {
  final PrayerScene scene;

  const Clouds({super.key, required this.scene});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 75,
          left: 30,
          child: Cloud(opacity: scene.cloudOpacity, width: 80),
        ),

        Positioned(
          top: 120,
          right: 50,
          child: Cloud(opacity: scene.cloudOpacity * .8, width: 65),
        ),
      ],
    );
  }
}

class Cloud extends StatelessWidget {
  final double opacity;
  final double width;

  const Cloud({super.key, required this.opacity, required this.width});

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: opacity,
      child: Container(
        width: width,
        height: 22,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(50),
        ),
      ),
    );
  }
}
