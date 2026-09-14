import 'package:flutter/material.dart';
import 'package:muslim_werd_app/features/home/logic/prayer_scene.dart';
import 'package:muslim_werd_app/features/home/logic/prayer_type.dart';
import 'package:muslim_werd_app/features/home/logic/prayer_ui_model.dart';
import 'package:muslim_werd_app/features/home/ui/widgets/banner/banner_gradient.dart';
import 'package:muslim_werd_app/features/home/ui/widgets/banner/clouds.dart';
import 'package:muslim_werd_app/features/home/ui/widgets/banner/stars.dart';
import 'package:muslim_werd_app/features/home/ui/widgets/banner/sun_or_moon.dart';
import 'package:muslim_werd_app/features/home/ui/widgets/home_header.dart';

class HomeBanner extends StatefulWidget {
  final PrayerType activePrayer;
  final Duration remaining;
  final List<PrayerUiModel> prayers;
  final ValueChanged<PrayerType>? onPrayerTap;

  const HomeBanner({
    super.key,
    required this.activePrayer,
    required this.remaining,
    required this.prayers,
    this.onPrayerTap,
  });

  @override
  State<HomeBanner> createState() => _HomeBannerState();
}

class _HomeBannerState extends State<HomeBanner>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..forward();
  }

  @override
  void didUpdateWidget(covariant HomeBanner oldWidget) {
    super.didUpdateWidget(oldWidget);

    // الصلاة تغيرت
    if (oldWidget.activePrayer != widget.activePrayer) {
      _animationController.forward(from: 0);
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scene = PrayerScene.fromType(widget.activePrayer);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return _buildBanner(context, scene);
        },
      ),
    );
  }

  Widget _buildBanner(BuildContext context, PrayerScene scene) {
    return Container(
      height: 200,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            color: scene.primary.withValues(alpha: .16),
            blurRadius: 30,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Stack(
        children: [
          BannerGradient(scene: scene),
          SunOrMoon(scene: scene),
          Clouds(scene: scene),
          if (widget.activePrayer == PrayerType.fajr) const Stars(),
          // Positioned(
          //   bottom: 0,
          //   left: 0,
          //   right: 0,
          //   child: MosqueScene(color: scene.mosqueColor),
          // ),
          HomeHeader(),
        ],
      ),
    );
  }
}

// =====================================================
// TOP CONTENT
// =====================================================
// SafeArea(
//   child: Padding(
//     padding: const EdgeInsets.all(20),
//     child: Column(
//       children: [
//         BannerTitle(scene: scene),
//         const Gap(18),
//         PrayerInfo(
//           activePrayer: widget.activePrayer,
//           prayers: widget.prayers,
//           scene: scene,
//         ),
//         const Spacer(),
//         PrayerCountdown(
//           remaining: widget.remaining,
//           foreground: scene.foreground,
//         ),
//       ],
//     ),
//   ),
// ),
