import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muslim_werd_app/core/widgets/app_background.dart';
import 'package:muslim_werd_app/features/quran/data/repositories/quran_repository_impl.dart';
import 'package:muslim_werd_app/features/quran/domain/repositories/quran_repository.dart';
import 'package:muslim_werd_app/features/quran/presentation/cubit/quran_cubit.dart';
import 'package:muslim_werd_app/features/quran/presentation/cubit/quran_state.dart';
import 'package:muslim_werd_app/features/quran/presentation/widgets/quran_error_view.dart';
import 'package:muslim_werd_app/features/quran/presentation/widgets/reading_view.dart';

class QuranReadingScreen extends StatelessWidget {
  const QuranReadingScreen({
    super.key,
    required this.surahNumber,
    this.initialSurahName,
    this.repository,
  });

  final int surahNumber;
  final String? initialSurahName;
  final QuranRepository? repository;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (_) =>
              QuranReadingCubit(repository: repository ?? QuranRepositoryImpl())
                ..loadSurah(surahNumber),
      child: _QuranReadingBody(
        surahNumber: surahNumber,
        initialSurahName: initialSurahName,
      ),
    );
  }
}

class _QuranReadingBody extends StatelessWidget {
  const _QuranReadingBody({required this.surahNumber, this.initialSurahName});

  final int surahNumber;
  final String? initialSurahName;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: BlocBuilder<QuranReadingCubit, QuranReadingState>(
          builder: (context, state) {
            final title =
                state.surah?.nameAr ??
                initialSurahName ??
                _surahName(surahNumber);
            return Text(title, style: const TextStyle(fontFamily: 'Cairo'));
          },
        ),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            const AppBackground(),
            BlocBuilder<QuranReadingCubit, QuranReadingState>(
              builder: (context, state) {
                return switch (state.status) {
                  QuranStatus.loading => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  QuranStatus.failure => QuranErrorView(
                    message: state.errorMessage ?? 'حدث خطأ غير متوقع',
                    onRetry:
                        () => context.read<QuranReadingCubit>().loadSurah(
                          surahNumber,
                        ),
                  ),
                  QuranStatus.success when state.surah != null => ReadingView(
                    surah: state.surah!,
                    isDark: isDark,
                  ),
                  _ => const SizedBox.shrink(),
                };
              },
            ),
          ],
        ),
      ),
    );
  }

  static String _surahName(int number) {
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
