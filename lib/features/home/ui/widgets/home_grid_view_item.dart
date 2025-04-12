import 'package:flutter/material.dart';
import 'package:muslim_werd_app/core/theming/styles.dart';
import 'package:muslim_werd_app/core/widgets/image_with_low_opacity_and_text.dart';
import 'package:muslim_werd_app/features/home/logic/home_grid_view_item_model.dart';

class HomeGridViewItem extends StatelessWidget {
  const HomeGridViewItem({super.key, required this.homeModel});

  final HomeGridViewItemModel homeModel;

  @override
  Widget build(BuildContext context) {
    return BackgroundLowOpacityWithText(
      backgroundImage: homeModel.image,
      child: Text(
        homeModel.text,
        textAlign: TextAlign.center,
        style: TextStyles.amiri24Bold(
          context,
        ).copyWith(fontWeight: FontWeight.w900),
      ),
    );
  }
}
