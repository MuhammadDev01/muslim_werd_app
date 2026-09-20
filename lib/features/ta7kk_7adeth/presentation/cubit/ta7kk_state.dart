import 'package:muslim_werd_app/features/ta7kk_7adeth/domain/models/hadith_ta7kk_result.dart';

enum Ta7kkStatus {
  /// لم يبدأ البحث بعد.
  initial,

  /// جاري استرجاع البيانات من الـ API.
  loading,

  /// تم البحث بنجاح.
  success,

  /// حدث خطأ (شبكة/خادم/إدخال فارغ).
  failure,
}

class Ta7kkState {
  final Ta7kkStatus status;
  final List<HadithTa7kkResult> results;
  final String? errorMessage;

  const Ta7kkState({
    this.status = Ta7kkStatus.initial,
    this.results = const [],
    this.errorMessage,
  });

  Ta7kkState copyWith({
    Ta7kkStatus? status,
    List<HadithTa7kkResult>? results,
    String? errorMessage,
  }) {
    return Ta7kkState(
      status: status ?? this.status,
      results: results ?? this.results,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}