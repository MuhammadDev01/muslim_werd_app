import 'package:flutter/material.dart';
import 'package:muslim_werd_app/core/theme/app_colors.dart';

class Stars extends StatelessWidget {
  const Stars({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: List.generate(12, (index) {
        final positions = [
          const Offset(40, 55),
          const Offset(110, 90),
          const Offset(190, 45),
          const Offset(280, 80),
          const Offset(330, 50),
          const Offset(70, 145),
          const Offset(250, 130),
          const Offset(150, 120),
          const Offset(350, 150),
          const Offset(220, 100),
          const Offset(30, 180),
          const Offset(300, 180),
        ];

        return Positioned(
          left: positions[index].dx,
          top: positions[index].dy,
          child: const Icon(Icons.star, size: 5, color: AppColors.white70),
        );
      }),
    );
  }
}
