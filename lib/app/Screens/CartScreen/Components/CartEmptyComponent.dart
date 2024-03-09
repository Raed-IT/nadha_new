import 'package:delevary/app/Route/Routs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class CartEmptyComponent extends StatelessWidget {
  const CartEmptyComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Get.width + 100,
      width: Get.width,
      child: Column(
        children: [
          Lottie.asset("assets/json/cart_empty.json",
              height: Get.width - 80.h, fit: BoxFit.cover, width: Get.width),
          Text(
            "لايوجد عناصر في السلة ",
            style: TextStyle(color: Theme.of(context).colorScheme.primary),
          ),
        ],
      ),
    );
  }
}
