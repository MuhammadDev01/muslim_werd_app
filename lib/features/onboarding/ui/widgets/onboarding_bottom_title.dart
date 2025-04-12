import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:muslim_werd_app/core/theming/styles.dart';

class OnboardingBottomTitle extends StatelessWidget {
  const OnboardingBottomTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 200.h,
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
