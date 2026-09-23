import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:muslim_werd_app/core/theme/app_colors.dart';
import 'package:muslim_werd_app/core/theme/assets.dart';
import 'package:muslim_werd_app/core/widgets/app_background.dart';
import 'package:muslim_werd_app/features/eza3a/domain/models/eza3a_state.dart';
import 'package:muslim_werd_app/features/eza3a/presentation/cubit/eza3a_cubit.dart';
import 'package:muslim_werd_app/features/eza3a/presentation/widgets/broadcast_icon.dart';
import 'package:muslim_werd_app/features/eza3a/presentation/widgets/error_bar.dart';
import 'package:muslim_werd_app/features/eza3a/presentation/widgets/eza3a_error_guard.dart';
import 'package:muslim_werd_app/features/eza3a/presentation/widgets/glass_panel.dart';
import 'package:muslim_werd_app/features/eza3a/presentation/widgets/live_badge.dart';
import 'package:muslim_werd_app/features/eza3a/presentation/widgets/play_button.dart';
import 'package:muslim_werd_app/features/eza3a/presentation/widgets/realtime_waveform.dart';
import 'package:muslim_werd_app/features/eza3a/presentation/widgets/status_line.dart';
import 'package:muslim_werd_app/features/eza3a/presentation/widgets/volume_control_row.dart';

class Eza3aScreen extends StatelessWidget {
  const Eza3aScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => Eza3aCubit(),
      child: const Eza3aErrorGuard(child: _Eza3aBody()),
    );
  }
}

class _Eza3aBody extends StatelessWidget {
  const _Eza3aBody();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(title: const Text('القرآن الكريم إذاعة القاهرة')),
      body: SafeArea(
        child: Stack(
          children: [
            const AppBackground(),
            BlocBuilder<Eza3aCubit, Eza3aState>(
              builder: (context, state) {
                final isDark = Theme.of(context).brightness == Brightness.dark;
                final accent =
                    isDark ? AppColors.primaryLight : AppColors.primary;
                final active = state.isPlaying || state.isBuffering;
                final cubit = context.read<Eza3aCubit>();
                final busy = state.isBuffering;

                final (icon, tooltip) = switch (state.status) {
                  Eza3aStatus.playing => (Icons.stop_rounded, 'إيقاف البث'),
                  Eza3aStatus.error => (Icons.replay_rounded, 'إعادة تشغيل'),
                  Eza3aStatus.buffering => (
                    Icons.play_arrow_rounded,
                    'جارٍ تحميل البث…',
                  ),
                  _ => (Icons.play_arrow_rounded, 'بدء البث'),
                };

                return LayoutBuilder(
                  builder: (context, constraints) {
                    return SingleChildScrollView(
                      padding: const EdgeInsets.all(16),
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          minHeight: constraints.maxHeight - 24,
                        ),
                        child: IntrinsicHeight(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              LiveBadge(live: active, down: state.isDown),
                              Text(
                                'إذاعة القرآن الكريم من القاهرة',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: 'Amiri',
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  height: 1.35,
                                ),
                              ),

                              GlassPanel(
                                child: Column(
                                  children: [
                                    Gap(50),
                                    SizedBox(
                                      height: 150,
                                      child: Stack(
                                        fit: StackFit.expand,
                                        clipBehavior: Clip.antiAlias,
                                        children: [
                                          if (active)
                                            BroadcastIcon(
                                              active: true,
                                              size: 200,
                                              color: AppColors.primary,
                                            ),
                                          Image.asset(
                                            Assets.imagesRadio,
                                            fit: BoxFit.cover,
                                          ),
                                        ],
                                      ),
                                    ),

                                    if (state.status == Eza3aStatus.error) ...[
                                      const Gap(10),
                                      ErrorBar(
                                        errorMessage: state.errorMessage,
                                      ),
                                    ],
                                    Gap(50),

                                    RealtimeWaveform(
                                      isActive: active,
                                      volume: state.volume,
                                    ),
                                  ],
                                ),
                              ),
                              PlayButton(
                                accent: accent,
                                icon: icon,
                                busy: busy,
                                tooltip: tooltip,
                                onPressed:
                                    busy
                                        ? null
                                        : () {
                                          if (state.isPlaying) {
                                            cubit.stop();
                                          } else {
                                            cubit.play();
                                          }
                                        },
                              ),
                              StatusLine(status: state.status),
                              _audioController(state, cubit),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  GlassPanel _audioController(Eza3aState state, Eza3aCubit cubit) {
    return GlassPanel(
      child: VolumeControlRow(
        volume: state.volume,
        isMuted: state.isMuted,
        onMuteToggled: () => cubit.toggleMute(),
        onVolumeChanged: (v) => cubit.setVolume(v),
      ),
    );
  }
}
