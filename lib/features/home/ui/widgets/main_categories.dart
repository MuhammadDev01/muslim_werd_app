import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:muslim_werd_app/core/theme/app_colors.dart';
import 'package:muslim_werd_app/features/home/ui/widgets/category_card.dart';

class MainCategories extends StatelessWidget {
  const MainCategories({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: CategoryCard(
                  title: 'الأذكار',
                  subtitle: 'أذكار الصباح والمساء',
                  icon: Icons.back_hand_outlined,
                  background: AppColors.secondary,
                  iconColor: AppColors.primary,
                  textColor: AppColors.textPrimary,
                  onTap: () {},
                ),
              ),

              const Gap(10),

              Expanded(
                child: CategoryCard(
                  title: 'القرآن الكريم',
                  subtitle: 'تلاوة • تفسير • تدبر',
                  icon: Icons.menu_book_outlined,
                  background: AppColors.primary,
                  iconColor: AppColors.white,
                  textColor: AppColors.white,
                  onTap: () {},
                ),
              ),
            ],
          ),

          const Gap(10),

          Row(
            children: [
              Expanded(
                child: CategoryCard(
                  title: 'المفضلة',
                  subtitle: 'ما تحب أن تعود إليه',
                  icon: Icons.local_florist_outlined,
                  background: AppColors.softGreen,
                  iconColor: AppColors.primary,
                  textColor: AppColors.textPrimary,
                  onTap: () {},
                ),
              ),

              const Gap(10),

              Expanded(
                child: CategoryCard(
                  title: 'الأحاديث النبوية',
                  subtitle: 'صحيح البخاري ومسلم',
                  icon: Icons.account_balance_outlined,
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
