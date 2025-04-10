import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:muslim_werd_app/core/theming/assets.dart';

class BackgroundHome extends StatelessWidget {
  const BackgroundHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          Assets.imagesMobileBackground,
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.cover,
        ),

        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
          child: Container(color: Colors.transparent),
        ),
      ],
    );
  }
}
