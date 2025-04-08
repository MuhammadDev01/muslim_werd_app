import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:muslim_werd_app/core/routing/app_router.dart';
import 'package:muslim_werd_app/core/routing/routes.dart';

class MuslimWerdApp extends StatelessWidget {
  const MuslimWerdApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(720, 1280),

      minTextAdapt: true,
      child: MaterialApp(
        locale: DevicePreview.locale(context),
        builder: DevicePreview.appBuilder,
        title: 'Muslim Werd',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(brightness: Brightness.dark),
        initialRoute: Routes.onBoardingScreen,
        onGenerateRoute: AppRouter.generateRoute,
        darkTheme: ThemeData.dark(),
        //themeMode: ThemeMode.light,
      ),
    );
  }
}
