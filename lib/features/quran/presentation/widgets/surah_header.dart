import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:muslim_werd_app/core/theme/app_colors.dart';
import 'package:muslim_werd_app/features/quran/domain/models/quran_models.dart';
import 'package:muslim_werd_app/features/quran/domain/utils/quran_text_utils.dart';
import 'package:muslim_werd_app/features/quran/presentation/widgets/divine_text_span_builder.dart';

class SurahHeader extends StatelessWidget {
  const SurahHeader({
    super.key,
    required this.surah,
    this.showBasmala,
    required this.isDark,
  });

  final QuranSurah surah;
  final bool? showBasmala;
  final bool isDark;

  /// يُظهر البسملة ما لم يُمرَّر صراحة، بحسب قاعدة السورة.
  bool get _effectiveShowBasmala =>
      showBasmala ?? QuranTextUtils.hasHeaderBasmala(surah.number);

  @override
  Widget build(BuildContext context) {
    final primaryText =
        isDark ? AppColors.darkTextPrimary : AppColors.textPrimary;
    final secondaryText =
        isDark ? AppColors.darkTextSecondary : AppColors.textSecondary;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: isDark ? AppColors.darkSecondary : AppColors.secondary,
        border: Border.all(color: AppColors.gold, width: 1.2),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                surah.nameAr,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Cairo',
                  color: primaryText,
                ),
              ),
              const Gap(10),
              Text(
                '(${surah.number})',
                style: const TextStyle(
                  fontSize: 14,
                  fontFamily: 'Cairo',
                  color: AppColors.gold,
                ),
              ),
            ],
          ),
          const Gap(4),
          Text(
            '${surah.revelationPlace} — ${surah.verses.length} آية',
            style: TextStyle(
              fontSize: 13,
              fontFamily: 'Cairo',
              color: secondaryText,
            ),
          ),
          if (_effectiveShowBasmala) ...[
            const Gap(12),
            Text.rich(
              TextSpan(
                children: DivineTextSpanBuilder.highlightDivineNames(
                  'بِسۡمِ ٱللَّهِ ٱلرَّحۡمَٰنِ ٱلرَّحِيمِ',
                  normal: TextStyle(
                    fontSize: 22,
                    height: 1.8,
                    fontFamily: 'AmiriQuran',
                    color: primaryText,
                  ),
                  allah: TextStyle(
                    fontSize: 22,
                    height: 1.8,
                    fontFamily: 'AmiriQuran',
                    color:
                        isDark
                            ? DivineTextSpanBuilder.allahDarkColor
                            : DivineTextSpanBuilder.allahLightColor,
                  ),
                  rab: TextStyle(
                    fontSize: 22,
                    height: 1.8,
                    fontFamily: 'AmiriQuran',
                    color:
                        isDark
                            ? DivineTextSpanBuilder.rabDarkColor
                            : DivineTextSpanBuilder.rabLightColor,
                  ),
                ),
              ),
              textAlign: TextAlign.center,
              textDirection: TextDirection.rtl,
            ),
          ],
        ],
      ),
    );
  }
}
