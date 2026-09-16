import 'package:flutter/material.dart';
import 'package:muslim_werd_app/core/helper/extention.dart';
import 'package:muslim_werd_app/core/routing/routes.dart';
import 'package:muslim_werd_app/core/theme/app_colors.dart';
import 'package:muslim_werd_app/core/theme/assets.dart';
import 'package:muslim_werd_app/features/home/ui/widgets/home_card.dart';

class HomeCategories extends StatelessWidget {
  const HomeCategories({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 50,
      ),
      children: [
        HomeCard(
          title: 'أذكار الصباح والمساء',
          imageIcon: Assets.imagesAzkarIcon,
          background: AppColors.deepForest,
          onTap: () => context.pushNamed(SubRoutes.azkarScreen),
        ),
        HomeCard(
          title: 'القرآن الكريم',
          subtitle: 'تلاوة • تفسير • تدبر',
          imageIcon: Assets.imagesQuranIcon,
          background: AppColors.deepBrick,

          onTap: () => context.pushNamed(SubRoutes.quranScreen),
        ),

        HomeCard(
          title: 'المفضلة',
          subtitle: 'ما تحب أن تعود إليه',
          imageIcon: Assets.imagesFavoritesIcon,
          background: AppColors.deepGold,
          onTap: () => context.pushNamed(SubRoutes.favoriteScreen),
        ),
        HomeCard(
          title: 'تحقق من صحة الأحاديث',
          subtitle: 'صحيح البخاري ومسلم',
          imageIcon: Assets.imagesTa7kkIcon,
          background: AppColors.primary,

          onTap: () => context.pushNamed(SubRoutes.ta7kkScreen),
        ),
        HomeCard(
          title: 'إذاعة القران الكريم من القاهرة',
          subtitle: 'مباشر 24 ساعة',
          imageIcon: Assets.imagesEza3aIcon,
          background: AppColors.deepTeal,
          onTap: () => context.pushNamed(SubRoutes.eza3aScreen),
        ),
        HomeCard(
          title: 'تسبيح',
          subtitle: 'تسبيح وذكر الله',
          imageIcon: Assets.imagesTasbihIcon,
          background: AppColors.deepBurgundy,
          onTap: () => context.pushNamed(SubRoutes.tasbihScreen),
        ),
      ],
    );
  }
}
