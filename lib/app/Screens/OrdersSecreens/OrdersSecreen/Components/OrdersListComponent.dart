import 'package:delevary/app/Components/LoadingComponents/CardLoadingComponent.dart';
import 'package:delevary/app/Data/Enums/OrderStatusEnum.dart';
import 'package:delevary/app/Screens/OrdersSecreens/OrdersSecreen/Components/card_component.dart';
import 'package:delevary/app/Screens/OrdersSecreens/OrdersSecreen/OrdersSecreenController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class OrdersListComponent extends GetView<OrdersScreenController> {
  const OrdersListComponent({super.key});

  @override
  Widget build(BuildContext context) {
    RxInt selectedTap = RxInt(1);
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Obx(
      () => !controller.isLoadPaginationData.value
          ? controller.paginationData.isNotEmpty
              ? Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(10.sp),
                      child: Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () => selectedTap.value = 0,
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: selectedTap.value == 0
                                          ? colorScheme.primary
                                          : colorScheme.onBackground,
                                    ),
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    "الطلبات السابقة",
                                    style: TextStyle(
                                        color: selectedTap.value == 0
                                            ? colorScheme.primary
                                            : colorScheme.onBackground,
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () => selectedTap.value = 1,
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                        color: selectedTap.value == 1
                                            ? colorScheme.primary
                                            : colorScheme.onBackground),
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    "الطلبات الحالية",
                                    style: TextStyle(
                                        color: selectedTap.value == 1
                                            ? colorScheme.primary
                                            : colorScheme.onBackground,
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    ...controller.paginationData
                        .where((p0) {
                          if (selectedTap.value == 0) {
                            return p0.status != OrderStatusEnum.onway &&  p0.status != OrderStatusEnum.pending  ;
                          }
                          return p0.status == OrderStatusEnum.onway || p0.status == OrderStatusEnum.pending;
                        })
                        .map((order) => CardOrderComponent(
                              order: order,
                              selectedTap: selectedTap,
                            ))
                        .toList()
                  ],
                )
              : noOrderWidget()
          : Padding(
              padding: EdgeInsets.all(10.sp),
              child: Column(
                children: List.generate(20, (index) => index)
                    .map(
                      (e) => CardLoadingComponent(
                        cardMargin: EdgeInsets.symmetric(vertical: 10.sp),
                        borderRadius: BorderRadius.circular(5.sp),
                        height: 100.h,
                      ),
                    )
                    .toList(),
              ),
            ),
    );
  }

  Widget noOrderWidget() {
    return Container();
  }
}
