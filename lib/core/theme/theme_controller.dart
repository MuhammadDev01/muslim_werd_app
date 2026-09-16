import 'package:flutter/material.dart';

class ThemeController {
  ThemeController._();

  static final ValueNotifier<ThemeMode> mode = ValueNotifier(ThemeMode.system);

  static void setDark(bool dark) {
    mode.value = dark ? ThemeMode.dark : ThemeMode.light;
  }
}