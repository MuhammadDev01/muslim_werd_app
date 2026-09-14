import 'package:flutter/material.dart';
import 'package:muslim_werd_app/core/theme/app_colors.dart';
import 'package:muslim_werd_app/core/theme/app_styles.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.onPressed,
    this.backgroundColor = AppColors.primary,
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
        padding: EdgeInsets.all(20),
        backgroundColor: backgroundColor,
        minimumSize: Size(width, height),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
        ),
      ),
      child: Text(
        textButton,
        style: TextStyles.cairo30Bold(context).copyWith(fontSize: 25),
      ),
    );
  }
}
