import 'dart:ui';

class AppScaleConfig {
  static const double designWidth = 384.0;

  static double scaleFactor(Size deviceSize) {
    if (deviceSize.width <= 0) return 1.0;
    return deviceSize.width / designWidth;
  }
}