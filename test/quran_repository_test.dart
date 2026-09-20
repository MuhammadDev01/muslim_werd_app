import 'package:flutter_test/flutter_test.dart';
import 'package:muslim_werd_app/features/quran/data/repositories/quran_repository_impl.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('QuranRepositoryImpl', () {
    test('loadSurahIndex يعيد 114 سورة', () async {
      final repo = QuranRepositoryImpl();
      final index = await repo.loadSurahIndex();
      expect(index.length, 114);
    });

    test('أول سورة هي الفاتحة بسبع آيات', () async {
      final repo = QuranRepositoryImpl();
      final index = await repo.loadSurahIndex();
      expect(index.first.number, 1);
      expect(index.first.nameAr, 'الفاتحة');
      expect(index.first.versesCount, 7);
    });

    test('الفاتحة تُعرض بآياتها السبعة ونص كل آية', () async {
      final repo = QuranRepositoryImpl();
      final surah = await repo.loadSurah(1);
      expect(surah.verses.length, 7);
      expect(surah.verses.first.text, contains('بِسۡمِ'));
      expect(surah.verses.first.juz, 1);
      expect(surah.verses.first.page, 1);
    });

    test('البقرة تحتوي 286 آية وتبدأ بالمقطعات', () async {
      final repo = QuranRepositoryImpl();
      final surah = await repo.loadSurah(2);
      expect(surah.verses.length, 286);
      expect(surah.verses.first.text, contains('الٓمٓ'));
    });

    test('سورة تطلب برقم غير موجود ترمي خطأ', () async {
      final repo = QuranRepositoryImpl();
      expect(
        () => repo.loadSurah(999),
        throwsA(isA<StateError>()),
      );
    });

    test('سورة الإسراء تُقرأ بآية السجدة object بشكل صحيح', () async {
      final repo = QuranRepositoryImpl();
      final surah = await repo.loadSurah(17);
      expect(surah.verses.length, 111);

      final sajdaVerse = surah.verses.firstWhere((v) => v.sajda == true);
      expect(sajdaVerse.number, 109);
    });

    test('آيات بدون سجدة تعيد false ولا ترمي خطأ', () async {
      final repo = QuranRepositoryImpl();
      final surah = await repo.loadSurah(17);
      final normalVerse = surah.verses.firstWhere((v) => v.number == 1);
      expect(normalVerse.sajda, false);
    });
  });
}