import 'package:flutter/material.dart';

class AppTheme {
  static Color textcolor =   const Color.fromARGB(255, 37, 37, 37);
  static double opacity  = 0.8;
  static bool sound = false;
  static bool vibrate = false;

  static void updateThemeColor(Color color) {
    textcolor = color;
  }
  static void updateOpacity(double value) {
    opacity = value;
  }
  static void updateSound(bool value) {
    sound = value;
  }
  static void updateVibrate(bool value) {
    vibrate = value;
  }
}

class BackgroundImage {
  static String imagepath = 'assets/nnldb.png';

  static void updateBackgroundImage(String path) {
    imagepath = path;
  }
}
