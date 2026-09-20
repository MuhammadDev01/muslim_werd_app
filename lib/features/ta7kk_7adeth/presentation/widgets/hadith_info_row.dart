import 'package:flutter/material.dart';
import 'package:muslim_werd_app/core/constants.dart';
import 'package:muslim_werd_app/core/theme/app_colors.dart';

class HadithInfoRow extends StatelessWidget {
  const HadithInfoRow({super.key, required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    if (value.trim().isEmpty) return const SizedBox.shrink();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label: ',
            style: TextStyle(
              fontFamily: fontCairo,
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontFamily: fontCairo,
                fontSize: 13,
                color:
                    isDark ? AppColors.darkTextPrimary : AppColors.textPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
