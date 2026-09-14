import 'package:flutter/material.dart';
import 'package:muslim_werd_app/core/theme/assets.dart';

class Eza3aImageWithAnimated extends StatelessWidget {
  const Eza3aImageWithAnimated({super.key, required this.animation});
  final Animation animation;
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder:
          (_, child) => Transform.translate(offset: Offset(0, 0), child: child),
      child: Image.asset(
        Assets.imagesEza3a,
        width: 600,
        // color: AppColors.tealWithOpacity,
      ),
    );
  }
}
