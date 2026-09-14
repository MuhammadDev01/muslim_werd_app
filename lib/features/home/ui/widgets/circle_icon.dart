import 'package:flutter/material.dart';
import 'package:muslim_werd_app/core/theme/app_colors.dart';

class CircleIcon extends StatelessWidget {
  const CircleIcon({super.key, required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: AppColors.white.withValues(alpha: .8),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, size: 22, color: AppColors.primary),
      ),
    );
  }
}
