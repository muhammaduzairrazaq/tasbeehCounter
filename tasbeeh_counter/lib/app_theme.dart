import 'package:flutter/material.dart';

class AppTheme {
  static Color textcolor = Colors.green;

  static void updateThemeColor(Color color) {
    textcolor = color;
  }
}

class BackgroundImage {
  static String imagepath = 'assets/tbk1.png';

  static void updateBackgroundImage(String path) {
    imagepath = path;
  }
}
