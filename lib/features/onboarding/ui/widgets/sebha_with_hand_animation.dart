import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:muslim_werd_app/core/theming/assets.dart';

class SebhaWithHandAnimated extends StatelessWidget {
  const SebhaWithHandAnimated({super.key, required this.animation});
final Animation animation;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment(1.5, -0.2),
      child: AnimatedBuilder(
        animation: animation,
        builder:
            (_, child) => Transform.translate(
              offset: Offset(0, animation.value),
              child: child,
            ),
        child: Image.asset(Assets.imagesSebha, width: 400.w),
      ),
    );
  }
}
