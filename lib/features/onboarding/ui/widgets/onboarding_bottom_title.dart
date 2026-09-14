import 'package:flutter/material.dart';
import 'package:muslim_werd_app/core/theme/app_styles.dart';

class OnboardingBottomTitle extends StatelessWidget {
  const OnboardingBottomTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 200,
      child: Column(
        spacing: 8,
        children: [
          Text(
            'أكثر من علامة حفظ إذا لديك أكثر من ختمة',
            style: TextStyles.cairo30Bold(context),
          ),
          Text('!والمزيد', style: TextStyles.cairo30Bold(context)),
        ],
      ),
    );
  }
}
