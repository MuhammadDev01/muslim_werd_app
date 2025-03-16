import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:muslim_werd_app/core/constants.dart';
import 'package:muslim_werd_app/core/helper/extention.dart';
import 'package:muslim_werd_app/core/routing/routes.dart';
import 'package:muslim_werd_app/core/theming/assets.dart';
import 'package:muslim_werd_app/core/theming/colors.dart';
import 'package:muslim_werd_app/core/theming/styles.dart';
import 'package:muslim_werd_app/core/widgets/custom_button.dart';

class OnboardingFirstScreen extends StatefulWidget {
  const OnboardingFirstScreen({super.key});

  @override
  State<OnboardingFirstScreen> createState() => _OnboardingFirstScreenState();
}

late AnimationController _controller;

class _OnboardingFirstScreenState extends State<OnboardingFirstScreen>
    with TickerProviderStateMixin {
  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,

      duration: Duration(seconds: 10),
    )..repeat();

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final widthScreen = MediaQuery.sizeOf(context).width;
    final heightScreen = MediaQuery.sizeOf(context).height;
    return Container(
      color: ColorsManager.blackWithOpacity,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Image.asset(
            Assets.imagesAlquranAlkareem,
            width: widthScreen * 0.45,
            height: heightScreen * 0.45,
          ),
          AnimatedBuilder(
            animation: _controller,
            builder:
                (context, child) => Transform.rotate(
                  angle:
                      _controller.value * 2 * 3.1416, // تحويل القيمة إلى زاوية
                  child: child,
                ),
            child: Image.asset(
              Assets.imagesOnboardingCircleDesign,
              width: widthScreen * 0.8,
              height: heightScreen * 0.8,
            ),
          ),
          Positioned(top: -300.h, child: Image.asset(Assets.imagesEllipse)),
          Positioned(
            top: 200.h,
            child: Text(
              'اقرأ في أي مكان ',
              style: TextStyles.amiri36Bold.copyWith(fontFamily: fontCairo),
            ),
          ),
          Positioned(
            bottom: 200.h,
            child: Text(
              'اقرأ وردك ف اي وقت بدون انترنت ',
              style: TextStyles.cairo30Bold,
            ),
          ),
          Positioned(
            bottom: 50.h,
            child: CustomButton(
              child: Text('استمرار', style: TextStyles.cairo30Bold),
              onPressed: () {
                context.pushNamed(SubRoutes.onboardingSecondScreen);
              },
            ),
          ),
        ],
      ),
    );
  }
}
