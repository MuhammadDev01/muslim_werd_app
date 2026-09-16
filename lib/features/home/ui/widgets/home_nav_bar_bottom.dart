import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:muslim_werd_app/core/constants.dart';
import 'package:muslim_werd_app/core/theme/app_colors.dart';

class HomeNavBarBottom extends StatelessWidget {
  const HomeNavBarBottom({
    super.key,
    required this.index,
    required this.onIndexChanged,
  });

  final int index;
  final ValueChanged<int> onIndexChanged;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return CurvedNavigationBar(
      index: index,
      backgroundColor: AppColors.transparent,
      animationDuration: const Duration(milliseconds: 400),
      animationCurve: Curves.easeInOut,
      color: isDark ? AppColors.darkSurface : AppColors.white,
      buttonBackgroundColor: AppColors.primary,
      iconPadding: 10,
      height: 70,
      items: [
        _item(
          icon: Icons.home_rounded,
          label: 'الرئيسية',
          isSelected: index == 0,
          isDark: isDark,
        ),
        _item(
          icon: Icons.calendar_month_rounded,
          label: 'جدول المتابعة',
          isSelected: index == 1,
          isDark: isDark,
        ),
      ],
      onTap: onIndexChanged,
    );
  }

  CurvedNavigationBarItem _item({
    required IconData icon,
    required String label,
    required bool isSelected,
    required bool isDark,
  }) {
    final unselectedColor = isDark ? AppColors.white : AppColors.textSecondary;

    return CurvedNavigationBarItem(
      child: Icon(
        icon,
        size: 26,
        color: isSelected ? AppColors.white : unselectedColor,
      ),
      label: label,
      labelStyle: TextStyle(
        fontSize: 13,
        fontFamily: fontCairo,
        fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
        color: isSelected ? AppColors.primary : unselectedColor,
      ),
    );
  }
}
