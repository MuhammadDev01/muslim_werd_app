import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:muslim_werd_app/core/theming/styles.dart';

class HomeTopTitle extends StatelessWidget {
  const HomeTopTitle({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Align(
        alignment: Alignment.topCenter,
        child: Padding(
          padding: EdgeInsets.only(top: 30.sp),
          child: Text(title, style: TextStyles.amiri36Bold),
        ),
      ),
    );
  }
}
