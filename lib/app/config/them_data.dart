import 'package:flutter/material.dart';

class ThemConfig {
  static ThemeData createTheme() {
    return ThemeData(
      fontFamily: 'peyda',
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          color: Colors.white,
          fontSize: 26,
          fontWeight: FontWeight.w700,
        ),
        displayMedium: TextStyle(
            color: Colors.black, fontSize: 23, fontWeight: FontWeight.w700),
        titleMedium: TextStyle(
            color: Colors.black, fontSize: 18, fontWeight: FontWeight.w600),
        titleSmall: TextStyle(
            color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600),
        bodyLarge: TextStyle(
            color: Colors.black, fontSize: 16, fontWeight: FontWeight.w500),
        bodyMedium: TextStyle(
            color: Colors.black, fontSize: 13, fontWeight: FontWeight.w500),
        bodySmall: TextStyle(
            color: Colors.black, fontSize: 12, fontWeight: FontWeight.w500,letterSpacing: 0),
        labelMedium: TextStyle(
            color: Colors.black, fontSize: 12, fontWeight: FontWeight.w400,letterSpacing: 0),
        labelSmall: TextStyle(
            color: Colors.black, fontSize: 10, fontWeight: FontWeight.w400,letterSpacing: 0),
      ),
    );
  }
}