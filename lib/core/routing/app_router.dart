import 'package:flutter/material.dart';
import 'package:muslim_werd_app/core/routing/routes.dart';
import 'package:muslim_werd_app/features/home/home_screen.dart';
import 'package:muslim_werd_app/features/onboarding/ui/onboarding_screen.dart';
import 'package:muslim_werd_app/features/onboarding/ui/onboarding_first_screen.dart';
import 'package:muslim_werd_app/features/onboarding/ui/onboarding_second_screen.dart';
import 'package:muslim_werd_app/features/onboarding/ui/onboarding_third_screen.dart';

class AppRouter {
  static Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      //onbarding\\
      case Routes.onBoardingScreen:
        return MaterialPageRoute(builder: (_) => OnboardingScreen());
      case SubRoutes.onboardingFirstScreen:
        return MaterialPageRoute(builder: (_) => OnboardingFirstScreen());
      case SubRoutes.onboardingSecondScreen:
        return MaterialPageRoute(builder: (_) => OnboardingSecondScreen());
      case SubRoutes.onboardingThirdScreen:
        return MaterialPageRoute(builder: (_) => OnboardingThirdScreen());
      //Home\\
      case Routes.homeScreen:
        return MaterialPageRoute(builder: (_) => HomeScreen());

      default:
        return MaterialPageRoute(
          builder:
              (_) => Scaffold(body: Center(child: Text('Route not found D:)'))),
        );
    }
  }
}
