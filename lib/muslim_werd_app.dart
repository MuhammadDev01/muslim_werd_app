import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:muslim_werd_app/core/routing/app_router.dart';
import 'package:muslim_werd_app/core/routing/routes.dart';
import 'package:muslim_werd_app/core/theme/app_theme.dart';
import 'package:muslim_werd_app/core/theme/theme_controller.dart';

class MuslimWerdApp extends StatelessWidget {
  const MuslimWerdApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: ThemeController.mode,
      builder: (context, themeMode, _) {
        return wrapWithStatusBar(
          child: MaterialApp(
            locale: const Locale('ar'),
            supportedLocales: const [Locale('ar')],
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            title: 'Muslim Werd',
            debugShowCheckedModeBanner: false,
            theme: lightTheme(),
            darkTheme: darkTheme(),
            themeMode: themeMode,
            initialRoute: Routes.homeScreen,
            onGenerateRoute: AppRouter.generateRoute,
          ),
        );
      },
    );
  }
}