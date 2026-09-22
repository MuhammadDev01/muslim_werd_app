import 'package:flutter/material.dart';
import 'package:muslim_werd_app/core/theme/app_styles.dart';
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
    return Stack(
      alignment: Alignment.center,
      children: [
        BackgroundApp(),
        OnboardingTopTitle(text: 'وَرَتِّلِ الْقُرْآنَ تَرْتِيلًا'),

        Positioned(
          bottom: 200,
          child: Text(
            'اقرأ وردك ف اي وقت بدون انترنت ',
            style: TextStyles.cairo30Bold(context),
          ),
        ),
        Positioned(
          bottom: 50,
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
