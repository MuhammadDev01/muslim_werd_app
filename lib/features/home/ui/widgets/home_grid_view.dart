import 'package:flutter/material.dart';
import 'package:muslim_werd_app/core/theming/assets.dart';
import 'package:muslim_werd_app/features/home/logic/home_grid_view_item_model.dart';
import 'package:muslim_werd_app/features/home/ui/widgets/home_grid_view_item.dart';

class HomeGridView extends StatelessWidget {
  const HomeGridView({super.key});

  final List<HomeGridViewItemModel> homeModelList = const [
    HomeGridViewItemModel(
      image: Assets.imagesHolyQuran,
      text: "الـقـرآن\nالـكـريـم",
    ),
    HomeGridViewItemModel(
      image: Assets.imagesTasbeeh,
      text: "تـسـبـيـح",
    ),
    HomeGridViewItemModel(
      image: Assets.imagesTa7kk,
      text: 'التحقق من\n صحة حديث'
    ),
    HomeGridViewItemModel(
      image: Assets.imagesAzkar,
      text: "أذكار الصباح والمساء",
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 30,
        mainAxisSpacing: 30,
        childAspectRatio: 1,
      ),
      itemBuilder:
          (_, index) => HomeGridViewItem(homeModel: homeModelList[index]),
      itemCount: homeModelList.length,
    );
  }
}
