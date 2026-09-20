import 'package:muslim_werd_app/features/quran/domain/models/quran_models.dart';

enum QuranStatus { initial, loading, success, failure }

/// حالة فهرس السور.
class QuranIndexState {
  final QuranStatus status;
  final List<QuranSurahSummary> surahs;
  final String? errorMessage;

  const QuranIndexState({
    this.status = QuranStatus.initial,
    this.surahs = const [],
    this.errorMessage,
  });

  QuranIndexState copyWith({
    QuranStatus? status,
    List<QuranSurahSummary>? surahs,
    String? errorMessage,
  }) {
    return QuranIndexState(
      status: status ?? this.status,
      surahs: surahs ?? this.surahs,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

/// حالة سورة معينة للقراءة.
class QuranReadingState {
  final QuranStatus status;
  final QuranSurah? surah;
  final String? errorMessage;

  const QuranReadingState({
    this.status = QuranStatus.initial,
    this.surah,
    this.errorMessage,
  });

  QuranReadingState copyWith({
    QuranStatus? status,
    QuranSurah? surah,
    String? errorMessage,
    bool clearSurah = false,
  }) {
    return QuranReadingState(
      status: status ?? this.status,
      surah: clearSurah ? null : (surah ?? this.surah),
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}