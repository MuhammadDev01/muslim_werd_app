import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:muslim_werd_app/core/helper/extention.dart';
import 'package:muslim_werd_app/core/routing/routes.dart';
import 'package:muslim_werd_app/core/widgets/backgoroud_app.dart';
import 'package:muslim_werd_app/core/widgets/custom_button.dart';
import 'package:muslim_werd_app/features/onboarding/ui/widgets/book_marks_list_animated.dart';
import 'package:muslim_werd_app/features/onboarding/ui/widgets/eza3a_image_animated.dart';
import 'package:muslim_werd_app/features/onboarding/ui/widgets/onboarding_bottom_title.dart';
import 'package:muslim_werd_app/features/onboarding/ui/widgets/onboarding_top_title.dart';
import 'package:muslim_werd_app/features/onboarding/ui/widgets/sebha_with_hand_animation.dart';

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
        BackgroundApp(),
        Eza3aImageWithAnimated(animation: _animation),
        SebhaWithHandAnimated(animation: _animation),
        OnboardingTopTitle(text: 'مسبحة و إذاعة القرآن'),
        OnboardingBottomTitle(),
        BookMarksListAnimated(bookmarkAnimation: _bookmarkAnimation),

        Positioned(
          bottom: 50.h,
          child: CustomButton(
            textButton: 'توكل على الله',
            onPressed: () {
              context.pushNamedAndRemoveUntil(Routes.homeScreen, (_) => false);
            },
          ),
        ),
      ],
    );
  }
}
