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
        child: Stack(
          alignment: Alignment.center,
          children: [
            for (var i = 0; i < 3; i++) _buildRing(i),
          ],
        ),
      ),
    );
  }

  Widget _buildRing(int i) {
    final phase = (_controller.value + i / 3) % 1.0;
    final animate = widget.active;
    final scale = animate ? ui.lerpDouble(0.92, 1.38, phase)! : 1.06;
    final opacity = animate ? 0.55 * (1 - phase) : 0.2;

    return Transform.scale(
      scale: scale,
      child: Container(
        width: widget.size,
        height: widget.size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: widget.color.withValues(alpha: opacity),
            width: 3,
          ),
          boxShadow: [
            BoxShadow(
              color: widget.color.withValues(alpha: opacity * 0.45),
              blurRadius: 14,
              spreadRadius: -1,
            ),
          ],
        ),
      ),
    );
  }
}