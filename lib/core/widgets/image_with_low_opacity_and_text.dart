import 'package:flutter/material.dart';

class ImageWithLowOpacityAndText extends StatelessWidget {
  const ImageWithLowOpacityAndText({
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
        Image.asset(
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.cover,
          backgroundImage,
        ),
        Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.black54,
          child: child,
        ),
      ],
    );
  }
}
