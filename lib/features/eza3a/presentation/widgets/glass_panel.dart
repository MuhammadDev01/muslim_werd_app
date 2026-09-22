import 'package:flutter/material.dart';
import 'package:muslim_werd_app/core/theme/app_colors.dart';

class GlassPanel extends StatelessWidget {
  const GlassPanel({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      decoration: BoxDecoration(
        color:
            isDark
                ? AppColors.darkSurface.withValues(alpha: 0.42)
                : AppColors.white.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(26),
        border: Border.all(
          color:
              isDark
                  ? AppColors.white.withValues(alpha: 0.12)
                  : AppColors.white.withValues(alpha: 0.7),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.06),
            blurRadius: 22,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: child,
    );
  }
}
