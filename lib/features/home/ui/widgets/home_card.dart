import 'package:flutter/material.dart';
import 'package:muslim_werd_app/core/constants.dart';
import 'package:muslim_werd_app/core/theme/app_colors.dart';

class HomeCard extends StatelessWidget {
  const HomeCard({
    super.key,
    required this.title,
    this.subtitle,
    required this.imageIcon,
    required this.background,
    this.textColor,
    required this.onTap,
    this.imageColor,
  });

  final String title;
  final String? subtitle;
  final String imageIcon;
  final Color? imageColor;
  final Color background;
  final Color? textColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        height: 120,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color.lerp(background, AppColors.white, .22)!,
                background,
                Color.lerp(background, AppColors.black, .10)!,
              ],
              stops: const [0.0, 0.55, 1.0],
            ),
            borderRadius: BorderRadius.circular(19),
            border: Border.all(color: AppColors.gold, width: 1.5),
            boxShadow: [
              BoxShadow(
                color: AppColors.black.withValues(alpha: .10),
                blurRadius: 12,
                offset: const Offset(0, 5),
              ),
              BoxShadow(
                color: AppColors.gold.withValues(alpha: .28),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              Column(
                spacing: 4,

                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 16, right: 8, left: 8),
                    child: Text(
                      title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: textColor ?? AppColors.white,
                        fontFamily: fontCairo,
                      ),
                    ),
                  ),
                  if (subtitle != null)
                    Text(
                      subtitle!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 8,
                        color: textColor ?? Colors.white.withValues(alpha: .75),
                        fontFamily: fontCairo,
                      ),
                    ),
                ],
              ),
              Positioned(
                top: -40,
                child: Image.asset(
                  imageIcon,
                  width: 80,
                  color: imageColor,
                  colorBlendMode: BlendMode.srcIn,
                ),
              ),
              Container(
                alignment: Alignment.bottomLeft,
                padding: const EdgeInsets.only(bottom: 10, left: 10),
                child: Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 13,
                  color: AppColors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
