import 'package:flutter/material.dart';
import 'package:muslim_werd_app/features/ta7kk_7adeth/domain/models/hadith_ta7kk_result.dart';
import 'package:muslim_werd_app/features/ta7kk_7adeth/presentation/widgets/hadith_result_card.dart';

class Ta7kkResultsList extends StatelessWidget {
  const Ta7kkResultsList({super.key, required this.results});

  final List<HadithTa7kkResult> results;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
      itemCount: results.length,
      itemBuilder:
          (context, index) =>
              HadithResultCard(result: results[index], number: index + 1),
    );
  }
}
