import 'package:flutter/material.dart';
import 'package:muslim_werd_app/core/constants.dart';
import 'package:muslim_werd_app/features/ta7kk_7adeth/domain/models/hadith_ta7kk_result.dart';

class HadithGradeBadge extends StatelessWidget {
  const HadithGradeBadge({
    super.key,
    required this.status,
    required this.grade,
  });

  final HadithGradeStatus status;
  final String grade;

  @override
  Widget build(BuildContext context) {
    final (color, label) = switch (status) {
      HadithGradeStatus.sahih => (const Color(0xFF168A5B), 'صحيح'),
      HadithGradeStatus.hasan => (const Color(0xFF8A6D2F), 'حسن'),
      HadithGradeStatus.daeef => (const Color(0xFF8A4A2F), 'ضعيف'),
      HadithGradeStatus.other => (const Color(0xFF66736C), 'انظر الحكم'),
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: .05),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color, width: 1),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontFamily: fontCairo,
          fontSize: 13,
          fontWeight: FontWeight.bold,
          color: color,
        ),
      ),
    );
  }
}
