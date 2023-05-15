import 'package:flutter/material.dart';
import 'package:uspace_ir/app/config/app_colors.dart';

class ThemConfig {
  static ThemeData createTheme() {
    return ThemeData(
      fontFamily: 'iransans',
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: AppBarTheme(
        elevation: 0,color: Colors.white,centerTitle: false,
      ),
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          color: AppColors.primaryTextColor,
          fontSize: 26,
          fontWeight: FontWeight.w700,
        ),
        displayMedium: TextStyle(
            color: AppColors.primaryTextColor, fontSize: 14, fontWeight: FontWeight.w700),
          displaySmall: TextStyle(
              color: AppColors.primaryTextColor, fontSize: 12, fontWeight: FontWeight.w700),
        bodyLarge: TextStyle(
            color: AppColors.primaryTextColor, fontSize: 16, fontWeight: FontWeight.w500),
        bodyMedium: TextStyle(
            color: AppColors.primaryTextColor, fontSize: 14, fontWeight: FontWeight.w500),
        bodySmall: TextStyle(
            color: AppColors.primaryTextColor,
            fontSize: 12,
            fontWeight: FontWeight.w500,
            letterSpacing: 0),
        labelLarge: TextStyle(
            color: AppColors.primaryTextColor,
            fontSize: 14,
            fontWeight: FontWeight.w400,
            letterSpacing: 0),
        labelMedium: TextStyle(
            color: AppColors.primaryTextColor,
            fontSize: 12,
            fontWeight: FontWeight.w400,
            letterSpacing: 0),
        labelSmall: TextStyle(
            fontSize: 10,
            color: AppColors.primaryTextColor,
            fontWeight: FontWeight.w400,
            letterSpacing: 0),
      ),
    );
  }
}
