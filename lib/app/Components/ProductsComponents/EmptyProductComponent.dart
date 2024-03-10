import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class EmptyProductComponent extends StatelessWidget {
  const EmptyProductComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Get.width,
      width: Get.width,
      child: Column(
        children: [
          Lottie.asset("assets/json/empty_cube.json", repeat: false),
          Text(
            "لايوجد منتجات",
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.bold,
              fontSize: 15.sp,
            ),
          )
        ],
      ),
    );
  }
}
