import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:muslim_werd_app/core/constants.dart';

class Ta7kkEmptyView extends StatelessWidget {
  const Ta7kkEmptyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search_off_rounded,
            size: 64,
            color: Theme.of(context).colorScheme.outline,
          ),
          const Gap(16),
          Text(
            'لا توجد نتائج مطابقة',
            style: TextStyle(
              fontFamily: fontCairo,
              fontSize: 16,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}
