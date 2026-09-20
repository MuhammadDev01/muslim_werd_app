enum HadithGradeStatus { sahih, hasan, daeef, other }

class HadithTa7kkResult {
  final String text;
  final String rawi;
  final String mohdith;
  final String book;
  final String pageNumber;
  final String grade;

  const HadithTa7kkResult({
    required this.text,
    required this.rawi,
    required this.mohdith,
    required this.book,
    required this.pageNumber,
    required this.grade,
  });

  HadithGradeStatus get gradeStatus {
    if (grade.contains('صحيح')) return HadithGradeStatus.sahih;
    if (grade.contains('حسن')) return HadithGradeStatus.hasan;
    if (grade.contains('ضعيف') ||
        grade.contains('منكر') ||
        grade.contains('باطل') ||
        grade.contains('خطأ') ||
        grade.contains('لا يصح')) {
      return HadithGradeStatus.daeef;
    }
    return HadithGradeStatus.other;
  }
}