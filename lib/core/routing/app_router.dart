import 'package:flutter/material.dart';
import 'package:muslim_werd_app/core/routing/routes.dart';
import 'package:muslim_werd_app/features/onboarding/ui/onboarding_screen.dart';
import 'package:muslim_werd_app/features/onboarding/ui/widgets/onboarding_first_screen.dart';

class AppRouter {
  static Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      // onbarding
      case Routes.onBoardingScreen:
        return MaterialPageRoute(builder: (_) => OnboardingScreen());
      case SubRoutes.onboardingFirstScreen:
        return MaterialPageRoute(builder: (_) => OnboardingFirstScreen());
      case SubRoutes.onboardingSecondScreen:
        return MaterialPageRoute(builder: (_) => OnboardingScreen());
      case SubRoutes.onboardingThirdScreen:
        return MaterialPageRoute(builder: (_) => OnboardingScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(body: Text('Route not found')),
        );
    }
  }
}
