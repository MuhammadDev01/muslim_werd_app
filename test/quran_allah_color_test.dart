import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:muslim_werd_app/features/quran/presentation/quran_reading_screen.dart';

const _allahLightColor = Color(0xFFE53935);
const _rabLightColor = Color(0xFFE53935);

/// يجرّد الحركات ويوحّد الألف لمقارنة كلمة بعينها.
String _canonical(String s) {
  const ranges = [(0x064B, 0x065F), (0x0670, 0x0670), (0x0674, 0x0674), (0x0640, 0x0640)];
  const alef = {0x0622, 0x0623, 0x0625, 0x0671};
  final out = StringBuffer();
  for (final code in s.codeUnits) {
    if (ranges.any((r) => code >= r.$1 && code <= r.$2)) continue;
    out.writeCharCode(alef.contains(code) ? 0x0627 : code);
  }
  return out.toString();
}

/// يفحص كل RichText في الشجرة بحثاً عن قسم ملوَّن نصّه الكنوني [wanted].
bool _hasColoredSpan(WidgetTester tester, String wanted, Color color) {
  final found = <bool>[];
  for (final rich in tester.widgetList<RichText>(find.byType(RichText))) {
    rich.text.visitChildren((span) {
      if (span is TextSpan && span.text != null && found.isEmpty) {
        if (_canonical(span.text!) == wanted && span.style?.color == color) {
          found.add(true);
          return false;
        }
      }
      return true;
    });
    if (found.isNotEmpty) break;
  }
  return found.isNotEmpty;
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  Future<void> pumpSurah(WidgetTester tester, int surah) async {
    await tester.runAsync(() async {
      await tester.pumpWidget(
        MaterialApp(home: QuranReadingScreen(surahNumber: surah)),
      );
      await Future<void>.delayed(const Duration(milliseconds: 600));
      await tester.pump();
      await tester.pump();
    });
  }

  testWidgets('يُلوَّن لفظ الجلالة داخل النص القرآني', (tester) async {
    await pumpSurah(tester, 1);

    expect(
      _hasColoredSpan(tester, 'الله', _allahLightColor),
      isTrue,
      reason: 'لم يُعثر على لفظ الجلالة بلون مميز في النص',
    );
  });

  testWidgets('يُلوَّن ربّ مع ضميرها المتصل (رَبَّنَا)', (tester) async {
    await pumpSurah(tester, 2);

    expect(
      _hasColoredSpan(tester, 'ربنا', _rabLightColor),
      isTrue,
      reason: 'لم يُعثر على (ربَّنا) بلون مميز في سورة البقرة',
    );
  });

  testWidgets('يُلوَّن ربّ المجرّدة من الضمير', (tester) async {
    await pumpSurah(tester, 1);

    expect(
      _hasColoredSpan(tester, 'رب', _rabLightColor),
      isTrue,
      reason: 'لم يُعثر على (رَبِّ) بلون مميز في سورة الفاتحة',
    );
  });
}