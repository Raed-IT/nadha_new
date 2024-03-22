import 'package:add_to_cart_animation/add_to_cart_animation.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:delevary/app/Data/MainController.dart';
import 'package:delevary/app/Route/Routs.dart';
import 'package:delevary/app/Screens/MainScaffoldSreen/MainScaffoldScreenController.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class MainScaffoldScreen extends GetView<MainScaffoldScreenController> {
  MainScaffoldScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var ctime;
    return WillPopScope(
      onWillPop: () {
        DateTime now = DateTime.now();
        if (controller.activePage.value == 0) {
          if (ctime == null || now.difference(ctime) > Duration(seconds: 1)) {
            //add duration of press gap
            ctime = now;
            Fluttertoast.showToast(
                msg: "اضغط مره اخرى للخروج",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                fontSize: 16.0.sp);
            return Future.value(false);
          }
          return Future.value(true);
        } else {
          controller.activePage.value = 0;
          return Future(() => false);
        }
      },
      child: Obx(() => controller.buildScaffold(
            cartKey: controller.cartKey,
            scaffold: Scaffold(
              floatingActionButton: AddToCartIcon(
                key: controller.cartKey,
                badgeOptions: BadgeOptions(
                    active: Get.find<MainController>().cart.isNotEmpty),
                icon: SizedBox(
                  height: 50.sp,
                  width: 50.sp,
                  child: FloatingActionButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(1000.sp),
                    ),
                    child: Center(
                      child: Lottie.asset(
                        "assets/json/cart.json",
                        width: 30.w,
                        reverse: true,
                      ),
                    ),
                    onPressed: () => Get.toNamed(AppRoutes.cartScreen),
                    //params
                  ).animate().slideY(begin: 1, duration: 700.ms),
                ),
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.endDocked,
              bottomNavigationBar: AnimatedBottomNavigationBar.builder(
                elevation: 5,
                gapLocation: GapLocation.end,
                activeIndex: controller.activePage.value,
                notchSmoothness: NotchSmoothness.smoothEdge,
                // blurEffect: true,
                // gapLocation: GapLocation.end,
                onTap: (index) => controller.onTap(index),
                //other params
                // activeColor: Colors.red,
                // splashRadius: 20,
                // height: 60.h,
                backgroundColor: Theme.of(context).colorScheme.primary,
                blurEffect: true,
                // leftCornerRadius: 15.sp,
                // borderColor: Theme.of(context).colorScheme.secondary,
                rightCornerRadius: 0,
                itemCount: controller.icons.length,
                tabBuilder: (int index, bool isActive) {
                  List<IconData> icons = controller.icons;
                  if (isActive) {
                    icons = controller.activeIcons;
                  }
                  final Widget icon = Icon(
                    icons[index],
                    size: 25.sp,
                    color: isActive
                        ? Theme.of(context).colorScheme.secondary
                        : Theme.of(context).colorScheme.background,
                  );
                  return isActive
                      ? Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              icon.animate().scale(
                                  end: Offset(1.5, 1.5),
                                  begin: Offset(1.1, 1.1),
                                  delay: 100.ms),
                              8.verticalSpace,
                              Container(
                                width: 40.w,
                                decoration: BoxDecoration(
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                    borderRadius:
                                        BorderRadius.circular(500.sp)),
                                height: 3.h,
                              )
                            ],
                          ),
                        )
                      : Container(child: icon);
                },
              ),
              body: controller.pages[controller.activePage.value],
            ),
          )),
    );
  }
}
