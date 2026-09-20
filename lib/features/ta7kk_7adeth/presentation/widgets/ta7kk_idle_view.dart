import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:muslim_werd_app/core/constants.dart';

class Ta7kkIdleView extends StatelessWidget {
  const Ta7kkIdleView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search_rounded,
            size: 64,
            color: Theme.of(context).colorScheme.outline,
          ),
          const Gap(16),
          Text(
            'ابدأ بحثك عن الحديث',
            style: TextStyle(
              fontFamily: fontCairo,
              fontSize: 16,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
          const Gap(6),
          Text(
            'اكتب كلمات مفتاحية ثم اضغط زر البحث',
            style: TextStyle(
              fontFamily: fontCairo,
              fontSize: 13,
              color: Theme.of(context).colorScheme.outline,
            ),
          ),
        ],
      ),
    );
  }
}
