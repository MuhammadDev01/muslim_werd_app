import 'package:flutter/material.dart';
import 'package:muslim_werd_app/core/theme/assets.dart';

class AppBackground extends StatelessWidget {
  const AppBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Image.asset(
        Theme.of(context).brightness == Brightness.dark
            ? Assets.imagesDarkBackground
            : Assets.imagesLightBackground,
        fit: BoxFit.cover,
      ),
    );
  }
}
