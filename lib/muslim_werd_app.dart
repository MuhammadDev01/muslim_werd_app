import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:muslim_werd_app/core/routing/app_router.dart';
import 'package:muslim_werd_app/core/routing/routes.dart';

class MuslimWerdApp extends StatelessWidget {
  const MuslimWerdApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: const Locale('ar'),
      supportedLocales: const [Locale('ar')],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      title: 'Muslim Werd',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(brightness: Brightness.light),
      darkTheme: ThemeData(brightness: Brightness.dark),
      themeMode: ThemeMode.system,
      initialRoute: Routes.homeScreen,
      onGenerateRoute: AppRouter.generateRoute,
    );
  }
}
