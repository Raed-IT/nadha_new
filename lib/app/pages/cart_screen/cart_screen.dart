import 'package:card_loading/card_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:nadha/app/data/inital/main_controller.dart';
import 'package:nadha/app/pages/cart_screen/cart_controller.dart';
import 'package:nadha/app/pages/cart_screen/componnets/build_card.dart';
import 'package:nadha/app/pages/cart_screen/componnets/total_component.dart';
import 'package:nadha/app/pages/components/appbar.dart';
import 'package:nadha/app/pages/components/bottom_nav_component.dart';

class CartScreen extends GetView<CartScreenController> {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      bottomNavigationBar: const BottomNavComponent(),
      body: SizedBox(
        width: Get.width,
        height: Get.height,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: SizedBox(
                height: Get.height,
                width: Get.width,
                child: Column(
                  children: [
                    const AppBarComponent(
                      title: "السلة ",
                      isShowCart: false,
                    ),
                    Obx(
                      () => (controller.isLoad.value)
                          ? Expanded(
                              child: SingleChildScrollView(
                                physics: const BouncingScrollPhysics(),
                                child: Column(
                                  children: List.generate(100, (index) => index)
                                      .map(
                                        (e) => Opacity(
                                          opacity: 0.5,
                                          child: CardLoading(
                                            margin: EdgeInsets.all(10.w),
                                            height: 100.h,
                                            width: Get.width,
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(10.sp),
                                            ),
                                          ),
                                        ),
                                      )
                                      .toList()
                                      .animate()
                                      .scale(
                                        duration:
                                            const Duration(milliseconds: 200),
                                      ),
                                ),
                              ),
                            )
                          : Obx(
                              () => (Get.find<MainController>()
                                      .cartItems
                                      .isNotEmpty)
                                  ? Expanded(
                                      child: AnimatedList(
                                        key: controller.lisKey,
                                        physics: const BouncingScrollPhysics(),
                                        initialItemCount:
                                            Get.find<MainController>()
                                                .cartItems
                                                .length,
                                        itemBuilder: (BuildContext context,
                                            int index,
                                            Animation<double> animation) {
                                          return BuildCardCartItemComponent(
                                            animation: animation,
                                            index: index,
                                            cartItem: Get.find<MainController>()
                                                .cartItems[index],
                                          );
                                        },
                                      ),
                                    )
                                  : SizedBox(
                                      height: 300.h,
                                      child: Column(
                                        children: [
                                          Expanded(
                                            child: Lottie.asset(
                                              'assets/json/nodata.json',
                                            ),
                                          ),
                                          Text(
                                            "لايوجد منتجات ",
                                            style: TextStyle(
                                                fontSize: 22.sp,
                                                fontWeight: FontWeight.bold),
                                          )
                                        ],
                                      ),
                                    ).animate().slide(
                                        begin: const Offset(0, 0.3),
                                      ),
                            ),
                    ),
                    Obx(() {
                      bool condetion = !controller.isLoad.value;
                      return Visibility(
                        visible: condetion,
                        child: AnimatedContainer(
                          duration: const Duration(seconds: 2),
                          height: condetion ? 250.h : 0,
                        ),
                      );
                    })
                  ],
                ),
              ),
            ),
            Obx(
              () => Visibility(
                visible: Get.find<MainController>().cartItems.isNotEmpty &&
                    !controller.isLoad.value,
                child: const TotalCartScreenComponent().animate().slideY(
                      begin: 1,
                      duration: const Duration(milliseconds: 300),
                    ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
