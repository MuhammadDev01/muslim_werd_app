import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:muslim_werd_app/core/theming/assets.dart';
import 'package:muslim_werd_app/features/home/logic/home_grid_view_item_model.dart';
import 'package:muslim_werd_app/features/home/ui/widgets/background_home.dart';
import 'package:muslim_werd_app/features/home/ui/widgets/home_grid_view.dart';
import 'package:muslim_werd_app/features/home/ui/widgets/home_grid_view_item.dart';
import 'package:muslim_werd_app/features/home/ui/widgets/home_nav_bar_bottom.dart';
import 'package:muslim_werd_app/features/home/ui/widgets/home_top_title.dart';
import 'package:muslim_werd_app/features/schedule/ui/schedule_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          BackgroundHome(),

          HomeNavBarBottom.index == 0
              ? HomeScreenComponents()
              : ScheduleScreen(),
        ],
      ),
      bottomNavigationBar: HomeNavBarBottom(),
    );
  }
}

class HomeScreenComponents extends StatelessWidget {
  const HomeScreenComponents({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(20.0.sp),
        child: Column(
          spacing: 10,
          children: [
            AppBar(
              backgroundColor: Colors.transparent,
              automaticallyImplyLeading: false,
              title: HomeTopTitle(),
              centerTitle: true,
              actions: [
                Image.asset(
                  Assets.imagesSettingsIcon,
                  height: 60.h,
                  width: 60.w,
                ),
              ],
            ),
            HomeGridView(),
            AspectRatio(
              aspectRatio: 3,
              child: HomeGridViewItem(
                homeModel: HomeGridViewItemModel(
                  image: Assets.imagesRadio,
                  text: 'إذاعة القرآن  \nالكريم من القاهرة',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
