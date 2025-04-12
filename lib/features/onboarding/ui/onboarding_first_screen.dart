import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:muslim_werd_app/core/theming/assets.dart';
import 'package:muslim_werd_app/core/theming/styles.dart';
import 'package:muslim_werd_app/core/widgets/backgoroud_app.dart';
import 'package:muslim_werd_app/core/widgets/custom_button.dart';
import 'package:muslim_werd_app/features/onboarding/ui/onboarding_screen.dart';
import 'package:muslim_werd_app/features/onboarding/ui/widgets/onboarding_top_title.dart';

class OnboardingFirstScreen extends StatefulWidget {
  const OnboardingFirstScreen({super.key});

  @override
  State<OnboardingFirstScreen> createState() => _OnboardingFirstScreenState();
}

late AnimationController _animatedController;

class _OnboardingFirstScreenState extends State<OnboardingFirstScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    //controller\\
    _animatedController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 10),
    )..repeat();

    super.initState();
  }

  @override
  void dispose() {
    _animatedController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final widthScreen = MediaQuery.sizeOf(context).width;
    final heightScreen = MediaQuery.sizeOf(context).height;
    return Stack(
      alignment: Alignment.center,
      children: [
        BackgroundApp(),
        OnboardingTopTitle(text: 'وَرَتِّلِ الْقُرْآنَ تَرْتِيلًا'),
        Image.asset(
          Assets.imagesAlquranAlkareem,
          width: widthScreen * 0.45,
          height: heightScreen * 0.45,
        ),
        CircleRotrationAnimated(
          widthScreen: widthScreen,
          heightScreen: heightScreen,
        ),
        Positioned(
          bottom: 200.h,
          child: Text(
            'اقرأ وردك ف اي وقت بدون انترنت ',
            style: TextStyles.cairo30Bold(context),
          ),
        ),
        Positioned(
          bottom: 50.h,
          child: CustomButton(
            textButton: 'استمرار',
            onPressed: () {
              OnboardingScreen.pageController.nextPage(
                duration: Durations.medium3,
                curve: Curves.easeInOut,
              );
            },
          ),
        ),
      ],
    );
  }
}

class CircleRotrationAnimated extends StatelessWidget {
  const CircleRotrationAnimated({
    super.key,
    required this.widthScreen,
    required this.heightScreen,
  });

  final double widthScreen;
  final double heightScreen;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animatedController,
      builder:
          (_, child) => Transform.rotate(
            angle: _animatedController.value * 2 * pi,
            child: child,
          ),
      child: Image.asset(
        Assets.imagesOnboardingCircleDesign,
        width: widthScreen * 0.8,
        height: heightScreen * 0.8,
      ),
    );
  }
}
