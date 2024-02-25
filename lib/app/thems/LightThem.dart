import 'package:delevary/app/thems/AppColots.dart';
import 'package:flutter/material.dart';

class LightThemeData {
  static ThemeData them() {
    return ThemeData(useMaterial3: true, primaryColor: AppColors.primary);
  }
}
