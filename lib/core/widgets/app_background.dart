import 'package:flutter/material.dart';
import 'package:muslim_werd_app/core/theme/app_colors.dart';

/// خلفية التطبيق: تدرّج مؤلّف غير تقليدي بدل اللون الأبيض المسطح.
///
/// قاعدة خطّية ضبابية + ثلاث توهّجات إشعاعية متداخلة (أخضر/كريمي/أساسي)
/// موزّعة بزوايا مختلفة لتعطي عمقًا وإحساسًا أثيريًا هادئًا.
class AppBackground extends StatelessWidget {
  final Widget child;

  const AppBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: const [
            AppColors.softGreen,
            AppColors.background,
            AppColors.cream,
          ],
          stops: const [0.0, 0.55, 1.0],
        ),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          const IgnorePointer(child: _MistBlend()),

          child,
        ],
      ),
    );
  }
}

class _MistBlend extends StatelessWidget {
  const _MistBlend();

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _MistPainter(),
      child: const SizedBox.expand(),
    );
  }
}

class _MistPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;

    // توهّج أخضر من الزاوية الشمالية
    canvas.drawRect(
      rect,
      Paint()
        ..shader =
            RadialGradient(
              center: Alignment.topLeft,
              radius: 1.5,
              colors: [
                AppColors.secondary.withValues(alpha: .45),
                AppColors.secondary.withValues(alpha: 0),
              ],
            ).createShader(rect),
    );

    // توهّج كريمي من الزاوية الجنوبية
    canvas.drawRect(
      rect,
      Paint()
        ..shader =
            RadialGradient(
              center: Alignment.bottomRight,
              radius: 1.6,
              colors: [
                AppColors.softGold.withValues(alpha: .35),
                AppColors.softGold.withValues(alpha: 0),
              ],
            ).createShader(rect),
    );

    // لمعة أساسية ناعمة من مركز علوي
    canvas.drawRect(
      rect,
      Paint()
        ..shader =
            RadialGradient(
              center: const Alignment(0.35, -0.45),
              radius: 1.2,
              colors: [
                AppColors.primary.withValues(alpha: .10),
                AppColors.primary.withValues(alpha: 0),
              ],
            ).createShader(rect),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}