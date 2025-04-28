import 'package:flutter/material.dart';

class EDeviceUtils {
  static double getBottomNavigationBarHeight() {
    return 80.0;
  }

  static double getAppBarHeight() {
    return kToolbarHeight;
  }

  static double getKeyboardHeight(BuildContext context) {
    return MediaQuery.of(context).viewInsets.bottom;
  }
}
