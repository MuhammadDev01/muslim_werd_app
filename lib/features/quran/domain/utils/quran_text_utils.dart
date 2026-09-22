/// أدوات مساعدة خاصة بالنصوص وقواعد السور في القرآن الكريم.
class QuranTextUtils {
  const QuranTextUtils._();

  /// الأرقام العربية المشرقية.
  static const String _arabicDigits = '٠١٢٣٤٥٦٧٨٩';

  /// سورة التوبة لا تُفتتح بالبسملة، والفاتحة تحوي بسملتها في أول آية.
  /// لذا لا نضيف بسملة رأس مستقلة لهما لتجنب التكرار.
  static const Set<int> _surahsWithoutHeaderBasmala = {1, 9};

  /// تحويل رقم إنجليزي إلى أرقام عربية مشرقية (مثل 12 -> ١٢).
  static String toArabicDigits(int number) {
    return number
        .toString()
        .split('')
        .map((c) => _arabicDigits[c.codeUnitAt(0) - 48])
        .join();
  }

  /// هل تظهر البسملة في ترويسة السورة المستقلة؟
  static bool hasHeaderBasmala(int surahNumber) {
    return !_surahsWithoutHeaderBasmala.contains(surahNumber);
  }
}
