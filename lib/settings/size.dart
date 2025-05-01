import 'package:flutter/material.dart';

// Create a utility class for screen dimensions
class ScreenSize {
  static double width = 0;
  static double height = 0;

  static void init(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    width = mediaQuery.size.width;
    height = mediaQuery.size.height;
  }
}
