import 'package:flutter/material.dart';
import 'package:muslim_werd_app/core/constants.dart';
import 'package:muslim_werd_app/core/theme/app_styles.dart';

class OnboardingTopTitle extends StatelessWidget {
  const OnboardingTopTitle({super.key, required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 200,
      child: Text(
        text,
        style: TextStyles.amiri24Bold(context).copyWith(fontFamily: fontCairo),
      ),
    );
  }
}
