import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:muslim_werd_app/core/theming/colors.dart';
import 'package:muslim_werd_app/core/theming/styles.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.onPressed,
    this.backgroundColor = ColorsManager.tealWithOpacity,
    this.height = 60,
    this.width = 20,
    this.radius = 12,
    required this.textButton,
  });
  final void Function() onPressed;
  final Color backgroundColor;
  final double height;
  final double width;
  final double radius;
  final String textButton;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.all(20.r),
        backgroundColor: backgroundColor,
        minimumSize: Size(width.w, height.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius.r),
        ),
      ),
      child: Text(textButton, style: TextStyles.cairo30Bold.copyWith(fontSize: 25.sp)),
    );
  }
}
