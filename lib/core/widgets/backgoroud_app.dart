import 'package:flutter/material.dart';
import 'package:muslim_werd_app/core/theme/assets.dart';

class BackgroundApp extends StatelessWidget {
  const BackgroundApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(top: 10, child: Image.asset(Assets.imagesEllipse));
  }
}
