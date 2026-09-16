import 'package:flutter/material.dart';
import 'package:muslim_werd_app/core/theme/app_colors.dart';

class QuranScreen extends StatelessWidget {
  const QuranScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('القرآن الكريم'),
        backgroundColor: AppColors.deepBrick,
      ),
      body: Center(
        child: Text('Quran', style: TextStyle(color: AppColors.white)),
      ),
    );
  }
}
