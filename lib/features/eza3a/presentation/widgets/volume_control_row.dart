import 'package:flutter/material.dart';
import 'package:muslim_werd_app/core/theme/app_colors.dart';

class VolumeControlRow extends StatelessWidget {
  const VolumeControlRow({
    super.key,
    required this.volume,
    required this.isMuted,
    required this.onMuteToggled,
    required this.onVolumeChanged,
  });

  final double volume;
  final bool isMuted;
  final VoidCallback onMuteToggled;
  final ValueChanged<double> onVolumeChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: onMuteToggled,
          tooltip: isMuted ? 'رفع الصوت' : 'كتم الصوت',
          icon: Icon(
            isMuted || volume == 0
                ? Icons.volume_off_rounded
                : volume < 0.5
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
            child: Slider(value: volume, onChanged: onVolumeChanged),
          ),
        ),
        SizedBox(
          width: 44,
          child: Text(
            '${(volume * 100).round()}٪',
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
