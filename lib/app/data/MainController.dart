import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainController extends GetxController {
  Rx<ThemeMode> themeMode = Rx(ThemeMode.light);
}
