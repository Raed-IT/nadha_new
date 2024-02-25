import 'package:flutter/material.dart';

class DarkThemeData {
  // 2d1e42
  //322149
  //372450
  //3c2858
  //422c61
  static ThemeData them() {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: Color(0xff140f1f),
      brightness: Brightness.dark,
      cardTheme: CardTheme(
        elevation: 4,
        color: Color(0xff040007),
      ),
      textTheme: TextTheme(

      )
    );
  }
}
