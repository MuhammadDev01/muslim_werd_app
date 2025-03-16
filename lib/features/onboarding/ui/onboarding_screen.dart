import 'package:flutter/material.dart';
import 'package:muslim_werd_app/features/onboarding/ui/widgets/onboarding_first_screen.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  final List<Widget> onBoardingScreens = const [
    OnboardingFirstScreen(),
    Center(child: Text('Second Screen')),
    Center(child: Text('third Screen')),
  ];

  @override
  Widget build(BuildContext context) {
    // final heightScreen = MediaQuery.sizeOf(context).height;
    // final widthScreen = MediaQuery.sizeOf(context).width;
    return Scaffold(
      body: PageView(
        children: List.generate(3, (index) => onBoardingScreens[index]),
      ),
    );
  }
}
