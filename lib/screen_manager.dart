import 'package:flutter/cupertino.dart';

enum ScreenType {
  EXTRA_SMALL,
  SMALL,
  MEDIUM,
  LARGE,
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
    } else {
      return ScreenType.LARGE;
    }
  }

  static double responsive(BuildContext context, {double value = 0, double xs, double sm, double, md, double lg}) {
    ScreenType type = get(context);
    if (type == ScreenType.EXTRA_SMALL) {
      return xs ?? value;
    } else if (type == ScreenType.SMALL) {
      return sm ?? value;
    } else if (type == ScreenType.MEDIUM) {
      return md ?? value;
    } else if (type == ScreenType.LARGE) {
      return lg ?? value;
    } else {
      return 0;
    }
  }
}
