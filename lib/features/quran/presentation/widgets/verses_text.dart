import 'package:flutter/material.dart';
import 'package:muslim_werd_app/core/theme/app_colors.dart';
import 'package:muslim_werd_app/features/quran/domain/models/quran_models.dart';
import 'package:muslim_werd_app/features/quran/domain/utils/quran_text_utils.dart';
import 'package:muslim_werd_app/features/quran/presentation/widgets/divine_text_span_builder.dart';

class VersesText extends StatelessWidget {
  const VersesText({super.key, required this.surah, required this.isDark});

  final QuranSurah surah;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final primaryText =
        isDark ? AppColors.darkTextPrimary : AppColors.textPrimary;

    return Text.rich(
      TextSpan(
        children: [
          for (final verse in surah.verses) ...[
            ...DivineTextSpanBuilder.highlightDivineNames(
              verse.text,
              normal: TextStyle(
                fontSize: 24,
                height: 2.0,
                fontFamily: 'AmiriQuran',
                color: primaryText,
              ),
              allah: TextStyle(
                fontSize: 24,
                height: 2.0,
                fontFamily: 'AmiriQuran',
                color:
                    isDark
                        ? DivineTextSpanBuilder.allahDarkColor
                        : DivineTextSpanBuilder.allahLightColor,
              ),
              rab: TextStyle(
                fontSize: 24,
                height: 2.0,
                fontFamily: 'AmiriQuran',
                color:
                    isDark
                        ? DivineTextSpanBuilder.rabDarkColor
                        : DivineTextSpanBuilder.rabLightColor,
              ),
            ),
            TextSpan(
              text: ' ﴿${QuranTextUtils.toArabicDigits(verse.number)}﴾ ',
              style: const TextStyle(
                fontSize: 22,
                height: 2.0,
                fontFamily: 'AmiriQuran',
                color: AppColors.gold,
              ),
            ),
          ],
        ],
      ),
      textDirection: TextDirection.rtl,
      style: TextStyle(
        fontSize: 24,
        height: 2.0,
        fontFamily: 'AmiriQuran',
        color: primaryText,
      ),
    );
  }
}
