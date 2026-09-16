import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:muslim_werd_app/core/theme/assets.dart';
import 'package:muslim_werd_app/features/home/ui/widgets/banner/home_banner.dart';
import 'package:muslim_werd_app/features/home/ui/widgets/home_nav_bar_bottom.dart';
import 'package:muslim_werd_app/features/home/ui/widgets/home_categories.dart';
import 'package:muslim_werd_app/features/prayer_times/data/repositories/mock_prayer_times_repository.dart';
import 'package:muslim_werd_app/features/prayer_times/presentation/cubit/prayer_times_cubit.dart';
import 'package:muslim_werd_app/features/prayer_times/presentation/cubit/prayer_times_state.dart';
import 'package:muslim_werd_app/features/schedule/ui/schedule_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SafeArea(
        child: Scaffold(
          body: Stack(
            children: [
              Positioned.fill(
                child: Image.asset(
                  Theme.of(context).brightness == Brightness.dark
                      ? Assets.imagesDarkBackground
                      : Assets.imagesLightBackground,
                  fit: BoxFit.cover,
                ),
              ),
              selectedIndex == 0 ? _buildHomeContent() : const TableScreen(),
            ],
          ),

          bottomNavigationBar: HomeNavBarBottom(
            index: selectedIndex,
            onIndexChanged: (value) {
              setState(() {
                selectedIndex = value;
              });
            },
          ),
        ),
      ),
    );
  }

  Widget _buildHomeContent() {
    return BlocProvider(
      create:
          (_) =>
              PrayerTimesCubit(repository: MockPrayerTimesRepository())
                ..loadPrayerTimes(),
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: BlocBuilder<PrayerTimesCubit, PrayerTimesState>(
              builder: (context, state) {
                return HomeBanner(
                  activePrayer: state.activePrayer,
                  remaining: state.remaining,
                  prayers: state.prayers,
                );
              },
            ),
          ),
          const SliverToBoxAdapter(child: Gap(60)),
          const SliverToBoxAdapter(child: HomeCategories()),
          const SliverToBoxAdapter(child: Gap(30)),

          //AzkarHeader(),
          //MorningAzkar(),
        ],
      ),
    );
  }
}
