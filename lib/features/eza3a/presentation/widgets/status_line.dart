import 'package:flutter/material.dart';
import 'package:muslim_werd_app/core/theme/app_colors.dart';
import 'package:muslim_werd_app/features/eza3a/domain/models/eza3a_state.dart';

class StatusLine extends StatelessWidget {
  const StatusLine({super.key, required this.status});

  final String status;

  @override
  Widget build(BuildContext context) {
    final (text, color) = switch (status) {
      Eza3aStatus.playing => ('جاري البث الآن', AppColors.primary),
      Eza3aStatus.buffering => ('جارٍ تحميل البث…', AppColors.gold),
      Eza3aStatus.paused => ('البث متوقف مؤقتاً', AppColors.textSecondary),
      Eza3aStatus.error => ('فشل الاتصال بالبث', AppColors.deepBrick),
      _ => ('اضغط تشغيل لبدء البث', AppColors.textSecondary),
    };

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      transitionBuilder:
          (child, anim) => FadeTransition(opacity: anim, child: child),
      child: Text(
        text,
        key: ValueKey(text),
        style: TextStyle(
          fontFamily: 'Cairo',
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: color,
        ),
      ),
    );
  }
}
