import 'package:delevary/app/thems/ColorSchemes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LightThemeData {
  static ThemeData them() {
    return ThemeData(
      colorScheme: lightColorScheme,
      useMaterial3: true,
      fontFamily: "app",
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: Colors.transparent,
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: ButtonStyle(
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(15.sp),
              ),
            ),
          ),
        ),
      ),
      cardColor:Colors.white ,
      cardTheme: CardTheme(
          elevation: 3,
          shadowColor: lightColorScheme.primaryContainer,
          surfaceTintColor: Colors.white,
          color: Colors.white),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: lightColorScheme.onPrimary,
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: lightColorScheme.error),
          borderRadius: BorderRadius.all(
            Radius.circular(15.sp),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: lightColorScheme.onBackground),
          borderRadius: BorderRadius.all(
            Radius.circular(15.sp),
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: lightColorScheme.error),
          borderRadius: BorderRadius.all(
            Radius.circular(15.sp),
          ),
        ),
      ),
    );
  }
}
