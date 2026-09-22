import 'package:flutter_test/flutter_test.dart';
import 'package:muslim_werd_app/features/quran/domain/services/divine_name_matcher.dart';

/// يجرّد الحركات ويوحّد الألف لمقارنة المحتوى المطابق.
String _strip(String s) {
  const ranges = [
    (0x064B, 0x065F),
    (0x0670, 0x0670),
    (0x0674, 0x0674),
    (0x0640, 0x0640),
  ];
  const alef = {0x0622, 0x0623, 0x0625, 0x0671};
  final out = StringBuffer();
  for (final code in s.codeUnits) {
    if (ranges.any((r) => code >= r.$1 && code <= r.$2)) continue;
    out.writeCharCode(alef.contains(code) ? 0x0627 : code);
  }
  return out.toString();
}

List<DivineMatch> _matchesOf(String text) =>
    DivineNameMatcher.findMatches(text);

void main() {
  group('divineMatches - لفظ الجلالة', () {
    test('يُكتشف «الله» المشكّل', () {
      const verse = 'قُلْ هُوَ ٱللَّهُ أَحَدٌ';
      final m = _matchesOf(verse).where((x) => x.kind == DivineKind.allah);
      expect(m, hasLength(1));
      final hit = m.single;
      expect(_strip(verse.substring(hit.start, hit.end)), 'الله');
    });

    test('يُكتشف «لله» بالألف المحذوفة', () {
      final m = _matchesOf('ٱلْحَمْدُ لِلَّهِ رَبِّ ٱلْعَٰلَمِينَ');
      expect(m.where((x) => x.kind == DivineKind.allah), hasLength(1));
    });
  });

  group('divineMatches - ربّ مع الضمير', () {
    test('رَبَّنَا تلوّن مكتملة', () {
      final m = _matchesOf('رَبَّنَا');
      expect(m, hasLength(1));
      expect(m.single.kind, DivineKind.rab);
      expect(m.single.start, 0);
      expect(m.single.end, 'رَبَّنَا'.length);
    });

    test('رَبِّ المجرّدة تُلوّن', () {
      final m = _matchesOf('رَبِّ ٱلْعَٰلَمِينَ');
      expect(m.where((x) => x.kind == DivineKind.rab), hasLength(1));
    });

    test('وَرَبُّكَ تُلوّن وتترك الواو', () {
      const verse = 'وَرَبُّكَ';
      final m = _matchesOf(verse).where((x) => x.kind == DivineKind.rab);
      expect(m, hasLength(1));
      final hit = m.single;
      expect(hit.start, greaterThan(0));
      expect(_strip(verse.substring(hit.start, hit.end)), 'ربك');
    });

    test('بِرَبِّ ٱلنَّاسِ تُلوّن', () {
      final m = _matchesOf('بِرَبِّ ٱلنَّاسِ');
      expect(m.where((x) => x.kind == DivineKind.rab), hasLength(1));
    });
  });

  group('divineMatches - لا تلوين لألفاظ لا تعود للإله', () {
    test('يَضْرِبُ لا يُعدّ ربّاً', () {
      final m = _matchesOf('يَضْرِبُ لَكُم مَّثَلًا');
      expect(m.where((x) => x.kind == DivineKind.rab), isEmpty);
    });

    test('أَرْبَابٌ لا تُعدّ ربّاً', () {
      final m = _matchesOf('وَٱتَّخَذُوا مِن دُونِهِۦٓ أَرْبَابًا');
      expect(m.where((x) => x.kind == DivineKind.rab), isEmpty);
    });

    test('رِّبًا (الربا) لا يُعدّ ربّاً', () {
      final m = _matchesOf('وَأَحَلَّ ٱللَّهُ ٱلْبَيْعَ وَحَرَّمَ ٱلرِّبَا');
      expect(m.where((x) => x.kind == DivineKind.rab), isEmpty);
    });
  });
}