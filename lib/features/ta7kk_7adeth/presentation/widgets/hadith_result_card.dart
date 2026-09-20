import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:muslim_werd_app/core/constants.dart';
import 'package:muslim_werd_app/core/theme/app_colors.dart';
import 'package:muslim_werd_app/features/ta7kk_7adeth/domain/models/hadith_ta7kk_result.dart';
import 'package:muslim_werd_app/features/ta7kk_7adeth/presentation/widgets/hadith_grade_badge.dart';
import 'package:muslim_werd_app/features/ta7kk_7adeth/presentation/widgets/hadith_info_row.dart';

class HadithResultCard extends StatelessWidget {
  const HadithResultCard({
    super.key,
    required this.result,
    required this.number,
  });

  final HadithTa7kkResult result;
  final int number;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final status = result.gradeStatus;
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkSurface : AppColors.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.gold, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .06),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 26,
                height: 26,
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Text(
                  '$number',
                  style: const TextStyle(
                    fontFamily: fontCairo,
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: AppColors.white,
                  ),
                ),
              ),
              const Gap(10),
              Expanded(
                child: Text(
                  'خلاصة الحكم',
                  style: TextStyle(
                    fontFamily: fontCairo,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color:
                        isDark
                            ? AppColors.darkTextPrimary
                            : AppColors.textPrimary,
                  ),
                ),
              ),
              HadithGradeBadge(status: status, grade: result.grade),
            ],
          ),
          const Gap(12),
          Text(
            result.text,
            style: TextStyle(
              fontFamily: fontAmiri,
              fontSize: 16,
              height: 1.8,
              color: isDark ? AppColors.darkTextPrimary : AppColors.textPrimary,
            ),
          ),
          const Gap(12),
          const Divider(height: 1),
          const Gap(10),
          HadithInfoRow(label: 'الراوي', value: result.rawi),
          HadithInfoRow(label: 'المحدث', value: result.mohdith),
          HadithInfoRow(label: 'المصدر', value: result.book),
          if (result.pageNumber.isNotEmpty)
            HadithInfoRow(label: 'الصفحة أو الرقم', value: result.pageNumber),
        ],
      ),
    );
  }
}
