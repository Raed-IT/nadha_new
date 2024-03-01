// ignore_for_file: unnecessary_overrides

import 'package:delevary/app/Data/MainController.dart';
import 'package:delevary/app/Route/Routs.dart';
import 'package:delevary/app/Thems/AppColots.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class IsLoginMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    if (Get.find<MainController>().token.value == null) {
      Fluttertoast.showToast(
        msg: "الرجاء تسجيل الدخول ",
        backgroundColor: AppColors.secondary,
        gravity: ToastGravity.TOP,
      );
      return const RouteSettings(name: AppRoutes.mainAuthScreen);
    }
    return null;
  }
}
