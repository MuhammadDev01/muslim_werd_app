import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:muslim_werd_app/core/theme/app_colors.dart';
import 'package:muslim_werd_app/core/widgets/app_background.dart';
import 'package:muslim_werd_app/features/eza3a/logic/eza3a_cubit.dart';
import 'package:muslim_werd_app/features/eza3a/ui/widgets/realtime_waveform.dart';

class Eza3aScreen extends StatelessWidget {
  const Eza3aScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (_) => Eza3aCubit(), child: const _Eza3aBody());
  }
}

class _Eza3aBody extends StatelessWidget {
  const _Eza3aBody();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('القرآن الكريم - إذاعة القاهرة')),
      body: SafeArea(
        child: Stack(
          children: [
            const AppBackground(),
            BlocBuilder<Eza3aCubit, Eza3aState>(
              builder: (context, state) {
                return _buildContent(context, state);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, Eza3aState state) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final playButtonColor = isDark ? AppColors.primaryLight : AppColors.primary;

    final active = state.isPlaying || state.isBuffering;

    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      children: [
        _buildLiveBadge(state),
        const Gap(12),
        _buildRadioIcon(playButtonColor, state),
        const Gap(12),
        const Text(
          'إذاعة القرآن الكريم من القاهرة',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Cairo',
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Gap(8),
        Text(
          state.isBuffering ? 'جارٍ تحميل البث…' : 'بث مباشر على مدار الساعة',
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontFamily: 'Cairo',
            color: AppColors.textSecondary,
          ),
        ),
        const Gap(12),
        RealtimeWaveform(isActive: active, volume: state.volume),
        const Gap(16),
        _buildStatusText(state),
        const Gap(12),
        _buildControls(context, state, playButtonColor),
        const Gap(12),
        _buildVolumeControls(context, state),
        if (state.status == Eza3aStatus.error) _buildErrorBar(state),
      ],
    );
  }

  Widget _buildLiveBadge(Eza3aState state) {
    final live = state.isPlaying || state.isBuffering;
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        decoration: BoxDecoration(
          color: live ? AppColors.primary : AppColors.deepGold,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: live ? AppColors.white : AppColors.textSecondary,
              ),
            ),
            const SizedBox(width: 6),
            const Text(
              'مباشر',
              style: TextStyle(
                fontFamily: 'Cairo',
                fontWeight: FontWeight.bold,
                color: AppColors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRadioIcon(Color color, Eza3aState state) {
    final active = state.isPlaying || state.isBuffering;
    return Center(
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors:
                active
                    ? [AppColors.primary, AppColors.primaryLight]
                    : [
                      AppColors.deepTeal,
                      AppColors.primaryLight.withValues(alpha: 0.6),
                    ],
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withValues(alpha: active ? 0.4 : 0.15),
              blurRadius: 30,
              spreadRadius: 2,
            ),
          ],
        ),
        child: const Icon(
          Icons.radio_rounded,
          size: 52,
          color: AppColors.white,
        ),
      ),
    );
  }

  Widget _buildStatusText(Eza3aState state) {
    final (text, color) = switch (state.status) {
      Eza3aStatus.playing => ('جاري البث الآن', AppColors.primary),
      Eza3aStatus.buffering => ('جارٍ تحميل البث…', AppColors.gold),
      Eza3aStatus.paused => ('البث متوقف مؤقتاً', AppColors.textSecondary),
      Eza3aStatus.error => ('فشل الاتصال بالبث', AppColors.deepBrick),
      _ => ('اضغط تشغيل لبدء البث', AppColors.textSecondary),
    };

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: Text(
        text,
        key: ValueKey(text),
        textAlign: TextAlign.center,
        style: TextStyle(
          fontFamily: 'Cairo',
          fontWeight: FontWeight.bold,
          color: color,
        ),
      ),
    );
  }

  Widget _buildControls(BuildContext context, Eza3aState state, Color color) {
    final cubit = context.read<Eza3aCubit>();
    final busy = state.isBuffering;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _ControlButton(
          icon: Icons.stop_rounded,
          tooltip: 'إيقاف البث',
          onPressed: busy ? null : () => cubit.stop(),
        ),
        const SizedBox(width: 40),
        SizedBox(
          width: 50,
          height: 50,
          child: FilledButton(
            style: FilledButton.styleFrom(
              shape: const CircleBorder(),
              backgroundColor: color,
              disabledBackgroundColor: AppColors.deepGold,
              padding: EdgeInsets.zero,
            ),
            onPressed: busy ? null : () => cubit.toggle(),
            child:
                busy
                    ? const SizedBox(
                      width: 32,
                      height: 32,
                      child: CircularProgressIndicator(
                        strokeWidth: 3,
                        color: AppColors.white,
                      ),
                    )
                    : Icon(
                      state.isPlaying
                          ? Icons.pause_rounded
                          : Icons.play_arrow_rounded,
                      size: 52,
                      color: AppColors.white,
                    ),
          ),
        ),
        const SizedBox(width: 40),
        _ControlButton(
          icon: Icons.replay_rounded,
          tooltip: 'إعادة تشغيل',
          onPressed: () => cubit.play(),
        ),
      ],
    );
  }

  Widget _buildVolumeControls(BuildContext context, Eza3aState state) {
    final cubit = context.read<Eza3aCubit>();
    return Row(
      children: [
        IconButton(
          onPressed: () => cubit.toggleMute(),
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
          child: Slider(
            value: state.volume,
            onChanged: (value) => cubit.setVolume(value),
            activeColor: AppColors.primary,
          ),
        ),
        SizedBox(
          width: 40,
          child: Text(
            '${(state.volume * 100).round()}٪',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontFamily: 'Cairo',
              color: AppColors.textSecondary,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildErrorBar(Eza3aState state) {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.deepBrick.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        state.errorMessage ?? 'حدث خطأ غير متوقع',
        textAlign: TextAlign.center,
        style: const TextStyle(fontFamily: 'Cairo', color: AppColors.deepBrick),
      ),
    );
  }
}

class _ControlButton extends StatelessWidget {
  const _ControlButton({
    required this.icon,
    required this.tooltip,
    required this.onPressed,
  });

  final IconData icon;
  final String tooltip;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton.filledTonal(
      onPressed: onPressed,
      icon: Icon(icon),
      iconSize: 30,
      tooltip: tooltip,
      style: IconButton.styleFrom(
        padding: const EdgeInsets.all(14),
        shape: const CircleBorder(),
      ),
    );
  }
}
