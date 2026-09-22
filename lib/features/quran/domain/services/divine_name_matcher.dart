/// نوع الكلمة الدينية الملوّنة.
enum DivineKind { allah, rab }

/// نتيجة مطابقة لفظ الجلالة أو كلمة «ربّ» داخل النص الأصلي.
class DivineMatch {
  final int start;
  final int end;
  final DivineKind kind;

  const DivineMatch({
    required this.start,
    required this.end,
    required this.kind,
  });
}

/// خدمة Domain مسؤولة عن التعرف على لفظ الجلالة «الله» وكلمة «ربّ» مع ضمائرها
/// داخل النص القرآني مع تجريد علامات التشكيل وتوحيد الألف دون المساس بالنص الأصلي.
class DivineNameMatcher {
  const DivineNameMatcher._();

  /// نطاقات الرموز التي تُجرَّد عند المقارنة (حركات وتلاوين وتطويل).
  static const List<(int, int)> _tashkeelRanges = [
    (0x064B, 0x065F), // تنوين/فتحة/ضمة/كسرة/سكون/شدّة
    (0x0670, 0x0670), // ألف خنجرية
    (0x0674, 0x0674), // همزة عالية
    (0x0640, 0x0640), // تطويل
    (0x06D6, 0x06ED), // علامات ضبط قرآني
  ];

  /// أشكال الألف المختلفة تُوحَّد إلى ألف عادية للمقارنة.
  static const Set<int> _alefVariants = {0x0622, 0x0623, 0x0625, 0x0671};

  /// الضمائر المتصلة بكلمة (رَبّ) التي يجب تلوينها معها.
  static const Set<String> _rabSuffixes = {
    '', // رب مجرّدة
    'ي', // ربي
    'ك', // ربك
    'ه', // ربه
    'ها', // رَبَّها
    'نا', // ربنا
    'كم', // ربكم
    'كما', // رَبَّكما
    'كن', // ربكن
    'هم', // ربهم
    'هما', // رَبَّهما
    'هن', // ربهن
  };

  /// حروف العطف/الجر المفردة المسموح قبل «ربّ» (و، ف، ب، ل).
  static const String _rabParticles = 'وفبل';

  static bool _isTashkeelCodeUnit(int code) {
    for (final (start, end) in _tashkeelRanges) {
      if (code >= start && code <= end) return true;
    }
    return false;
  }

  /// يُرجع نطاقات لفظ الجلالة و«ربّ» مع ضميرها داخل [text] بمواضع النص الأصلي،
  /// مع تجريد الحركات للمطابقة والإبقاء على النص الأصلي كما هو.
  static List<DivineMatch> findMatches(String text) {
    if (text.isEmpty) return const [];

    // النص الكنوني (بدون حركات وألف موحّد) + خريطة موضع كل حرف أصلي.
    final canon = StringBuffer();
    final map = <int>[];
    for (var i = 0; i < text.length; i++) {
      final code = text.codeUnitAt(i);
      if (_isTashkeelCodeUnit(code)) continue;
      canon.writeCharCode(_alefVariants.contains(code) ? 0x0627 : code);
      map.add(i);
    }
    final canonical = canon.toString();

    // المطابقة بالكنوني: (بداية، نهاية، النوع)
    final matches = <(int, int, DivineKind)>[];

    // لفظ الجلالة: «الله» ورسمته المحذوفة الألف «لله».
    for (final target in const ['الله', 'لله']) {
      var from = 0;
      while (true) {
        final at = canonical.indexOf(target, from);
        if (at == -1) break;
        matches.add((at, at + target.length, DivineKind.allah));
        from = at + target.length;
      }
    }

    // «ربّ» + الضمير، والفحص داخل حدود الكلمة (بين الفراغات).
    var pos = 0;
    while (pos < canonical.length) {
      if (canonical[pos] == ' ') {
        pos++;
        continue;
      }
      final wordStart = pos;
      while (pos < canonical.length && canonical[pos] != ' ') {
        pos++;
      }
      final word = canonical.substring(wordStart, pos);
      for (var i = 0; i + 2 <= word.length; i++) {
        if (!word.startsWith('رب', i)) continue;
        // لا يجوز قبل «ربّ» غير بداية الكلمة أو حروف (و، ف، ب، ل).
        var prefixOk = true;
        for (var j = 0; j < i; j++) {
          if (!_rabParticles.contains(word[j])) {
            prefixOk = false;
            break;
          }
        }
        if (!prefixOk) continue;
        final suffix = word.substring(i + 2);
        if (!_rabSuffixes.contains(suffix)) continue;
        matches.add((
          wordStart + i,
          wordStart + i + 2 + suffix.length,
          DivineKind.rab,
        ));
      }
    }

    matches.sort((a, b) => a.$1.compareTo(b.$1));

    // تحويل النطاقات إلى مواضع النص الأصلي مع تجنّب التداخل.
    final result = <DivineMatch>[];
    var lastEnd = 0;
    for (final (cs, ce, kind) in matches) {
      final origStart = map[cs];
      final origEndExcl = map[ce - 1] + 1;
      if (origStart < lastEnd) continue;
      result.add(DivineMatch(start: origStart, end: origEndExcl, kind: kind));
      lastEnd = origEndExcl;
    }
    return result;
  }
}
