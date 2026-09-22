import 'package:flutter/material.dart';
import 'package:muslim_werd_app/core/theme/app_colors.dart';

class TasbihScreen extends StatelessWidget {
  const TasbihScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('تسبيح'),
        backgroundColor: AppColors.deepRed,
      ),
      body: Center(
        child: Text('Tasbih', style: TextStyle(color: AppColors.white)),
      ),
    );
  }
}
