import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:muslim_werd_app/core/theming/assets.dart';

class BackgroundApp extends StatelessWidget {
  const BackgroundApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(top: 10.h, child: Image.asset(Assets.imagesEllipse));
  }
}
