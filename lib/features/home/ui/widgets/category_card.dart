import 'package:flutter/material.dart';
import 'package:muslim_werd_app/core/constants.dart';
import 'package:muslim_werd_app/core/theme/app_colors.dart';
import 'package:muslim_werd_app/core/theme/assets.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    super.key,
    required this.title,
    this.subtitle,
    required this.imageIcon,
    required this.background,
    required this.iconColor,
    required this.textColor,
    required this.onTap,
  });

  final String title;
  final String? subtitle;
  final String imageIcon;
  final Color background;
  final Color iconColor;
  final Color textColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 128,
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.circular(19),
          border: Border.all(color: AppColors.white.withValues(alpha: .7)),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              spacing: 4,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(imageIcon, width: 30, height: 30),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                    fontFamily: fontCairo,
                  ),
                ),
                if (subtitle != null)
                  Text(
                    subtitle!,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 8.5,
                      color: textColor.withValues(alpha: .75),
                      fontFamily: fontCairo,
                    ),
                  ),
              ],
            ),

            Positioned(
              left: 0,
              bottom: 0,
              child: Icon(
                Icons.arrow_forward_ios_rounded,
                size: 13,
                color: iconColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
