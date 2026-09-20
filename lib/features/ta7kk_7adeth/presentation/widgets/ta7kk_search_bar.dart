import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:muslim_werd_app/core/constants.dart';
import 'package:muslim_werd_app/core/theme/app_colors.dart';

class Ta7kkSearchBar extends StatelessWidget {
  const Ta7kkSearchBar({
    super.key,
    required this.controller,
    required this.isLoading,
    required this.onSearch,
  });

  final TextEditingController controller;
  final bool isLoading;
  final VoidCallback onSearch;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.gold, width: 1.2),
            ),
            child: TextField(
              controller: controller,
              cursorColor: AppColors.primary,
              textInputAction: TextInputAction.search,
              onSubmitted: (_) => onSearch(),
              decoration: InputDecoration(
                hintText: 'اكتب كلمات مفتاحية من الحديث...',
                hintStyle: TextStyle(
                  fontFamily: fontCairo,
                  fontSize: 12,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
                prefixIcon: const Icon(
                  Icons.search_rounded,
                  color: AppColors.primary,
                ),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.all(16),
              ),
            ),
          ),
          const Gap(12),
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton.icon(
              onPressed: onSearch,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 0,
              ),
              icon: Icon(
                isLoading ? Icons.hourglass_top_rounded : Icons.search_rounded,
                size: 20,
              ),
              label: Text(
                isLoading ? 'جاري البحث...' : 'بحث',
                style: const TextStyle(
                  fontFamily: fontCairo,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
