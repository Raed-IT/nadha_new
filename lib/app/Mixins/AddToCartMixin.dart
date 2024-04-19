import 'package:add_to_cart_animation/add_to_cart_animation.dart';
import 'package:delevary/app/Data/MainController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

mixin AddToCartMixin {
  late Function(GlobalKey) _runAddToCartAnimation;

  void addToCartAnimation(
      {required GlobalKey widgetKey,
      required GlobalKey<CartIconKey> cartKey}) async {
    try {
      await _runAddToCartAnimation(
        widgetKey,
      );
      await cartKey.currentState!.runCartAnimation(
        "${Get.find<MainController>().cart.length}",
      );
    } catch (e, s) {
      Logger().e("$e   \n  $s");
    }
  }

  Widget buildScaffold(
      {required Widget scaffold, required GlobalKey<CartIconKey> cartKey}) {
    return AddToCartAnimation(
      cartKey: cartKey,
      dragAnimation: DragToCartAnimationOptions(
          rotation: false, duration: 400.ms, curve: Curves.elasticOut),
      height: 20.sp,
      width: 20.sp,
      opacity: 0.9,
      jumpAnimation: JumpAnimationOptions(duration: 500.ms),
      createAddToCartAnimation: (runAddToCartAnimation) {
        _runAddToCartAnimation = runAddToCartAnimation;
      },
      child: scaffold,
    );
  }
}
