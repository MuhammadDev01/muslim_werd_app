import 'dart:ui' as ui;

import 'package:flutter/material.dart';

class BroadcastIcon extends StatefulWidget {
  const BroadcastIcon({
    super.key,
    required this.active,
    this.size = 150,
    this.color = Colors.white,
  });

  final bool active;
  final double size;
  final Color color;

  @override
  State<BroadcastIcon> createState() => _BroadcastIconState();
}

class _BroadcastIconState extends State<BroadcastIcon>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2400),
    );
    _syncAnimation();
  }

  @override
  void didUpdateWidget(BroadcastIcon oldWidget) {
    super.didUpdateWidget(oldWidget);
    _syncAnimation();
  }

  void _syncAnimation() {
    if (widget.active && !_controller.isAnimating) {
      _controller.repeat();
    } else if (!widget.active && _controller.isAnimating) {
      _controller.stop();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: widget.size * 1.4,
        height: widget.size * 1.4,
        child: RepaintBoundary(
          child: AnimatedBuilder(
            animation: _controller,
            builder:
                (context, _) => CustomPaint(
                  painter: _BroadcastRingsPainter(
                    progress: _controller.value,
                    active: widget.active,
                    size: widget.size,
                    color: widget.color,
                  ),
                ),
          ),
        ),
      ),
    );
  }
}

class _BroadcastRingsPainter extends CustomPainter {
  _BroadcastRingsPainter({
    required this.progress,
    required this.active,
    required this.size,
    required this.color,
  });

  final double progress;
  final bool active;
  final double size;
  final Color color;

  @override
  void paint(Canvas canvas, Size canvasSize) {
    final center = canvasSize.center(Offset.zero);
    const periodMs = 2000.0;
    const intervalMs = 1000.0;
    const lifeMs = 1680.0;

    final t = progress * periodMs;
    final oldest = t - lifeMs;
    final first = (oldest / intervalMs).floor();
    final last = (t / intervalMs).floor();

    for (var k = first; k <= last; k++) {
      final age = t - k * intervalMs;
      final f = age / lifeMs;
      final scale = ui.lerpDouble(0.1, 1.2, f)!;
      final radius = size / 2 * scale;
      final opacity = 0.4 * (1 - f);

      canvas.drawCircle(
        center,
        radius + 12,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 8
          ..color = color.withValues(alpha: opacity * 0.1),
      );
      canvas.drawCircle(
        center,
        radius,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 3
          ..color = color.withValues(alpha: opacity),
      );
    }
  }

  @override
  bool shouldRepaint(_BroadcastRingsPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.active != active ||
        oldDelegate.size != size ||
        oldDelegate.color != color;
  }
}
