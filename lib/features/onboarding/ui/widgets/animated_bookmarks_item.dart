import 'package:flutter/material.dart';
import 'package:muslim_werd_app/core/theme/app_colors.dart';

class AnimatedBookmarkItem extends StatelessWidget {
  const AnimatedBookmarkItem({
    super.key,
    required this.color,
    required this.bookmarkAnimation,
  });

  final Animation bookmarkAnimation;
  final Color color;
  static List<Color> colorsList = const [
    AppColors.primary,
    AppColors.primaryLight,
    AppColors.accentGold,
    AppColors.darkAccentGold,
    AppColors.darkPrimary,
    AppColors.secondary,
  ];
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: bookmarkAnimation,

      builder:
          (_, child) => Opacity(opacity: bookmarkAnimation.value, child: child),

      child: Image.asset('assets/images/bookmark.png', width: 70, color: color),
    );
  }
}
