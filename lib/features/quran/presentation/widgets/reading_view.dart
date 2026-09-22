import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:muslim_werd_app/features/quran/domain/models/quran_models.dart';
import 'package:muslim_werd_app/features/quran/presentation/widgets/end_mark.dart';
import 'package:muslim_werd_app/features/quran/presentation/widgets/surah_header.dart';
import 'package:muslim_werd_app/features/quran/presentation/widgets/verses_text.dart';

class ReadingView extends StatelessWidget {
  const ReadingView({super.key, required this.surah, required this.isDark});

  final QuranSurah surah;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
      children: [
        SurahHeader(surah: surah, isDark: isDark),
        const Gap(20),
        VersesText(surah: surah, isDark: isDark),
        const Gap(24),
        const EndMark(),
        const Gap(12),
      ],
    );
  }
}
