// ignore_for_file: unnecessary_overrides

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nadha/app/data/inital/main_controller.dart';
import 'package:nadha/app/route/routs.dart';

class IsLoginMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    if (Get.find<MainController>().token.value == null) {
      return const RouteSettings(name: AppRoutes.AUTH_SCREEN);
    }
    return null;
  }
}
