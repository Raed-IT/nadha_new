import 'dart:typed_data';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:nadha/app/data/inital/main_controller.dart';
import 'package:nadha/app/pages/components/order_invoice.dart';
import 'package:nadha/app/pages/order_details_screen/order_details_controller.dart';
import 'package:nadha/app/them/app_colors.dart';

import '../components/appbar.dart';
import '../components/bottom_nav_component.dart';
import '../components/drawer_component.dart';
import '../components/image_cache_component.dart';

class OrderDetailsScreen extends GetView<OrderDetailsScreenController> {
  const OrderDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton:
          (Get.find<MainController>().user.value?.level == "admin")
              ? FloatingActionButton(
                  child: Icon(
                    Icons.inventory_2_outlined,
                    size: 20.sp,
                  ),
                  onPressed: () => showOrderInvoice(controller.order),
                  backgroundColor: AppColors.warning)
              : Container(),
      extendBody: true,
      endDrawer:   DrawerComponent(),
      bottomNavigationBar: BottomNavComponent(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppBarComponent(title: "تفاصيل الطلب "),
          SizedBox(
            height: 10.h,
          ),
          Padding(
            padding: EdgeInsets.all(10.sp),
            child: ListTile(
              title: Text(
                "○  رقم الطلب : ${controller.order.orderNo}",
                style: TextStyle(fontSize: 15.sp),
              ),
              subtitle: Text(controller.order.address?.address ?? ''),
            ),
          ),
          Visibility(
            visible: (controller.order.address?.latitude != null &&
                    controller.order.address?.longitude != null) &&
                Get.find<MainController>().user.value?.level == "driver",
            child: SizedBox(
              height: 250.h,
              width: Get.width,
              child: GoogleMap(
                myLocationButtonEnabled: true,
                myLocationEnabled: true,
                markers: controller.markers.toSet(),
                initialCameraPosition: controller.cameraPosition!,
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.all(10.sp),
                child: Column(
                  children: controller.order.items!
                      .map(
                        (item) {
                          return Container(
                            margin: EdgeInsets.symmetric(vertical: 5.h),
                            height: controller.isStore ? 155.h : 120.h,
                            width: Get.width,
                            child: Card(
                              elevation: 7,
                              shadowColor: AppColors.highlight.withOpacity(0.5),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10.sp),
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(8.sp),
                                child: SizedBox(
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(10.sp),
                                        ),
                                        child: ImageCacheComponent(
                                          width: 90.sp,
                                          height:
                                              controller.isStore ? 115 : 105.h,
                                          image: "${item.product?.img}",
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10.w,
                                      ),
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      AutoSizeText(
                                                        maxLines: 1,
                                                        "${item.product?.name ?? ''} ",
                                                        style: TextStyle(
                                                            fontSize: 15.sp,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                      ),
                                                      AutoSizeText(
                                                        maxLines: 1,
                                                        "${item.store}",
                                                        style: TextStyle(
                                                          fontSize: 11.sp,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                Text(
                                                  item.totalPrice!
                                                      .toStringAsFixed(2),
                                                  style: TextStyle(
                                                      color: AppColors.danger,
                                                      fontSize: 15.sp),
                                                )
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Container(
                                                  decoration: BoxDecoration(
                                                    color: AppColors.highlight,
                                                    borderRadius:
                                                        BorderRadius.all(
                                                      Radius.circular(10.sp),
                                                    ),
                                                    border: Border.all(
                                                        color:
                                                            AppColors.warning),
                                                  ),
                                                  constraints: BoxConstraints(
                                                      minWidth: 70.w,
                                                      minHeight: 30.h),
                                                  child: Center(
                                                    child: Text(item.quantity!
                                                        .toStringAsFixed(2)),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 10.sp),
                                                  child: Text(
                                                    "${item.product?.unitName}",
                                                    style: TextStyle(
                                                        color:
                                                            AppColors.success,
                                                        fontSize: 10.sp),
                                                  ),
                                                )
                                              ],
                                            ),
                                            if (item.status!.value ==
                                                    "pending" &&
                                                Get.find<MainController>()
                                                    .isStore)
                                              Divider(
                                                thickness: 1.5.sp,
                                              ),
                                            Obx(() => (item.status!.value ==
                                                        "pending" &&
                                                    Get.find<MainController>()
                                                        .isStore)
                                                ? Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      GestureDetector(
                                                        onTap: () => controller
                                                            .changeState(
                                                                item, "finish"),
                                                        child: Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            color: AppColors
                                                                .success,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5.sp),
                                                          ),
                                                          height: 30.h,
                                                          width: 100.w,
                                                          child: Center(
                                                            child: Text(
                                                              "جاهزة للإرسال ",
                                                              style: TextStyle(
                                                                  color: AppColors
                                                                      .scaffold,
                                                                  fontSize:
                                                                      15.sp),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      GestureDetector(
                                                        onTap: () => controller
                                                            .changeState(item,
                                                                "canceled"),
                                                        child: Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            color: AppColors
                                                                .danger,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5.sp),
                                                          ),
                                                          height: 30.h,
                                                          width: 100.w,
                                                          child: Center(
                                                            child: Text(
                                                              "غير متوفر ",
                                                              style: TextStyle(
                                                                  color: AppColors
                                                                      .scaffold,
                                                                  fontSize:
                                                                      15.sp),
                                                            ),
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  )
                                                : Container())
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      )
                      .toList()
                      .animate()
                      .scale(duration: 400.ms),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 70.h,
          ),
        ],
      ),
    );
  }
}
