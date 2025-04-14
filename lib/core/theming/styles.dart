import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:muslim_werd_app/core/constants.dart';

class TextStyles {
  static TextStyle amiri24Bold(BuildContext context) => TextStyle(
    fontSize: getResponsiveFontSize(context, fontSize: 24),
    color: Colors.white,
    fontFamily: fontAmiri,
    fontWeight: FontWeight.bold,
  );

  static TextStyle cairo30Bold(BuildContext context) => TextStyle(
    fontSize: getResponsiveFontSize(context, fontSize: 30),
    color: Colors.white,
    fontFamily: fontCairo,
    fontWeight: FontWeight.bold,
  );
  static TextStyle uthman24Bold(BuildContext context) => TextStyle(
    fontSize: getResponsiveFontSize(context, fontSize: 24),
    color: Colors.white,
    fontFamily: fontUthmanTN1,
    fontWeight: FontWeight.bold,
  );
  static TextStyle uthman14Bold(BuildContext context) => TextStyle(
    fontSize: getResponsiveFontSize(context, fontSize: 18),
    color: Colors.white,
    fontFamily: fontUthmanTN1,
    fontWeight: FontWeight.bold,
  );
}

double getResponsiveFontSize(context, {required double fontSize}) {
  double scaleFactor = getScaleFactor(context);
  double responsiveFontSize = fontSize * scaleFactor;

  double lowerLimit = fontSize * .8;
  double upperLimit = fontSize * 1.4;

  return responsiveFontSize.clamp(lowerLimit, upperLimit);
}

double getScaleFactor(context) {
  var dispatcher = PlatformDispatcher.instance;
  var physicalWidth = dispatcher.views.first.physicalSize.width;
  var devicePixelRatio = dispatcher.views.first.devicePixelRatio;
  double width = physicalWidth / devicePixelRatio;

  //double width = MediaQuery.sizeOf(context).width;
  if (width < 1200) {
    return width / 550;
    // } else if (width < 1920) {
    //   return width / 1000;
    // }
  } else {
    return width / 1000;
  }
}
