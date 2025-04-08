import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:muslim_werd_app/core/constants.dart';
import 'package:muslim_werd_app/core/theming/styles.dart';

class OnboardingTopTitle extends StatelessWidget {
  const OnboardingTopTitle({super.key, required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 200.h,
      child: Text(
        text,
        style: TextStyles.amiri36Bold.copyWith(fontFamily: fontCairo),
      ),
    );
  }
}
