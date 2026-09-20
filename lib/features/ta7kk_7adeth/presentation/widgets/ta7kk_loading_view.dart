import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:muslim_werd_app/core/constants.dart';
import 'package:muslim_werd_app/core/theme/app_colors.dart';

class Ta7kkLoadingView extends StatelessWidget {
  const Ta7kkLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            width: 48,
            height: 48,
            child: CircularProgressIndicator(
              color: AppColors.primary,
              strokeWidth: 4,
            ),
          ),
          const Gap(20),
          Text(
            'جاري استرجاع بيانات الحديث...',
            style: TextStyle(
              fontFamily: fontCairo,
              fontSize: 15,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}
