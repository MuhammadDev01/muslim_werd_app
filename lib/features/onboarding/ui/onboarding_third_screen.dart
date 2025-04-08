import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:muslim_werd_app/core/helper/extention.dart';
import 'package:muslim_werd_app/core/routing/routes.dart';
import 'package:muslim_werd_app/core/theming/assets.dart';
import 'package:muslim_werd_app/core/theming/colors.dart';
import 'package:muslim_werd_app/core/theming/styles.dart';
import 'package:muslim_werd_app/core/widgets/custom_button.dart';
import 'package:muslim_werd_app/features/onboarding/ui/widgets/animated_bookmarks_item.dart';
import 'package:muslim_werd_app/features/onboarding/ui/widgets/onboarding_top_title.dart';

class OnboardingThirdScreen extends StatefulWidget {
  const OnboardingThirdScreen({super.key});

  @override
  State<OnboardingThirdScreen> createState() => _OnboardingThirdScreenState();
}

class _OnboardingThirdScreenState extends State<OnboardingThirdScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation _animation;
  late final Animation _bookmarkAnimation;

  @override
  void initState() {
    super.initState();

    //controller\\
    _animationController = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    //animations\\
    _bookmarkAnimation = Tween<double>(
      begin: 0.9,
      end: 0.2,
    ).animate(_animationController);
    _animation = Tween<double>(begin: 0, end: 20).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Positioned(top: 10.h, child: Image.asset(Assets.imagesEllipse)),
        _animatedEza3aImage(),
        _animatedSebhaWithHandImage(),
        OnboardingTopTitle(text: 'مسبحة و إذاعة القرآن'),
        _bottomTitle(),
        _animatedListBookmarks(),

        Positioned(
          bottom: 50.h,
          child: CustomButton(
            child: Text('توكل على الله', style: TextStyles.cairo30Bold),
            onPressed: () {
              context.pushNamedAndRemoveUntil(Routes.homeScreen, (p0) => true);
            },
          ),
        ),
      ],
    );
  }

  _animatedListBookmarks() {
    return Align(
      alignment: Alignment(0, 0.8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children:
            AnimatedBookmarkItem.colorsList.map((color) {
              return AnimatedBookmarkItem(
                bookmarkAnimation: _bookmarkAnimation,
                color: color,
              );
            }).toList(),
      ),
    );
  }

  Positioned _bottomTitle() {
    return Positioned(
      bottom: 200.h,
      child: Column(
        spacing: 8,
        children: [
          Text(
            'أكثر من علامة حفظ إذا لديك أكثر من ختمة',
            style: TextStyles.cairo30Bold,
          ),
          Text('!والمزيد', style: TextStyles.cairo30Bold),
        ],
      ),
    );
  }

  Align _animatedSebhaWithHandImage() {
    return Align(
      alignment: Alignment(1.5, -0.2),
      child: AnimatedBuilder(
        animation: _animation,
        builder:
            (_, child) => Transform.translate(
              offset: Offset(0, _animation.value),
              child: child,
            ),
        child: Image.asset(Assets.imagesSebha, width: 400.w),
      ),
    );
  }

  AnimatedBuilder _animatedEza3aImage() {
    return AnimatedBuilder(
      animation: _animation,
      builder:
          (_, child) => Transform.translate(offset: Offset(0, 0), child: child),
      child: Image.asset(
        Assets.imagesEza3a,
        width: 600.w,
        color: ColorsManager.tealWithOpacity,
      ),
    );
  }
}
