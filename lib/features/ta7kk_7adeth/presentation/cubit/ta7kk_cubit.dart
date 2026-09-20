import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muslim_werd_app/features/ta7kk_7adeth/domain/repositories/ta7kk_repository.dart';
import 'package:muslim_werd_app/features/ta7kk_7adeth/presentation/cubit/ta7kk_state.dart';

/// يدير منطق البحث في صحة الأحاديث.
/// يعتمد على [Ta7kkRepository] (تجريد) — يعكس مبدأ Dependency Inversion.
class Ta7kkCubit extends Cubit<Ta7kkState> {
  Ta7kkCubit({required this.repository}) : super(const Ta7kkState());

  final Ta7kkRepository repository;

  Future<void> search(String? input) async {
    final keywords = input?.trim() ?? '';

    if (keywords.isEmpty) {
      emit(
        const Ta7kkState(
          status: Ta7kkStatus.failure,
          errorMessage: 'أدخل كلمات مفتاحية للبحث عن الحديث',
        ),
      );
      return;
    }

    emit(const Ta7kkState(status: Ta7kkStatus.loading));

    try {
      final results = await repository.search(keywords);
      if (isClosed) return;
      emit(Ta7kkState(status: Ta7kkStatus.success, results: results));
    } catch (_) {
      if (isClosed) return;
      emit(
        const Ta7kkState(
          status: Ta7kkStatus.failure,
          errorMessage: 'تعذر الاتصال بالخادم، حاول مرة أخرى',
        ),
      );
    }
  }
}