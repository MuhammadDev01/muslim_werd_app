import 'package:muslim_werd_app/features/ta7kk_7adeth/domain/models/hadith_ta7kk_result.dart';

/// مسؤولية واحدة (SRP): تحويل رد HTML الخاص بموسوعة dorar إلى نماذج domain.
class DorarHtmlParser {
  List<HadithTa7kkResult> parse(String html) {
    final results = <HadithTa7kkResult>[];
    if (html.trim().isEmpty) return results;

    final hadithBlocks = html.split('<div class="hadith"');
    for (final block in hadithBlocks.skip(1)) {
      final text = _extractHadithText(block);
      if (text.isEmpty) continue;

      results.add(
        HadithTa7kkResult(
          text: text,
          rawi: _extractInfo(block, 'الراوي'),
          mohdith: _extractInfo(block, 'المحدث'),
          book: _extractInfo(block, 'المصدر'),
          pageNumber: _extractInfo(block, 'الصفحة أو الرقم'),
          grade: _extractInfo(block, 'خلاصة حكم المحدث'),
        ),
      );
    }
    return results;
  }

  String _extractHadithText(String block) {
    final infoIndex = block.indexOf('<div class="hadith-info"');
    final chunk = infoIndex == -1 ? block : block.substring(0, infoIndex);
    return _cleanHtml(chunk);
  }

  String _extractInfo(String block, String subtitle) {
    final pattern = RegExp(
      'info-subtitle">$subtitle:</span>\\s*(.*?)(?:</span|</div|\\n)',
    );
    final match = pattern.firstMatch(block);
    if (match == null) return '';
    return _cleanHtml(match.group(1) ?? '');
  }

  String _cleanHtml(String value) {
    return value
        .replaceAll(RegExp(r'<[^>]+>'), ' ')
        .replaceAll('&nbsp;', ' ')
        .replaceAll('&quot;', '"')
        .replaceAll('&amp;', '&')
        .replaceAll(RegExp(r'\s+'), ' ')
        .trim();
  }
}