import 'package:flutter/material.dart';
import 'package:muslim_werd_app/core/theme/app_colors.dart';
import 'package:muslim_werd_app/core/theme/assets.dart';
import 'package:muslim_werd_app/features/home/ui/widgets/category_card.dart';

class MainCategories extends StatelessWidget {
  const MainCategories({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
      child: Column(
        spacing: 10,
        children: [
          Row(
            spacing: 10,
            children: [
              Expanded(
                child: CategoryCard(
                  title: 'الأذكار',
                  imageIcon: Assets.imagesAzkarIcon,
                  background: AppColors.surface,
                  iconColor: AppColors.primary,
                  textColor: AppColors.textPrimary,
                  onTap: () {},
                ),
              ),

              Expanded(
                child: CategoryCard(
                  title: 'القرآن الكريم',
                  subtitle: 'تلاوة • تفسير • تدبر',
                  imageIcon: Assets.imagesAzkarIcon,
                  background: AppColors.primary,
                  iconColor: AppColors.white,
                  textColor: AppColors.white,
                  onTap: () {},
                ),
              ),
            ],
          ),

          Row(
            spacing: 10,

            children: [
              Expanded(
                child: CategoryCard(
                  title: 'المفضلة',
                  subtitle: 'ما تحب أن تعود إليه',
                  imageIcon: Assets.imagesAzkarIcon,
                  background: AppColors.softGreen,
                  iconColor: AppColors.primary,
                  textColor: AppColors.textPrimary,
                  onTap: () {},
                ),
              ),

              Expanded(
                child: CategoryCard(
                  title: 'الأحاديث النبوية',
                  subtitle: 'صحيح البخاري ومسلم',
                  imageIcon: Assets.imagesAzkarIcon,
                  background: AppColors.softGold,
                  iconColor: AppColors.gold,
                  textColor: AppColors.textPrimary,
                  onTap: () {},
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
