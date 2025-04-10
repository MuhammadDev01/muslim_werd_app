import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AnimatedBookmarkItem extends StatelessWidget {
  const AnimatedBookmarkItem({
    super.key,
    required this.color,
    required this.bookmarkAnimation,
  });

  final Animation bookmarkAnimation;
  final Color color;
  static List<Color> colorsList = const [
    Colors.deepOrange,
    Colors.blue,
    Colors.white,
    Colors.purple,
    Colors.indigo,
    Colors.teal,
  ];
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: bookmarkAnimation,
    
      builder:
          (_, child) => Opacity(opacity: bookmarkAnimation.value, child: child),
    
      child: Image.asset(
        'assets/images/bookmark.png',
        width: 70.w,
        color: color,
      ),
    );
  }
}
