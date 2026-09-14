import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:muslim_werd_app/core/theme/app_colors.dart';

class AzkarHeader extends StatelessWidget {
  const AzkarHeader({super.key, this.onSeeAllTap});

  final VoidCallback? onSeeAllTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(22, 25, 22, 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const Text(
                'أذكار اليوم',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),

              const Gap(5),

              const Icon(
                Icons.wb_sunny_outlined,
                size: 19,
                color: AppColors.gold,
              ),
            ],
          ),

          GestureDetector(
            onTap: onSeeAllTap ?? () {},
            child: const Text(
              'عرض الكل',
              style: TextStyle(
                fontSize: 11,
                color: AppColors.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
