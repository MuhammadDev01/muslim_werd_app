import 'dart:async' show TimeoutException;
import 'dart:io' show IOException;
import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show PlatformException;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart' show PlayerException;
import 'package:muslim_werd_app/core/theme/app_colors.dart';
import 'package:muslim_werd_app/core/widgets/app_background.dart';
import 'package:muslim_werd_app/features/eza3a/logic/eza3a_cubit.dart';
import 'package:muslim_werd_app/features/eza3a/ui/widgets/realtime_waveform.dart';

class Eza3aScreen extends StatelessWidget {
  const Eza3aScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => Eza3aCubit(),
      child: const _Eza3aErrorGuard(child: _Eza3aBody()),
    );
  }
}

class _Eza3aErrorGuard extends StatefulWidget {
  const _Eza3aErrorGuard({required this.child});

  final Widget child;

  @override
  State<_Eza3aErrorGuard> createState() => _Eza3aErrorGuardState();
}

class _Eza3aErrorGuardState extends State<_Eza3aErrorGuard> {
  void Function(FlutterErrorDetails)? _previous;

  @override
  void initState() {
    super.initState();
    _previous = FlutterError.onError;
    FlutterError.onError = _filteredOnError;
  }

  void _filteredOnError(FlutterErrorDetails details) {
    if (_isStreamNoise(details.exception)) return;
    _previous?.call(details);
  }

  static bool _isStreamNoise(Object error) {
    if (error is PlayerException) return true;
    if (error is IOException) return true;
    if (error is TimeoutException) return true;
    if (error is PlatformException) {
      const noisyCodes = {'0', '10000000', '100000001'};
      final message = error.message;
      return noisyCodes.contains(error.code) ||
          (message != null &&
              (message.contains('Source error') ||
                  message.contains('Connection aborted')));
    }
    return false;
  }

  @override
  void dispose() {
    FlutterError.onError = _previous;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.child;
}

class _Eza3aBody extends StatelessWidget {
  const _Eza3aBody();

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        centerTitle: true,
        title: const Text(
          'إذاعة القرآن الكريم',
          style: TextStyle(
            fontFamily: 'Cairo',
            fontSize: 19,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            const AppBackground(),
            Positioned.fill(
              child: IgnorePointer(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: RadialGradient(
                      center: const Alignment(0, -0.6),
                      radius: 1.3,
                      colors: [
                        AppColors.transparent,
                        AppColors.primary.withValues(
                          alpha: isDark ? 0.28 : 0.12,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            BlocBuilder<Eza3aCubit, Eza3aState>(
              builder: (context, state) => _buildContent(context, state),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, Eza3aState state) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final accent = isDark ? AppColors.primaryLight : AppColors.primary;
    final active = state.isPlaying || state.isBuffering;

    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight - 24),
            child: IntrinsicHeight(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _LiveBadge(live: active, down: state.isDown),
                  ..._buildHero(active, accent, state),
                  _GlassPanel(
                    child: Column(
                      children: [
                        RealtimeWaveform(isActive: active, volume: state.volume),
                        const SizedBox(height: 14),
                        _StatusLine(state),
                        if (state.status == Eza3aStatus.error) ...[
                          const SizedBox(height: 10),
                          _ErrorBar(state),
                        ],
                      ],
                    ),
                  ),
                  _buildControls(context, state, accent),
                  _GlassPanel(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 6,
                    ),
                    child: _buildVolumeRow(context, state),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  List<Widget> _buildHero(bool active, Color accent, Eza3aState state) {
    final subtitle = switch (state.status) {
      Eza3aStatus.buffering => 'جارٍ تحميل البث…',
      Eza3aStatus.error => 'انقطع البث',
      _ => 'بث مباشر على مدار الساعة',
    };
    return [
      _BroadcastIcon(active: active, color: accent),
      const SizedBox(height: 18),
      const Text(
        'إذاعة القرآن الكريم من القاهرة',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontFamily: 'Amiri',
          fontSize: 28,
          fontWeight: FontWeight.bold,
          height: 1.35,
        ),
      ),
      const SizedBox(height: 6),
      Text(
        subtitle,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontFamily: 'Cairo',
          fontSize: 15,
          color: AppColors.textSecondary,
        ),
      ),
    ];
  }

  Widget _buildControls(BuildContext context, Eza3aState state, Color accent) {
    final cubit = context.read<Eza3aCubit>();
    final busy = state.isBuffering;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _GlassIconButton(
          icon: Icons.stop_rounded,
          tooltip: 'إيقاف البث',
          enabled: !busy && !state.isDown,
          onPressed: () => cubit.stop(),
        ),
        const SizedBox(width: 34),
        _PlayButton(
          accent: accent,
          isPlaying: state.isPlaying,
          busy: busy,
          onPressed: busy ? null : () => cubit.toggle(),
        ),
        const SizedBox(width: 34),
        _GlassIconButton(
          icon: Icons.replay_rounded,
          tooltip: 'إعادة تشغيل',
          enabled: true,
          onPressed: () => cubit.play(),
        ),
      ],
    );
  }

  Widget _buildVolumeRow(BuildContext context, Eza3aState state) {
    final cubit = context.read<Eza3aCubit>();
    return Row(
      children: [
        IconButton(
          onPressed: () => cubit.toggleMute(),
          tooltip: state.isMuted ? 'رفع الصوت' : 'كتم الصوت',
          icon: Icon(
            state.isMuted || state.volume == 0
                ? Icons.volume_off_rounded
                : state.volume < 0.5
                ? Icons.volume_down_rounded
                : Icons.volume_up_rounded,
            color: AppColors.primary,
          ),
        ),
        Expanded(
          child: SliderTheme(
            data: SliderTheme.of(context).copyWith(
              activeTrackColor: AppColors.primary,
              inactiveTrackColor: AppColors.primary.withValues(alpha: 0.18),
              thumbColor: AppColors.primary,
              overlayColor: AppColors.primary.withValues(alpha: 0.12),
              trackHeight: 4,
              thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 8),
              overlayShape: const RoundSliderOverlayShape(overlayRadius: 18),
            ),
            child: Slider(
              value: state.volume,
              onChanged: (value) => cubit.setVolume(value),
            ),
          ),
        ),
        SizedBox(
          width: 44,
          child: Text(
            '${(state.volume * 100).round()}٪',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontFamily: 'Cairo',
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: AppColors.textSecondary,
            ),
          ),
        ),
      ],
    );
  }
}

class _StatusLine extends StatelessWidget {
  const _StatusLine(this.state);

  final Eza3aState state;

  @override
  Widget build(BuildContext context) {
    final (text, color) = switch (state.status) {
      Eza3aStatus.playing => ('جاري البث الآن', AppColors.primary),
      Eza3aStatus.buffering => ('جارٍ تحميل البث…', AppColors.gold),
      Eza3aStatus.paused => ('البث متوقف مؤقتاً', AppColors.textSecondary),
      Eza3aStatus.error => ('فشل الاتصال بالبث', AppColors.deepBrick),
      _ => ('اضغط تشغيل لبدء البث', AppColors.textSecondary),
    };

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      transitionBuilder: (child, anim) =>
          FadeTransition(opacity: anim, child: child),
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

class _ErrorBar extends StatelessWidget {
  const _ErrorBar(this.state);

  final Eza3aState state;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.deepBrick.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.deepBrick.withValues(alpha: 0.35)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.wifi_off_rounded,
            size: 18,
            color: AppColors.deepBrick,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              state.errorMessage ?? 'حدث خطأ غير متوقع',
              style: const TextStyle(
                fontFamily: 'Cairo',
                fontSize: 12.5,
                color: AppColors.deepBrick,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _LiveBadge extends StatelessWidget {
  const _LiveBadge({required this.live, this.down = false});

  final bool live;
  final bool down;

  @override
  Widget build(BuildContext context) {
    final (gradient, glow, dotColor, pulse) = switch ((live, down)) {
      (_, true) => (
          const [AppColors.errorRed, Color(0xFFC62828)],
          AppColors.errorRed,
          AppColors.errorRed,
          true,
        ),
      (true, false) => (
          const [AppColors.primary, AppColors.primaryLight],
          AppColors.primary,
          AppColors.white,
          true,
        ),
      _ => (
          const [AppColors.deepGold, AppColors.deepGold],
          AppColors.deepGold,
          AppColors.white,
          false,
        ),
    };

    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: gradient),
          borderRadius: BorderRadius.circular(40),
          boxShadow: [
            BoxShadow(
              color: glow.withValues(
                alpha: down ? 0.4 : live ? 0.35 : 0.12,
              ),
              blurRadius: 18,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _PulsingDot(enabled: pulse, color: dotColor),
            const SizedBox(width: 8),
            const Text(
              'مباشر',
              style: TextStyle(
                fontFamily: 'Cairo',
                fontWeight: FontWeight.bold,
                fontSize: 13,
                color: AppColors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PulsingDot extends StatefulWidget {
  const _PulsingDot({required this.enabled, required this.color});

  final bool enabled;
  final Color color;

  @override
  State<_PulsingDot> createState() => _PulsingDotState();
}

class _PulsingDotState extends State<_PulsingDot>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1100),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        final t = _controller.value;
        final pulse = 0.35 + 0.65 * math.sin(t * math.pi);
        final glow = widget.enabled ? pulse : 0.15;
        return Container(
          width: 9,
          height: 9,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: widget.color.withValues(alpha: 0.4 + 0.6 * pulse),
            boxShadow: [
              BoxShadow(
                color: widget.color.withValues(alpha: glow),
                blurRadius: 8,
                spreadRadius: 1,
              ),
            ],
          ),
        );
      },
    );
  }
}

class _BroadcastIcon extends StatefulWidget {
  const _BroadcastIcon({required this.active, required this.color});

  final bool active;
  final Color color;

  @override
  State<_BroadcastIcon> createState() => _BroadcastIconState();
}

class _BroadcastIconState extends State<_BroadcastIcon>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2600),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      height: 200,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, _) {
          return Stack(
            alignment: Alignment.center,
            children: [
              for (var i = 0; i < 3; i++)
                _buildRing(i),
              _buildCore(),
            ],
          );
        },
      ),
    );
  }

  Widget _buildRing(int i) {
    final t = _controller.value;
    final phase = (t + i / 3) % 1.0;
    final scale = widget.active ? ui.lerpDouble(0.95, 1.7, phase)! : 1.08;
    final opacity = widget.active ? (1 - phase) * 0.55 : 0.05;

    return Transform.scale(
      scale: scale,
      child: Container(
        width: 112,
        height: 112,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: widget.color.withValues(alpha: opacity),
            width: 2,
          ),
        ),
      ),
    );
  }

  Widget _buildCore() {
    return Container(
      width: 124,
      height: 124,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: widget.active
              ? [AppColors.primary, AppColors.primaryLight]
              : [AppColors.deepTeal, AppColors.primaryLight.withValues(alpha: 0.55)],
        ),
        border: Border.all(color: AppColors.white.withValues(alpha: 0.35)),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: widget.active ? 0.45 : 0.15),
            blurRadius: 34,
            spreadRadius: 4,
          ),
        ],
      ),
      child: const Icon(
        Icons.radio_rounded,
        size: 56,
        color: AppColors.white,
      ),
    );
  }
}

class _GlassPanel extends StatelessWidget {
  const _GlassPanel({
    required this.child,
    this.padding = const EdgeInsets.all(18),
  });

  final Widget child;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return ClipRRect(
      borderRadius: BorderRadius.circular(26),
      child: BackdropFilter(
        filter: ui.ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          padding: padding,
          decoration: BoxDecoration(
            color: isDark
                ? AppColors.darkSurface.withValues(alpha: 0.42)
                : AppColors.white.withValues(alpha: 0.5),
            borderRadius: BorderRadius.circular(26),
            border: Border.all(
              color: isDark
                  ? AppColors.white.withValues(alpha: 0.12)
                  : AppColors.white.withValues(alpha: 0.7),
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.black.withValues(alpha: 0.06),
                blurRadius: 22,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: child,
        ),
      ),
    );
  }
}

class _PlayButton extends StatelessWidget {
  const _PlayButton({
    required this.accent,
    required this.isPlaying,
    required this.busy,
    this.onPressed,
  });

  final Color accent;
  final bool isPlaying;
  final bool busy;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        width: 104,
        height: 104,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: busy
                ? [AppColors.deepGold, AppColors.deepGold]
                : [accent, AppColors.primaryLight],
          ),
          border: Border.all(color: AppColors.white.withValues(alpha: 0.4)),
          boxShadow: [
            BoxShadow(
              color: accent.withValues(alpha: busy ? 0.1 : 0.45),
              blurRadius: 30,
              spreadRadius: 3,
            ),
          ],
        ),
        child: Center(
          child: busy
              ? const SizedBox(
                  width: 34,
                  height: 34,
                  child: CircularProgressIndicator(
                    strokeWidth: 3,
                    color: AppColors.white,
                  ),
                )
              : AnimatedSwitcher(
                  duration: const Duration(milliseconds: 250),
                  transitionBuilder: (child, anim) =>
                      ScaleTransition(scale: anim, child: child),
                  child: Icon(
                    isPlaying
                        ? Icons.pause_rounded
                        : Icons.play_arrow_rounded,
                    key: ValueKey(isPlaying),
                    size: 58,
                    color: AppColors.white,
                  ),
                ),
        ),
      ),
    );
  }
}

class _GlassIconButton extends StatelessWidget {
  const _GlassIconButton({
    required this.icon,
    required this.tooltip,
    required this.onPressed,
    this.enabled = true,
  });

  final IconData icon;
  final String tooltip;
  final VoidCallback? onPressed;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final color = enabled
        ? (isDark ? AppColors.primaryLight : AppColors.primary)
        : AppColors.textSecondary;

    return Tooltip(
      message: tooltip,
      child: Container(
        width: 58,
        height: 58,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isDark
              ? AppColors.darkSurface.withValues(alpha: 0.5)
              : AppColors.white.withValues(alpha: 0.55),
          border: Border.all(
            color: isDark
                ? AppColors.white.withValues(alpha: 0.14)
                : AppColors.white.withValues(alpha: 0.75),
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withValues(alpha: 0.05),
              blurRadius: 14,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: IconButton(
          onPressed: enabled ? onPressed : null,
          icon: Icon(icon, color: color, size: 28),
          tooltip: tooltip,
        ),
      ),
    );
  }
}