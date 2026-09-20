import 'package:flutter_test/flutter_test.dart';
import 'package:muslim_werd_app/features/ta7kk_7adeth/domain/models/hadith_ta7kk_result.dart';
import 'package:muslim_werd_app/features/ta7kk_7adeth/domain/repositories/ta7kk_repository.dart';
import 'package:muslim_werd_app/features/ta7kk_7adeth/presentation/cubit/ta7kk_cubit.dart';
import 'package:muslim_werd_app/features/ta7kk_7adeth/presentation/cubit/ta7kk_state.dart';

class _MockTa7kkRepository implements Ta7kkRepository {
  _MockTa7kkRepository({this.shouldFail = false});

  final bool shouldFail;
  int searchCalls = 0;

  @override
  Future<List<HadithTa7kkResult>> search(String keywords) async {
    searchCalls++;
    if (shouldFail) throw Exception('network');
    return [
      const HadithTa7kkResult(
        text: 'إنما الأعمال بالنيات',
        rawi: 'عمر بن الخطاب',
        mohdith: 'الألباني',
        book: 'صحيح البخاري',
        pageNumber: '1',
        grade: 'صحيح',
      ),
    ];
  }
}

void main() {
  test('emits loading then success with results', () async {
    final cubit = Ta7kkCubit(repository: _MockTa7kkRepository());
    final emitted = <Ta7kkStatus>[];

    cubit.stream.listen((state) => emitted.add(state.status));

    await cubit.search('إنما الأعمال بالنيات');

    expect(cubit.state.status, Ta7kkStatus.success);
    expect(cubit.state.results, hasLength(1));
    expect(cubit.state.results.first.text, 'إنما الأعمال بالنيات');
    expect(emitted, contains(Ta7kkStatus.loading));
    await cubit.close();
  });

  test('emits failure on empty input without calling repository', () async {
    final repo = _MockTa7kkRepository();
    final cubit = Ta7kkCubit(repository: repo);

    await cubit.search('   ');

    expect(cubit.state.status, Ta7kkStatus.failure);
    expect(cubit.state.errorMessage, contains('كلمات مفتاحية'));
    expect(repo.searchCalls, 0);
    await cubit.close();
  });

  test('emits failure on repository error', () async {
    final cubit = Ta7kkCubit(repository: _MockTa7kkRepository(shouldFail: true));

    await cubit.search('كلمة');

    expect(cubit.state.status, Ta7kkStatus.failure);
    expect(cubit.state.results, isEmpty);
    await cubit.close();
  });
}