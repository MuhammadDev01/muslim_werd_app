import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:muslim_werd_app/features/onboarding/ui/widgets/animated_bookmarks_item.dart';

class BookMarksListAnimated extends StatelessWidget {
  const BookMarksListAnimated({super.key, required this.bookmarkAnimation});
  final Animation bookmarkAnimation;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment(0, 0.55.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children:
            AnimatedBookmarkItem.colorsList.map((color) {
              return AnimatedBookmarkItem(
                bookmarkAnimation: bookmarkAnimation,
                color: color,
              );
            }).toList(),
      ),
    );
  }
}
