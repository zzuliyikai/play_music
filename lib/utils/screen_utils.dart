import 'dart:ui';

import 'package:flutter/material.dart';

class ScreenUtils {
  static double dp = 0;

  static void init(double designWidth) {
    MediaQueryData mediaQueryData =
        MediaQueryData.fromView(PlatformDispatcher.instance.views.first);
    double width = mediaQueryData.size.width;

    dp = width / designWidth;
  }
}

extension Sizeing on int {
  double get dp => this * ScreenUtils.dp;
}
