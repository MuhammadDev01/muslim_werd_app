import 'package:flutter/material.dart';
import 'package:muslim_werd_app/core/constants.dart';
import 'package:muslim_werd_app/core/theming/assets.dart';
import 'package:muslim_werd_app/core/widgets/image_with_low_opacity_and_text.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  final List<String> imagesBoardingList = const [
    Assets.imagesMushaf,
    Assets.imagesMushaf,
    Assets.imagesMushaf,
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        allowImplicitScrolling: true,
        children: List.generate(
          3,
          (index) => ImageWithLowOpacityAndText(
            backgroundImage: imagesBoardingList[index],
            child: Text(
              'اقرأورتل القران ترتيبلا',

              style: TextStyle(
                fontSize: 30,
                color: Colors.white,
                fontFamily: fontAmiri,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
