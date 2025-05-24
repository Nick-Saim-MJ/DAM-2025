import 'package:flutter/material.dart';
class AppTheme {
  static Color colorX = Color(0xff99ff05);
  static List<Color> colorOptions = [
    Colors.purple,
    Colors.green,
    Colors.teal,
    Colors.yellow,
    Colors.orange,
    Colors.pink,
    colorX
  ];
  AppTheme._();
  static List<String> colorText = <String>[
  "Purple",
  "Green",
  "Teal",
  "Yellow",
  "Orange",
  "Pink",
  "Personalizado",
  ];
  static bool useMaterial3 = false;
  static bool useLightMode = true;
  static int colorSelected = 1;
  static ThemeData themeData = ThemeData(
      colorSchemeSeed: AppTheme.colorOptions[AppTheme.colorSelected],
      useMaterial3: AppTheme.useMaterial3,
      brightness: AppTheme.useLightMode ? Brightness.light : Brightness.dark);
}