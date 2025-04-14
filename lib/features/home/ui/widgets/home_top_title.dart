import 'package:flutter/material.dart';
import 'package:muslim_werd_app/core/theming/styles.dart';

class HomeTopTitle extends StatelessWidget {
  const HomeTopTitle({super.key});
  @override
  Widget build(BuildContext context) {
    return Text(
      (DateTime.now().hour >= 5 && DateTime.now().hour < 17)
          ? 'أَصْبَحْنَا وَأَصْـبَـحَ الْمُـلْكُ لِلَّهِ'
          : 'أَمْسَيْـنا وَأَمْـسـى المُـلكُ لله',
      style: TextStyles.uthman24Bold(context),
    );
  }
}
