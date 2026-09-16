import 'package:flutter/material.dart';
import 'package:muslim_werd_app/core/theme/app_colors.dart';

class AzkarScreen extends StatelessWidget {
  const AzkarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('أذكار الصباح والمساء'),
        backgroundColor: AppColors.deepForest,
      ),
      body: Center(
        child: Text('AZkar', style: TextStyle(color: AppColors.white)),
      ),
    );
  }
}
