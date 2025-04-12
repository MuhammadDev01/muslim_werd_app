import 'package:flutter/material.dart';
import 'package:muslim_werd_app/core/theming/assets.dart';

class BackgroundHome extends StatelessWidget {
  const BackgroundHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      Assets.imagesMobileBackground,
      width: double.infinity,
      height: double.infinity,
      fit: BoxFit.cover,
    );
  }
}
