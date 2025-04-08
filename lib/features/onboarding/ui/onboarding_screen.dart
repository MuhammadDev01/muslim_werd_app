import 'package:flutter/material.dart';
import 'package:muslim_werd_app/features/onboarding/ui/onboarding_first_screen.dart';
import 'package:muslim_werd_app/features/onboarding/ui/onboarding_second_screen.dart';
import 'package:muslim_werd_app/features/onboarding/ui/onboarding_third_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});
  static final PageController pageController = PageController();

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  void dispose() {
    OnboardingScreen.pageController.dispose();
    super.dispose();
  }

  final List<Widget> onBoardingScreens = const [
    OnboardingFirstScreen(),
    OnboardingSecondScreen(),
    OnboardingThirdScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    // final heightScreen = MediaQuery.sizeOf(context).height;
    // final widthScreen = MediaQuery.sizeOf(context).width;
    return Scaffold(
      body: PageView(
        controller: OnboardingScreen.pageController,
        children: List.generate(3, (index) => onBoardingScreens[index]),
      ),
    );
  }
}
