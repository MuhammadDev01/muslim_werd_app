import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:muslim_werd_app/core/theme/app_colors.dart';
import 'package:muslim_werd_app/core/widgets/app_background.dart';
import 'package:muslim_werd_app/features/quran/domain/models/quran_models.dart';
import 'package:muslim_werd_app/features/quran/data/repositories/quran_repository_impl.dart';
import 'package:muslim_werd_app/features/quran/presentation/cubit/quran_cubit.dart';
import 'package:muslim_werd_app/features/quran/presentation/cubit/quran_state.dart';
import 'package:muslim_werd_app/features/quran/presentation/quran_reading_screen.dart';

class QuranIndexScreen extends StatefulWidget {
  const QuranIndexScreen({super.key});

  @override
  State<QuranIndexScreen> createState() => _QuranIndexScreenState();
}

class _QuranIndexScreenState extends State<QuranIndexScreen> {
  late final QuranIndexCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = QuranIndexCubit(repository: QuranRepositoryImpl())..loadIndex();
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('القرآن الكريم')),
      body: SafeArea(
        child: Stack(
          children: [
            const AppBackground(),
            BlocBuilder<QuranIndexCubit, QuranIndexState>(
              bloc: _cubit,
              builder: (context, state) {
                return switch (state.status) {
                  QuranStatus.loading => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  QuranStatus.failure => _ErrorView(
                    message: state.errorMessage ?? 'حدث خطأ غير متوقع',
                    onRetry: _cubit.loadIndex,
                  ),
                  QuranStatus.success => _SurahList(surahs: state.surahs),
                  QuranStatus.initial => const SizedBox.shrink(),
                };
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _SurahList extends StatelessWidget {
  const _SurahList({required this.surahs});

  final List<QuranSurahSummary> surahs;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      itemCount: surahs.length,
      itemBuilder: (context, index) {
        final surah = surahs[index];
        final isLast = index == surahs.length - 1;
        return Padding(
          padding: EdgeInsets.only(bottom: isLast ? 0 : 10),
          child: _SurahTile(surah: surah, isDark: isDark),
        );
      },
    );
  }
}

class _SurahTile extends StatelessWidget {
  const _SurahTile({required this.surah, required this.isDark});

  final QuranSurahSummary surah;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final surface = isDark ? AppColors.darkSurface : AppColors.surface;
    final primaryText =
        isDark ? AppColors.darkTextPrimary : AppColors.textPrimary;
    final secondaryText =
        isDark ? AppColors.darkTextSecondary : AppColors.textSecondary;

    return Material(
      color: surface,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => QuranReadingScreen(surahNumber: surah.number),
            ),
          );
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: isDark ? AppColors.darkSecondary : AppColors.borderLight,
            ),
          ),
          child: Row(
            children: [
              _SurahNumberBadge(number: surah.number, isDark: isDark),
              const Gap(12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      surah.nameAr,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Cairo',
                        color: primaryText,
                      ),
                    ),
                    const Gap(2),
                    Text(
                      '${surah.revelationPlace} • ${surah.versesCount} آية',
                      style: TextStyle(
                        fontSize: 12,
                        fontFamily: 'Cairo',
                        color: secondaryText,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(Icons.chevron_left, color: AppColors.gold),
            ],
          ),
        ),
      ),
    );
  }
}

class _SurahNumberBadge extends StatelessWidget {
  const _SurahNumberBadge({required this.number, required this.isDark});

  final int number;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isDark ? AppColors.darkSecondary : AppColors.secondary,
        border: Border.all(color: AppColors.gold, width: 1.2),
      ),
      child: Text(
        '$number',
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          fontFamily: 'Cairo',
          color: AppColors.gold,
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
            const Icon(
              Icons.cloud_off,
              size: 48,
              color: AppColors.textSecondary,
            ),
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
