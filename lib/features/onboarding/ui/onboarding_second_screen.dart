import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:muslim_werd_app/core/theming/assets.dart';
import 'package:muslim_werd_app/core/theming/styles.dart';
import 'package:muslim_werd_app/core/widgets/backgoroud_app.dart';
import 'package:muslim_werd_app/core/widgets/custom_button.dart';
import 'package:muslim_werd_app/features/onboarding/ui/onboarding_screen.dart';
import 'package:muslim_werd_app/features/onboarding/ui/widgets/onboarding_top_title.dart';

class OnboardingSecondScreen extends StatefulWidget {
  const OnboardingSecondScreen({super.key});

  @override
  State<OnboardingSecondScreen> createState() => _OnboardingSecondScreenState();
}

class _OnboardingSecondScreenState extends State<OnboardingSecondScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animatedController;
  late final Animation _animation;
  @override
  void initState() {
    //controller\\
    _animatedController = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    )..repeat(reverse: true);

    //animations\\
    _animation = Tween<double>(begin: 0, end: 30).animate(
      CurvedAnimation(parent: _animatedController, curve: Curves.easeInOut),
    );
    super.initState();
  }

  @override
  void dispose() {
    _animatedController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        BackgroundApp(),
        AnimatedBuilder(
          animation: _animation,
          builder:
              (_, child) => Transform.translate(
                offset: Offset(0, _animation.value),
                child: child,
              ),
          child: Image.asset(Assets.imagesOnBoardingSchedule),
        ),
        OnboardingTopTitle(text: 'جدول متابعة لوردك'),
        Positioned(
          bottom: 200.h,
          child: Column(
            spacing: 8,
            children: [
              Text('تابع وردك بشكل يومي', style: TextStyles.cairo30Bold),
              Text('للحفاظ على المداومة عليها', style: TextStyles.cairo30Bold),
            ],
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
