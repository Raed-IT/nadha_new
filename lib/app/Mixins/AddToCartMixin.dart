import 'package:add_to_cart_animation/add_to_cart_animation.dart';
import 'package:delevary/app/Data/MainController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

mixin AddToCartMixin {
  late Function(GlobalKey) _runAddToCartAnimation;

  void addToCartAnimation(GlobalKey widgetKey) async {
    await _runAddToCartAnimation(widgetKey);
    await Get.find<MainController>()
        .cartKey
        .currentState!
        .runCartAnimation("${Get.find<MainController>().cart.length}");
  }

  Widget buildScaffold({required Widget scaffold}) {
    return AddToCartAnimation(
      cartKey: Get.find<MainController>().cartKey,
      dragAnimation: const DragToCartAnimationOptions(
        rotation: false,
      ),
      height: 30.sp,
      width: 30.sp,
      opacity: 0.5,
      createAddToCartAnimation: (runAddToCartAnimation) {
        // You can run the animation by addToCartAnimationMethod, just pass trough the the global key of  the image as parameter
        _runAddToCartAnimation = runAddToCartAnimation;
      },
      child: scaffold,
    );
  }
}
