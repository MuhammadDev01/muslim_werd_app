import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muslim_werd_app/features/quran/domain/repositories/quran_repository.dart';
import 'package:muslim_werd_app/features/quran/presentation/cubit/quran_state.dart';

class QuranIndexCubit extends Cubit<QuranIndexState> {
  QuranIndexCubit({required this.repository})
      : super(const QuranIndexState());

  final QuranRepository repository;

  Future<void> loadIndex() async {
    emit(const QuranIndexState(status: QuranStatus.loading));
    try {
      final surahs = await repository.loadSurahIndex();
      if (isClosed) return;
      emit(QuranIndexState(status: QuranStatus.success, surahs: surahs));
    } catch (_) {
      if (isClosed) return;
      emit(
        const QuranIndexState(
          status: QuranStatus.failure,
          errorMessage: 'تعذر تحميل بيانات القرآن الكريم',
        ),
      );
    }
  }
}

class QuranReadingCubit extends Cubit<QuranReadingState> {
  QuranReadingCubit({required this.repository})
      : super(const QuranReadingState());

  final QuranRepository repository;

  Future<void> loadSurah(int number) async {
    emit(const QuranReadingState(status: QuranStatus.loading));
    try {
      final surah = await repository.loadSurah(number);
      if (isClosed) return;
      emit(QuranReadingState(status: QuranStatus.success, surah: surah));
    } catch (_) {
      if (isClosed) return;
      emit(
        const QuranReadingState(
          status: QuranStatus.failure,
          errorMessage: 'تعذر تحميل السورة',
        ),
      );
    }
  }
}