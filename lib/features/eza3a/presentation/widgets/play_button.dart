import 'package:flutter/material.dart';
import 'package:muslim_werd_app/core/theme/app_colors.dart';

class PlayButton extends StatelessWidget {
  const PlayButton({
    super.key,
    required this.accent,
    required this.icon,
    required this.busy,
    required this.tooltip,
    this.onPressed,
  });

  final Color accent;
  final IconData icon;
  final bool busy;
  final String tooltip;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Tooltip(
        message: tooltip,
        child: GestureDetector(
          onTap: onPressed,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors:
                    busy
                        ? [AppColors.deepRed, AppColors.deepRed]
                        : [accent, AppColors.primaryLight],
              ),
              border: Border.all(color: AppColors.white.withValues(alpha: 0.4)),
              boxShadow: [
                BoxShadow(
                  color: accent.withValues(alpha: busy ? 0.1 : 0.3),
                  blurRadius: 30,
                  spreadRadius: 3,
                ),
              ],
            ),
            child: Center(
              child:
                  busy
                      ? CircularProgressIndicator(color: AppColors.white)
                      : AnimatedSwitcher(
                        duration: const Duration(milliseconds: 250),
                        transitionBuilder:
                            (child, anim) =>
                                ScaleTransition(scale: anim, child: child),
                        child: Icon(
                          icon,
                          key: ValueKey(icon),
                          size: 45,
                          color: AppColors.white,
                        ),
                      ),
            ),
          ),
        ),
      ),
    );
  }
}
