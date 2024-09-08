import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:nadha/app/data/inital/main_controller.dart';
import 'package:nadha/app/data/model/order_model.dart';
import 'package:nadha/app/pages/components/order_invoice.dart';
import 'package:nadha/app/pages/orders_screen/components/show_order_state_bottomsheet.dart';
import 'package:nadha/app/pages/orders_screen/orders_controller.dart';
import 'package:nadha/app/route/routs.dart';
import 'package:nadha/app/them/app_colors.dart';

class BuildCardOrderComponent extends GetView<OrdersScreenController> {
  Rx<OrderModel> order;
  final bool? isShowUpdateOrderButton;

  BuildCardOrderComponent(
      {super.key, required this.order, this.isShowUpdateOrderButton = false});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SizedBox(
        height: 170.h,
        width: Get.width,
        child: Card(
          margin: EdgeInsets.all(18.sp),
          elevation: 7,
          shadowColor: AppColors.highlight.withOpacity(0.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10.sp),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(8.sp),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("رقم الطلب :  ${order.value.orderNo}"),
                    Text("حالة الطلب : ${order.value.status}")
                  ],
                ),
                SizedBox(
                  height: 10.h,
                ),
                Text("القيمة الإجمالية : ${order.value.total}"),
                SizedBox(
                  height: 10.h,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (!Get.isRegistered<OrdersScreenController>()) {
                          Get.put(OrdersScreenController());
                        }
                        Get.toNamed(AppRoutes.ORDER_DETAILS, arguments: {
                          "order": order.value,
                          "isStore": controller.isStore
                        });
                      },
                      child: Container(
                        width: 100.w,
                        height: 30.h,
                        decoration: BoxDecoration(
                          color: AppColors.warning,
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.sp),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            "تفاصيل الطلب ",
                            style: TextStyle(
                                color: AppColors.scaffold, fontSize: 14.sp),
                          ),
                        ),
                      ),
                    ).animate().scale(duration: 300.ms),
                    if (Get.find<MainController>().user.value?.level == "admin")
                      GestureDetector(
                        onTap: () {
                          showOrderInvoice(order.value);
                        },
                        child: Container(
                          width: 100.w,
                          height: 30.h,
                          decoration: BoxDecoration(
                            color: AppColors.success,
                            borderRadius: BorderRadius.all(
                              Radius.circular(10.sp),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              "عرض الفاتورة ",
                              style: TextStyle(
                                  color: AppColors.scaffold, fontSize: 14.sp),
                            ),
                          ),
                        ),
                      ).animate().scale(duration: 300.ms),
                    if (isShowUpdateOrderButton!)
                      GestureDetector(
                        onTap: () async {
                          await showOrderStateBottomSheet(
                              users: controller.users,
                              order: order,
                              context: context,
                              onSaved: (OrderModel t) {
                                order.value = t;
                              });
                        },
                        child: Container(
                          width: 100.w,
                          height: 30.h,
                          decoration: BoxDecoration(
                            color: AppColors.dark,
                            borderRadius: BorderRadius.all(
                              Radius.circular(10.sp),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              order.value.driverId == null
                                  ? "اختر  السائق"
                                  : "تعديل حالة الطلب    ",
                              style: TextStyle(
                                  color: AppColors.scaffold, fontSize: 14.sp),
                            ),
                          ),
                        ),
                      ).animate().scale(duration: 300.ms),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
