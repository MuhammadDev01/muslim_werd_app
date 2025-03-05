import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:muslim_werd_app/core/routing/app_router.dart';
import 'package:muslim_werd_app/core/routing/routes.dart';

class MuslimWerdApp extends StatelessWidget {
  const MuslimWerdApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(736, 1309),
      minTextAdapt: true,
      child: MaterialApp(
        title: 'Muslim Werd',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(),
        initialRoute: Routes.onBoardingScreen,
        onGenerateRoute: AppRouter.generateRoute,
        //darkTheme: ThemeData.dark(),
        //themeMode: ThemeMode.light,
      ),
    );
  }
}
