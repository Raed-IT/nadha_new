import 'package:add_to_cart_animation/add_to_cart_animation.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:delevary/app/Data/MainController.dart';
import 'package:delevary/app/Route/Routs.dart';
import 'package:delevary/app/Screens/MainScaffoldSreen/MainScaffoldScreenController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class MainScaffoldScreen extends GetView<MainScaffoldScreenController> {
  const MainScaffoldScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => controller.buildScaffold(
          cartKey: controller.cartKey,
          scaffold: Scaffold(
            floatingActionButton: AddToCartIcon(
              key: controller.cartKey,
              badgeOptions: BadgeOptions(
                  active: Get.find<MainController>().cart.isNotEmpty),
              icon: FloatingActionButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(1000.sp),
                ),
                child: Center(
                  child: SvgPicture.asset(
                    "assets/svg/cart.svg",
                    width: 30.w,
                  ),
                ),
                onPressed: () =>Get.toNamed(AppRoutes.cartScreen),
                //params
              ).animate().slideY(begin: 1, duration: 700.ms),
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
              backgroundColor: Theme.of(context).colorScheme.surface,
              blurEffect: true,
              // leftCornerRadius: 15.sp,
              borderColor: Theme.of(context).colorScheme.secondary,
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
                  color:
                      isActive ? Theme.of(context).colorScheme.primary : null,
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
                                  borderRadius: BorderRadius.circular(500.sp)),
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
        ));
  }
}
