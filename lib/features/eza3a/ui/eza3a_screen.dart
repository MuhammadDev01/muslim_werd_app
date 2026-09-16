import 'package:flutter/material.dart';

class Eza3aScreen extends StatelessWidget {
  const Eza3aScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('إذاعة القران الكريم من القاهرة'),
      ),
      body: Center(child: Text('Eza3a')),
    );
  }
}
