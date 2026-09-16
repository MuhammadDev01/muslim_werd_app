import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:muslim_werd_app/core/constants.dart';
import 'package:muslim_werd_app/core/theme/app_colors.dart';

const _appBarTheme = AppBarTheme(
  backgroundColor: AppColors.primary,
  foregroundColor: AppColors.white,
  centerTitle: true,
  titleTextStyle: TextStyle(
    fontFamily: fontCairo,
    fontSize: 14,
    fontWeight: FontWeight.bold,
    color: AppColors.white,
  ),
);

const _statusBarStyle = SystemUiOverlayStyle(
  statusBarColor: AppColors.primary,
  statusBarIconBrightness: Brightness.light,
  statusBarBrightness: Brightness.dark,
);

ThemeData lightTheme() =>
    ThemeData(brightness: Brightness.light, appBarTheme: _appBarTheme);

ThemeData darkTheme() =>
    ThemeData(brightness: Brightness.dark, appBarTheme: _appBarTheme);

AnnotatedRegion<SystemUiOverlayStyle> wrapWithStatusBar({
  required Widget child,
}) {
  return AnnotatedRegion<SystemUiOverlayStyle>(
    value: _statusBarStyle,
    child: child,
  );
}
