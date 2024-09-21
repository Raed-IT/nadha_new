import 'package:delevary/app/Data/MainController.dart';
import 'package:delevary/app/Route/Routs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class IsReadStarterPagesMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    if (!Get.find<MainController>().isReadStarterPages) {
      return const RouteSettings(name: AppRoutes.starterPages);
    }
    return null;
  }
}
