import 'package:card_loading/card_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:nadha/app/pages/components/bottom_nav_component.dart';
import 'package:nadha/app/pages/drover_order_details_screen/driver_order_details_controller.dart';

import '../components/appbar.dart';
import '../orders_screen/components/build_card_component.dart';

class DriverOrderDetailsScreen
    extends GetView<DriverOrderDetailsScreenController> {
  @override
  Widget build(BuildContext context) {
    return controller.buildScreen(
      extendBody: true,
      bottomNavigationBar: BottomNavComponent(),
      widgets: [
        SliverToBoxAdapter(
          child: Obx(
            () => (controller.isLoadPagination.value)
                ? Column(
                    children: List.generate(100, (index) => index)
                        .map(
                          (e) => Opacity(
                            opacity: 0.5,
                            child: CardLoading(
                              margin: EdgeInsets.all(10.w),
                              height: 170.h,
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
                          duration: const Duration(milliseconds: 200),
                        ),
                  )
                : (controller.paginationData.isNotEmpty)
                    ? Column(
                        children: controller.paginationData
                            .map(
                              (order) => BuildCardOrderComponent(
                                  order: Rx(order),
                                  isShowUpdateOrderButton: controller
                                      .isShowUpdateOrderButtonPermission),
                            )
                            .toList()
                            .animate()
                            .slideY(
                              begin: 1,
                              duration: 300.ms,
                            )
                            .scale(),
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
                                  fontSize: 22.sp, fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ).animate().slide(
                          begin: const Offset(0, 0.3),
                        ),
          ),
        )
      ],
      appBar: SliverToBoxAdapter(
        child: AppBarComponent(
          title: "طلبات التوصيل",
        ),
      ),
    );
  }
}
