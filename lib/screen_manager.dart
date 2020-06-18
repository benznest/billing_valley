import 'package:flutter/cupertino.dart';

enum ScreenType {
  EXTRA_SMALL,
  SMALL,
  MEDIUM,
  LARGE,
  EXTRA_LARGE,
}

class ScreenManager {
  static ScreenType get(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    if (width < 768) {
      return ScreenType.EXTRA_SMALL;
    } else if (width <= 992) {
      return ScreenType.SMALL;
    } else if (width <= 1200) {
      return ScreenType.MEDIUM;
    } else if (width <= 1800) {
      return ScreenType.LARGE;
    } else {
      return ScreenType.EXTRA_LARGE;
    }
  }

  static double responsive(BuildContext context, {double value = 0, double xs, double sm, double, md, double lg, double xl}) {
    ScreenType type = get(context);
    if (type == ScreenType.EXTRA_SMALL) {
      return xs ?? value;
    } else if (type == ScreenType.SMALL) {
      return sm ?? value;
    } else if (type == ScreenType.MEDIUM) {
      return md ?? value;
    } else if (type == ScreenType.LARGE) {
      return lg ?? value;
    } else if (type == ScreenType.EXTRA_LARGE) {
      return xl ?? value;
    } else {
      return value;
    }
  }
}
