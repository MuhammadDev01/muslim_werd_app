import 'package:flutter/material.dart';
import 'package:muslim_werd_app/core/constants.dart';
import 'package:muslim_werd_app/core/theme/app_colors.dart';
import 'package:muslim_werd_app/core/theme/assets.dart';
import 'package:muslim_werd_app/core/theme/theme_controller.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'الإعدادات',
          style: TextStyle(fontFamily: fontCairo, fontWeight: FontWeight.bold),
        ),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              Theme.of(context).brightness == Brightness.dark
                  ? Assets.imagesDarkBackground
                  : Assets.imagesLightBackground,
              fit: BoxFit.cover,
            ),
          ),
          ValueListenableBuilder<ThemeMode>(
            valueListenable: ThemeController.mode,
            builder: (context, themeMode, _) {
              final isDark = themeMode == ThemeMode.dark;
              return ListView(
                padding: const EdgeInsets.all(20),
                children: [
                  Container(
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppColors.gold, width: 1),
                    ),
                    child: Material(
                      type: MaterialType.transparency,
                      borderRadius: BorderRadius.circular(16),
                      child: SwitchListTile(
                        value: isDark,
                        onChanged: ThemeController.setDark,
                        activeThumbColor: AppColors.white,
                        activeTrackColor: AppColors.primary,
                        tileColor: AppColors.surface,
                        title: const Text(
                          'الوضع الداكن',
                          style: TextStyle(
                            fontFamily: fontCairo,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                        subtitle: const Text(
                          'استخدام خلفية داكنة في التطبيق',
                          style: TextStyle(
                            fontFamily: fontCairo,
                            fontSize: 10,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
