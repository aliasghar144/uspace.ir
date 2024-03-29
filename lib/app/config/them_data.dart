import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uspace_ir/app/config/app_colors.dart';

class ThemConfig {
  static ThemeData createTheme() {
    return ThemeData(
      colorScheme: const ColorScheme.light(primary: AppColors.mainColor),
      indicatorColor: AppColors.mainColor,
      fontFamily: 'iransans',
      scaffoldBackgroundColor: Colors.white,
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: Colors.transparent,
      ),
      appBarTheme: const AppBarTheme(
        elevation: 0,color: Colors.white,centerTitle: false,
      ),
      textTheme: TextTheme(
        displayLarge: TextStyle(
          color: AppColors.primaryTextColor,
          fontSize: 24.sp,
          fontWeight: FontWeight.w700,
        ),
        displayMedium: TextStyle(
            color: AppColors.primaryTextColor, fontSize: 14.sp, fontWeight: FontWeight.w700),
        displaySmall: TextStyle(
            color: AppColors.primaryTextColor, fontSize: 12.sp, fontWeight: FontWeight.w700),
        bodyLarge: TextStyle(
            color: AppColors.primaryTextColor, fontSize: 14.sp, fontWeight: FontWeight.w500),
        bodyMedium: TextStyle(
            color: AppColors.primaryTextColor, fontSize: 12.sp, fontWeight: FontWeight.w500),
        bodySmall: TextStyle(
            color: AppColors.primaryTextColor,
            fontSize: 10.sp,
            fontWeight: FontWeight.w500,
            letterSpacing: 0),
        labelLarge: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w400,
            letterSpacing: 0),
        labelMedium: TextStyle(
            fontSize: 10.sp,
            fontWeight: FontWeight.w400,
            letterSpacing: 0),
        labelSmall: TextStyle(
            fontSize: 8.sp,
            fontWeight: FontWeight.w400,
            letterSpacing: 0),
        titleLarge: TextStyle(
            fontSize: 12.sp,fontWeight: FontWeight.w300,letterSpacing: 0,
        ),
        titleMedium: TextStyle(
            height: 2,
            fontSize: 10.sp,fontWeight: FontWeight.w300,letterSpacing: 0,
        ),
        titleSmall:
        TextStyle(
          height: 2,
          fontSize: 10.sp,fontWeight: FontWeight.w200,letterSpacing: 0,
        ),
      ),
    );
  }
}
