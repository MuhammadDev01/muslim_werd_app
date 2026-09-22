import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:muslim_werd_app/core/theme/app_colors.dart';

class RealtimeWaveform extends StatefulWidget {
  const RealtimeWaveform({
    super.key,
    required this.isActive,
    required this.volume,
    this.barCount = 40,
    this.height = 110,
  });

  final bool isActive;
  final double volume;
  final int barCount;
  final double height;

  @override
  State<RealtimeWaveform> createState() => _RealtimeWaveformState();
}

class _RealtimeWaveformState extends State<RealtimeWaveform>
    with SingleTickerProviderStateMixin {
  Ticker? _ticker;
  Duration _playhead = Duration.zero;
  Duration _lastFrame = Duration.zero;

  @override
  void initState() {
    super.initState();
    _ticker = createTicker(_onTick)..start();
  }

  void _onTick(Duration elapsed) {
    if (widget.isActive) {
      _playhead += elapsed - _lastFrame;
    } else {
      _playhead = Duration.zero;
    }
    _lastFrame = elapsed;
    setState(() {});
  }

  @override
  void dispose() {
    _ticker?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      width: double.infinity,
      child: CustomPaint(
        painter: _WaveformPainter(
          seedMs: widget.isActive ? _playhead.inMilliseconds : null,
          active: widget.isActive,
          volume: widget.volume,
          barCount: widget.barCount,
        ),
      ),
    );
  }
}

class _WaveformPainter extends CustomPainter {
  const _WaveformPainter({
    required this.seedMs,
    required this.active,
    required this.volume,
    required this.barCount,
  });

  final int? seedMs;
  final bool active;
  final double volume;
  final int barCount;

  @override
  void paint(Canvas canvas, Size size) {
    final barW = size.width / barCount;
    final gap = barW * 0.28;
    final w = barW - gap;
    final radius = Radius.circular(w / 2);
    final midH = size.height * 0.5;
    final amp = active ? 0.35 + 0.65 * volume : 0.06;

    for (var i = 0; i < barCount; i++) {
      final value = _value(i);
      final h = (size.height * 0.92 * value * amp).clamp(
        4.0,
        size.height * 0.92,
      );
      final rect = Rect.fromLTWH(i * barW + gap / 2, midH - h / 2, w, h);
      final rrect = RRect.fromRectAndRadius(rect, radius);

      final shader = LinearGradient(
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
        colors:
            active
                ? [AppColors.primary, AppColors.primaryLight]
                : [
                  AppColors.deepTeal.withValues(alpha: 0.45),
                  AppColors.deepTeal.withValues(alpha: 0.15),
                ],
      ).createShader(rect);

      final paint =
          Paint()
            ..shader = shader
            ..isAntiAlias = true;
      canvas.drawRRect(rrect, paint);
    }
  }

  double _value(int i) {
    final seed = seedMs ?? 0;
    final t = seed * 0.012;
    var v =
        0.5 +
        0.5 * math.sin(t * 0.5 + i * 0.8) +
        0.25 * math.sin(t * 1.13 + i * 1.7) +
        0.2 * math.sin(t * 2.71 + i * 0.21) +
        0.12 * math.sin(t * 5.0 + i * 3.7);
    v = v / 2.07;
    return v.clamp(0.0, 1.0);
  }

  @override
  bool shouldRepaint(covariant _WaveformPainter oldDelegate) {
    return oldDelegate.seedMs != seedMs ||
        oldDelegate.active != active ||
        oldDelegate.volume != volume ||
        oldDelegate.barCount != barCount;
  }
}
