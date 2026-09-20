import 'package:flutter_test/flutter_test.dart';
import 'package:muslim_werd_app/features/ta7kk_7adeth/data/repositories/dorar_html_parser.dart';
import 'package:muslim_werd_app/features/ta7kk_7adeth/domain/models/hadith_ta7kk_result.dart';

void main() {
  const sample =
      '<head>\n    <link rel="canonical" href="https://dorar.net/dorar_api.json">\n</head>\n'
      '<div class="hadith" style="text-align:justify;">1 -   <span class="search-keys">إنما</span> <span class="search-keys">الأعمال</span> ... الحَديث. .</div>\n\n'
      '<div class="hadith-info">\n    <span class="info-subtitle">الراوي:</span> عمر بن الخطاب</span>\n'
      '    <span class="info-subtitle">المحدث:</span> الألباني\n'
      '    <span class="info-subtitle">المصدر:</span>  غاية المرام\n'
      '    <span class="info-subtitle">الصفحة أو الرقم:</span>  401\n'
      '    <span class="info-subtitle">خلاصة حكم المحدث:</span>  <span >صحيح</span>\n'
      '</div>\n--------------\n<br/>\n'
      '<div class="hadith" style="text-align:justify;">2 -  <span class="search-keys">الأعمال</span> بالنيّات .</div>\n\n'
      '<div class="hadith-info">\n    <span class="info-subtitle">الراوي:</span> أبو سعيد الخدري</span>\n'
      '    <span class="info-subtitle">المحدث:</span> ابن عبدالبر\n'
      '    <span class="info-subtitle">المصدر:</span>  التمهيد\n'
      '    <span class="info-subtitle">الصفحة أو الرقم:</span>  21/270\n'
      '    <span class="info-subtitle">خلاصة حكم المحدث:</span>  <span >خطأ في إسناده</span>\n'
      '</div>\n--------------\n<br/>';

  test('parses hadith results from dorar api html', () {
    final results = DorarHtmlParser().parse(sample);

    expect(results.length, 2);

    final first = results[0];
    expect(first.text, contains('إنما'));
    expect(first.rawi, 'عمر بن الخطاب');
    expect(first.mohdith, 'الألباني');
    expect(first.book, 'غاية المرام');
    expect(first.pageNumber, '401');
    expect(first.grade, 'صحيح');
    expect(first.gradeStatus, HadithGradeStatus.sahih);

    final second = results[1];
    expect(second.rawi, 'أبو سعيد الخدري');
    expect(second.grade, contains('خطأ'));
    expect(second.gradeStatus, HadithGradeStatus.daeef);
  });

  test('returns empty list for empty html', () {
    expect(DorarHtmlParser().parse(''), isEmpty);
  });

  test('strips opening tag style and result numbering from text', () {
    const html =
        '<div class="hadith" style="text-align:justify;">3 - أُمِرْنا بصَومِ عاشوراءَ قبلَ أن يفرضَ رمضانُ .</div>\n'
        '<div class="hadith-info">\n    <span class="info-subtitle">الراوي:</span> عمر بن الخطاب</span>\n'
        '</div>';

    final result = DorarHtmlParser().parse(html).single;

    expect(result.text, startsWith('أُمِرْنا'));
    expect(result.text, isNot(contains('style=')));
    expect(RegExp(r'^\d').hasMatch(result.text), isFalse);
  });
}