import 'package:delevary/app/Thems/ColorSchemes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DarkThemeData {
  // 2d1e42
  //322149
  //372450
  //3c2858
  //422c61
  static ThemeData them() {
    return ThemeData(
      colorScheme: darkColorScheme,
      useMaterial3: true,
      fontFamily: "app",
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: darkColorScheme.onPrimary,
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: darkColorScheme.error),
          borderRadius: BorderRadius.all(
            Radius.circular(15.sp),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: darkColorScheme.onBackground),
          borderRadius: BorderRadius.all(
            Radius.circular(15.sp),
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: darkColorScheme.error),
          borderRadius: BorderRadius.all(
            Radius.circular(15.sp),
          ),
        ),
      ),
    );
  }
}
