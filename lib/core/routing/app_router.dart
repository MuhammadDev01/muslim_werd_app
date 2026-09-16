import 'package:flutter/material.dart';
import 'package:muslim_werd_app/core/routing/routes.dart';
import 'package:muslim_werd_app/features/azkar/ui/azkar_screen.dart';
import 'package:muslim_werd_app/features/eza3a/ui/eza3a_screen.dart';
import 'package:muslim_werd_app/features/favorites/favorites_screen.dart';
import 'package:muslim_werd_app/features/home/ui/home_screen.dart';
import 'package:muslim_werd_app/features/onboarding/ui/onboarding_screen.dart';
import 'package:muslim_werd_app/features/onboarding/ui/onboarding_first_screen.dart';
import 'package:muslim_werd_app/features/onboarding/ui/onboarding_second_screen.dart';
import 'package:muslim_werd_app/features/onboarding/ui/onboarding_third_screen.dart';
import 'package:muslim_werd_app/features/quran/ui/quran_screen.dart';
import 'package:muslim_werd_app/features/settings/settings_screen.dart';
import 'package:muslim_werd_app/features/ta7kk_7adeth/ta7kk_screen.dart';
import 'package:muslim_werd_app/features/tasbih/ui/tasbe7_screen.dart';

class AppRouter {
  static Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      //Routes
      case Routes.onBoardingScreen:
        return MaterialPageRoute(builder: (_) => OnboardingScreen());
      case Routes.homeScreen:
        return MaterialPageRoute(builder: (_) => HomePage());

      //SubRoutes
      //onBoarding
      case SubRoutes.onboardingFirstScreen:
        return MaterialPageRoute(builder: (_) => OnboardingFirstScreen());
      case SubRoutes.onboardingSecondScreen:
        return MaterialPageRoute(builder: (_) => OnboardingSecondScreen());
      case SubRoutes.onboardingThirdScreen:
        return MaterialPageRoute(builder: (_) => OnboardingThirdScreen());

      ///home
      case SubRoutes.quranScreen:
        return MaterialPageRoute(builder: (_) => QuranScreen());
      case SubRoutes.azkarScreen:
        return MaterialPageRoute(builder: (_) => AzkarScreen());
      case SubRoutes.favoriteScreen:
        return MaterialPageRoute(builder: (_) => FavoritesScreen());
      case SubRoutes.ta7kkScreen:
        return MaterialPageRoute(builder: (_) => Ta7kkScreen());
      case SubRoutes.tasbihScreen:
        return MaterialPageRoute(builder: (_) => TasbihScreen());
      case SubRoutes.eza3aScreen:
        return MaterialPageRoute(builder: (_) => Eza3aScreen());
      case SubRoutes.settingsScreen:
        return MaterialPageRoute(
          builder:
              (_) =>
                  SettingsScreen(), // Replace with your actual SettingsScreen widget
        );

      default:
        return MaterialPageRoute(
          builder:
              (_) => Scaffold(body: Center(child: Text('Route not found D:)'))),
        );
    }
  }
}
