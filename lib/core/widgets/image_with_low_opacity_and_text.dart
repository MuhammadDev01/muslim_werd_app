import 'package:flutter/material.dart';

class BackgroundLowOpacityWithText extends StatelessWidget {
  const BackgroundLowOpacityWithText({
    super.key,
    required this.backgroundImage,
    required this.child,
  });
  final String backgroundImage;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.asset(
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
            backgroundImage,
          ),
        ),
        Container(
          alignment: Alignment.center,
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Colors.black54,
          ),
          child: child,
        ),
      ],
    );
  }
}
