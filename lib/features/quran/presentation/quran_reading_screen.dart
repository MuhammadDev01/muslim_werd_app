import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:muslim_werd_app/core/theme/app_colors.dart';
import 'package:muslim_werd_app/core/widgets/app_background.dart';
import 'package:muslim_werd_app/features/quran/domain/models/quran_models.dart';
import 'package:muslim_werd_app/features/quran/data/repositories/quran_repository_impl.dart';
import 'package:muslim_werd_app/features/quran/presentation/cubit/quran_cubit.dart';
import 'package:muslim_werd_app/features/quran/presentation/cubit/quran_state.dart';

/// سورة التوبة لا تُفتتح بالبسملة، والفاتحة تحوي بسملتها في أول آية.
/// لذا لا نضيف بسملة رأس مستقلة لهما لتجنب التكرار.
const _surahsWithoutBasmala = {1, 9};

class QuranReadingScreen extends StatefulWidget {
  const QuranReadingScreen({super.key, required this.surahNumber});

  final int surahNumber;

  @override
  State<QuranReadingScreen> createState() => _QuranReadingScreenState();
}

class _QuranReadingScreenState extends State<QuranReadingScreen> {
  late final QuranReadingCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = QuranReadingCubit(repository: QuranRepositoryImpl())
      ..loadSurah(widget.surahNumber);
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _surahName(widget.surahNumber),
          style: const TextStyle(fontFamily: 'Cairo'),
        ),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            const AppBackground(),
            BlocBuilder<QuranReadingCubit, QuranReadingState>(
              bloc: _cubit,
              builder: (context, state) {
                return switch (state.status) {
                  QuranStatus.loading =>
                    const Center(child: CircularProgressIndicator()),
                  QuranStatus.failure => _ErrorView(
                    message: state.errorMessage ?? 'حدث خطأ غير متوقع',
                    onRetry: () => _cubit.loadSurah(widget.surahNumber),
                  ),
                  QuranStatus.success when state.surah != null =>
                    _ReadingView(surah: state.surah!),
                  _ => const SizedBox.shrink(),
                };
              },
            ),
          ],
        ),
      ),
    );
  }

  String _surahName(int number) {
    switch (number) {
      case 1:
        return 'سورة الفاتحة';
      case 9:
        return 'سورة التوبة';
      default:
        return 'سورة رقم $number';
    }
  }
}

class _ReadingView extends StatelessWidget {
  const _ReadingView({required this.surah});

  final QuranSurah surah;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final showBasmala = !_surahsWithoutBasmala.contains(surah.number);

    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
      children: [
        _SurahHeader(surah: surah, showBasmala: showBasmala, isDark: isDark),
        const Gap(20),
        _VersesText(surah: surah, isDark: isDark),
        const Gap(24),
        const _EndMark(),
        const Gap(12),
      ],
    );
  }
}

class _SurahHeader extends StatelessWidget {
  const _SurahHeader({
    required this.surah,
    required this.showBasmala,
    required this.isDark,
  });

  final QuranSurah surah;
  final bool showBasmala;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final primaryText = isDark
        ? AppColors.darkTextPrimary
        : AppColors.textPrimary;
    final secondaryText = isDark
        ? AppColors.darkTextSecondary
        : AppColors.textSecondary;

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
                style: TextStyle(
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
          if (showBasmala) ...[
            const Gap(12),
            Text(
              'بِسۡمِ ٱللَّهِ ٱلرَّحۡمَٰنِ ٱلرَّحِيمِ',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 22,
                height: 1.8,
                fontFamily: 'AmiriQuran',
                color: primaryText,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _VersesText extends StatelessWidget {
  const _VersesText({required this.surah, required this.isDark});

  final QuranSurah surah;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final primaryText = isDark
        ? AppColors.darkTextPrimary
        : AppColors.textPrimary;

    return Text.rich(
      TextSpan(
        children: [
          for (final (index, verse) in surah.verses.indexed) ...[
            TextSpan(
              text: verse.text,
              style: const TextStyle(
                fontSize: 24,
                height: 2.0,
                fontFamily: 'AmiriQuran',
              ),
            ),
            TextSpan(
              text: ' ﴿${_toArabicDigits(verse.number)}﴾ ',
              style: TextStyle(
                fontSize: 22,
                height: 2.0,
                fontFamily: 'AmiriQuran',
                color: AppColors.gold,
              ),
            ),
            if (index == surah.verses.length - 1)
              TextSpan(
                text: '',
                style: TextStyle(
                  fontSize: 24,
                  height: 2.0,
                  fontFamily: 'AmiriQuran',
                  color: primaryText,
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

String _toArabicDigits(int number) {
  const digits = '٠١٢٣٤٥٦٧٨٩';
  return number
      .toString()
      .split('')
      .map((c) => digits[c.codeUnitAt(0) - 48])
      .join();
}

class _EndMark extends StatelessWidget {
  const _EndMark();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 56,
        height: 8,
        decoration: BoxDecoration(
          color: AppColors.gold,
          borderRadius: BorderRadius.circular(4),
        ),
      ),
    );
  }
}

class _ErrorView extends StatelessWidget {
  const _ErrorView({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.cloud_off, size: 48, color: AppColors.textSecondary),
            const Gap(12),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontFamily: 'Cairo',
                fontSize: 15,
                color: AppColors.textSecondary,
              ),
            ),
            const Gap(16),
            OutlinedButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh),
              label: const Text('إعادة المحاولة'),
            ),
          ],
        ),
      ),
    );
  }
}