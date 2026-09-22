import 'package:flutter/material.dart';
import 'package:muslim_werd_app/core/theme/app_colors.dart';
import 'package:muslim_werd_app/core/theme/assets.dart';

class AppBackground extends StatelessWidget {
  const AppBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset(
            Theme.of(context).brightness == Brightness.dark
                ? Assets.imagesDarkBackground
                : Assets.imagesLightBackground,
            fit: BoxFit.cover,
          ),
        ),
        Positioned.fill(
          child: IgnorePointer(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  center: const Alignment(0, -0.6),
                  radius: 1.3,
                  colors: [
                    AppColors.transparent,
                    AppColors.primary.withValues(alpha: 0.12),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
