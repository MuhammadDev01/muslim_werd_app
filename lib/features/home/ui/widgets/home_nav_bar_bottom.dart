import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:muslim_werd_app/core/theming/assets.dart';
import 'package:muslim_werd_app/core/theming/colors.dart';
import 'package:muslim_werd_app/core/theming/styles.dart';

class HomeNavBarBottom extends StatefulWidget {
  const HomeNavBarBottom({super.key});
  static int index = 0;
  @override
  State<HomeNavBarBottom> createState() => _HomeNavBarBottomState();
}

class _HomeNavBarBottomState extends State<HomeNavBarBottom> {
  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      backgroundColor: Colors.transparent,
      animationDuration: Duration(milliseconds: 500),
      color: ColorsManager.blackWithOpacity,
      height: MediaQuery.sizeOf(context).height * 0.23.h,
      items: [
        CurvedNavigationBarItem(
          child: Image.asset(Assets.imagesHouseIcon, height: 48.h, width: 48.w),
          label: 'الرئيسية',
          labelStyle: TextStyles.amiri24Bold(
            context,
          ).copyWith(fontWeight: FontWeight.w900),
        ),
        CurvedNavigationBarItem(
          child: Image.asset(Assets.imagesTableIcon, height: 48.h, width: 48.w),
          label: 'جدول المتابعة',
          labelStyle: TextStyles.amiri24Bold(
            context,
          ).copyWith(fontWeight: FontWeight.w900),
        ),
      ],
      onTap: (value) {
        setState(() {
          if (HomeNavBarBottom.index != value) {
            HomeNavBarBottom.index = value;
          }
        });
      },
    );
  }
}
