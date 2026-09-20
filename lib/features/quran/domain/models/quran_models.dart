/// آية واحدة داخل سورة.
class QuranVerse {
  final int number;
  final String text;
  final int juz;
  final int page;
  final bool sajda;

  const QuranVerse({
    required this.number,
    required this.text,
    required this.juz,
    required this.page,
    required this.sajda,
  });

  factory QuranVerse.fromJson(Map<String, dynamic> json) {
    final text = json['text'] as Map? ?? const {};
    return QuranVerse(
      number: json['number'] as int? ?? 0,
      text: text['ar'] as String? ?? '',
      juz: json['juz'] as int? ?? 0,
      page: json['page'] as int? ?? 0,
      sajda: _parseSajda(json['sajda']),
    );
  }
}

/// سورة كاملة بآياتها.
class QuranSurah {
  final int number;
  final String nameAr;
  final String nameEn;
  final String transliteration;
  final String revelationPlace;
  final int versesCount;
  final List<QuranVerse> verses;

  const QuranSurah({
    required this.number,
    required this.nameAr,
    required this.nameEn,
    required this.transliteration,
    required this.revelationPlace,
    required this.versesCount,
    required this.verses,
  });

  factory QuranSurah.fromJson(Map<String, dynamic> json) {
    final name = json['name'] as Map? ?? const {};
    final revelation = json['revelation_place'] as Map? ?? const {};
    final verses = json['verses'] as List? ?? const [];
    return QuranSurah(
      number: json['number'] as int? ?? 0,
      nameAr: name['ar'] as String? ?? '',
      nameEn: name['en'] as String? ?? '',
      transliteration: name['transliteration'] as String? ?? '',
      revelationPlace: revelation['ar'] as String? ?? '',
      versesCount: json['verses_count'] as int? ?? verses.length,
      verses: verses
          .map((e) => QuranVerse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

/// نسخة مخففة من السورة تصلح لفهرس السور (بدون الآيات) لتقليل الذاكرة.
class QuranSurahSummary {
  final int number;
  final String nameAr;
  final String transliteration;
  final String revelationPlace;
  final int versesCount;

  const QuranSurahSummary({
    required this.number,
    required this.nameAr,
    required this.transliteration,
    required this.revelationPlace,
    required this.versesCount,
  });

  factory QuranSurahSummary.fromJson(Map<String, dynamic> json) {
    final name = json['name'] as Map? ?? const {};
    final revelation = json['revelation_place'] as Map? ?? const {};
    return QuranSurahSummary(
      number: json['number'] as int? ?? 0,
      nameAr: name['ar'] as String? ?? '',
      transliteration: name['transliteration'] as String? ?? '',
      revelationPlace: revelation['ar'] as String? ?? '',
      versesCount: json['verses_count'] as int? ?? 0,
    );
  }
}

/// يتعامل مع السجدة سواء كانت boolean قديمة أو object:
/// `false` / `true` / `{"id": 1, "recommended": true, "obligatory": false}`.
bool _parseSajda(dynamic value) {
  if (value == null) return false;
  if (value is bool) return value;
  if (value is Map) {
    final recommended = value['recommended'];
    final obligatory = value['obligatory'];
    if (recommended is bool && recommended) return true;
    if (obligatory is bool && obligatory) return true;
  }
  return false;
}