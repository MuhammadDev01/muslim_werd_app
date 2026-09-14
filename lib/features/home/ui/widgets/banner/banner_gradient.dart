import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:muslim_werd_app/features/home/logic/prayer_scene.dart';

/// خلفية البانر: Gradient أساسي + هالات "أورورا" ملوّنة تسبح بحركة دائرية
/// غير متزامنة وتعطي إحساسًا غير تقليدي (سائل/أثيري) فوق منظر المشهد.
class BannerGradient extends StatefulWidget {
  final PrayerScene scene;

  const BannerGradient({super.key, required this.scene});

  @override
  State<BannerGradient> createState() => _BannerGradientState();
}

class _BannerGradientState extends State<BannerGradient>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 9),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scene = widget.scene;

    return Stack(
      fit: StackFit.expand,
      children: [
        // القاعدة: سماء متدرّجة تنتقل بنعومة عند تغيير الصلاة
        AnimatedContainer(
          duration: const Duration(milliseconds: 1200),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: scene.background,
            ),
          ),
        ),

        // الأورورا: هالات متحركة فوق القاعدة
        AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return CustomPaint(
              painter: AuroraPainter(
                colors: [
                  scene.primary,
                  scene.sunColor,
                  scene.mosqueColor,
                ],
                t: _controller.value,
              ),
              child: const SizedBox.expand(),
            );
          },
        ),
      ],
    );
  }
}

class AuroraPainter extends CustomPainter {
  final List<Color> colors;
  final double t;

  const AuroraPainter({required this.colors, required this.t});

  @override
  void paint(Canvas canvas, Size size) {
    for (var i = 0; i < colors.length; i++) {
      final phase = i * 2 * math.pi / colors.length;

      final cx = (0.5 + 0.45 * math.sin(2 * math.pi * t + phase)) * size.width;
      final cy =
          (0.5 + 0.30 * math.cos(2 * math.pi * (t * .7) + phase)) *
          size.height;

      final radius =
          size.shortestSide *
          (0.60 + 0.25 * math.sin(2 * math.pi * t + phase * 2));

      final center = Offset(cx, cy);

      final paint =
          Paint()
            ..blendMode = BlendMode.softLight
            ..shader =
                RadialGradient(
                  colors: [
                    colors[i].withValues(alpha: .5),
                    colors[i].withValues(alpha: 0),
                  ],
                ).createShader(Rect.fromCircle(center: center, radius: radius));

      canvas.drawCircle(center, radius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant AuroraPainter oldDelegate) {
    return oldDelegate.t != t || oldDelegate.colors != colors;
  }
}