import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:muslim_werd_app/core/constants.dart';
import 'package:muslim_werd_app/core/theme/app_colors.dart';

class Ta7kkErrorView extends StatelessWidget {
  const Ta7kkErrorView({
    super.key,
    required this.message,
    required this.onRetry,
  });

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.cloud_off_rounded,
              size: 64,
              color: AppColors.gold,
            ),
            const Gap(16),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontFamily: fontCairo,
                fontSize: 15,
                color: AppColors.textSecondary,
              ),
            ),
            const Gap(16),
            OutlinedButton.icon(
              onPressed: onRetry,
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.primary,
                side: const BorderSide(color: AppColors.primary),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              icon: const Icon(Icons.refresh_rounded, size: 18),
              label: const Text(
                'إعادة المحاولة',
                style: TextStyle(fontFamily: fontCairo, fontSize: 14),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
