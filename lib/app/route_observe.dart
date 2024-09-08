import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:nadha/app/data/inital/main_controller.dart';
import 'package:nadha/app/pages/product_details_screen/product_details_controller.dart';
import 'package:nadha/app/route/routs.dart';

class MainRouteObserver extends RouteObserver<PageRoute<dynamic>> {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) =>
      checkRoute();

  @override
  void didPop(Route route, Route? previousRoute) => checkRoute();

  @override
  void didRemove(Route route, Route? previousRoute) => checkRoute();

  void checkRoute({bool isDelete = false}) {
    if (Get.currentRoute == AppRoutes.PRODUCT_DETAILS &&
        Get.isRegistered<ProductDetailsController>()) {
      Get.delete<ProductDetailsController>();
    }
    switch (Get.currentRoute) {
      case AppRoutes.HOME_SCREEN:
        Get.find<MainController>().currentBottomNavIndex.value = 2;
        Get.toNamed(AppRoutes.HOME_SCREEN);
        break;
      case AppRoutes.OFFER_SCREEN:
        Get.toNamed(AppRoutes.OFFER_SCREEN);
        Get.find<MainController>().currentBottomNavIndex.value = 1;
        break;
      case AppRoutes.ORDERS_SCREEN:
        Get.toNamed(AppRoutes.ORDERS_SCREEN);
        Get.find<MainController>().currentBottomNavIndex.value = 0;
        break;
    }
  }
}
